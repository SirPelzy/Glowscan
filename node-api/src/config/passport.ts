import passport from 'passport';
import { Strategy as JwtStrategy, ExtractJwt } from 'passport-jwt';
import { Strategy as LocalStrategy } from 'passport-local';
import { Strategy as FacebookStrategy } from 'passport-facebook';
import { Strategy as LinkedInStrategy } from 'passport-linkedin-oauth2';
// Note: passport-apple requires more complex setup, including private keys.
// import { Strategy as AppleStrategy } from 'passport-apple'; 

import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcrypt';

const prisma = new PrismaClient();

// JWT Strategy: For protecting routes with a token
passport.use(
  new JwtStrategy(
    {
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET || 'your_default_secret',
    },
    async (jwtPayload, done) => {
      try {
        const user = await prisma.user.findUnique({ where: { id: jwtPayload.id } });
        if (user) {
          return done(null, user);
        }
        return done(null, false);
      } catch (error) {
        return done(error, false);
      }
    }
  )
);

// Local Strategy: For email and password login
passport.use(
  new LocalStrategy(
    { usernameField: 'email' },
    async (email, password, done) => {
      try {
        const user = await prisma.user.findUnique({ where: { email } });
        if (!user || !user.password) {
          return done(null, false, { message: 'Incorrect email or password.' });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
          return done(null, false, { message: 'Incorrect email or password.' });
        }
        return done(null, user);
      } catch (error) {
        return done(error);
      }
    }
  )
);

// Facebook Strategy
passport.use(
  new FacebookStrategy(
    {
      clientID: process.env.FACEBOOK_APP_ID!,
      clientSecret: process.env.FACEBOOK_APP_SECRET!,
      callbackURL: '/api/auth/facebook/callback',
      profileFields: ['id', 'emails', 'name'],
    },
    async (accessToken, refreshToken, profile, done) => {
      try {
        const email = profile.emails?.[0].value;
        if (!email) {
            return done(new Error("Facebook account doesn't have an email."), false);
        }

        let user = await prisma.user.findUnique({ where: { email } });

        if (user) {
          // Link account if user exists
          await prisma.socialAccount.upsert({
              where: { provider_providerId: { provider: 'facebook', providerId: profile.id } },
              update: {},
              create: { userId: user.id, provider: 'facebook', providerId: profile.id }
          });
          return done(null, user);
        }

        // Create new user if they don't exist
        const newUser = await prisma.user.create({
            data: {
                email: email,
                firstName: profile.name?.givenName,
                lastName: profile.name?.familyName,
                socialAccounts: {
                    create: {
                        provider: 'facebook',
                        providerId: profile.id,
                    },
                },
            },
        });
        return done(null, newUser);
      } catch (error: any) {
        return done(error);
      }
    }
  )
);

// LinkedIn Strategy
passport.use(
    new LinkedInStrategy(
      {
        clientID: process.env.LINKEDIN_API_KEY!,
        clientSecret: process.env.LINKEDIN_SECRET_KEY!,
        callbackURL: "/api/auth/linkedin/callback",
        scope: ['r_emailaddress', 'r_liteprofile'],
      },
      async (accessToken, refreshToken, profile, done) => {
        try {
            const email = profile.emails[0].value;
            if (!email) {
                return done(new Error("LinkedIn account doesn't have an email."), false);
            }

            let user = await prisma.user.findUnique({ where: { email } });

            if (user) {
                await prisma.socialAccount.upsert({
                    where: { provider_providerId: { provider: 'linkedin', providerId: profile.id } },
                    update: {},
                    create: { userId: user.id, provider: 'linkedin', providerId: profile.id }
                });
                return done(null, user);
            }
            
            const newUser = await prisma.user.create({
                data: {
                    email: email,
                    firstName: profile.name.givenName,
                    lastName: profile.name.familyName,
                    socialAccounts: {
                        create: {
                            provider: 'linkedin',
                            providerId: profile.id,
                        },
                    },
                }
            });
            return done(null, newUser);
        } catch (error: any) {
            return done(error);
        }
      }
    )
);

// Note on Apple Strategy:
// passport-apple setup is more involved. It requires generating a private key from your Apple Developer account
// and using a library like `jsonwebtoken` to sign your client secret.
// The setup would look something like this, but requires the actual key.
/*
passport.use(
  new AppleStrategy(
    {
      clientID: process.env.APPLE_CLIENT_ID!,
      teamID: process.env.APPLE_TEAM_ID!,
      keyID: process.env.APPLE_KEY_ID!,
      privateKeyString: process.env.APPLE_PRIVATE_KEY!.replace(/\\n/g, '\n'),
      callbackURL: '/api/auth/apple/callback',
      scope: ['name', 'email'],
    },
    (accessToken, refreshToken, idToken, profile, done) => {
        // Find or create user logic here
    }
));
*/

export default passport;
