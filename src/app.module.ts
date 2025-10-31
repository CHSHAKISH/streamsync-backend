// src/app.module.ts
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { VideosModule } from './videos/videos.module';
import { PrismaModule } from './prisma/prisma.module'; // <-- IMPORT THIS

@Module({
  imports: [AuthModule, VideosModule, PrismaModule], // <-- ADD PRISMAMODULE
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}