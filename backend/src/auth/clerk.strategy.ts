// src/auth/clerk.strategy.ts

import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-custom';
import { Request } from 'express';
import { Clerk } from '@clerk/backend';

@Injectable()
export class ClerkStrategy extends PassportStrategy(Strategy, 'clerk') {
    private clerkClient = Clerk({
        secretKey: process.env.CLERK_SECRET_KEY,
    });

    async validate(req: Request): Promise<any> {
        const authHeader = req.headers.authorization;

        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            throw new UnauthorizedException('Invalid or missing authorization header');
        }

        const token = authHeader.split(' ')[1];

        try {
            const session = await this.clerkClient.verifySessionToken(token);

            if (!session || !session.userId) {
                throw new UnauthorizedException('Invalid token session');
            }

            const user = await this.clerkClient.users.getUser(session.userId);

            return {
                id: user.id,
                email: user.emailAddresses?.[0]?.emailAddress,
                firstName: user.firstName,
                lastName: user.lastName,
                clerkRaw: user, // optional: attach full user object
            };
        } catch (error) {
            console.error('Token validation failed:', error);
            throw new UnauthorizedException('Token validation failed');
        }
    }
}
