/*
  Warnings:

  - You are about to drop the column `areaId` on the `Message` table. All the data in the column will be lost.
  - The primary key for the `Session` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `sessionId` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the `Area` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `AreaUser` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `channelId` to the `Message` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Area" DROP CONSTRAINT "fkAreaOwner";

-- DropForeignKey
ALTER TABLE "AreaUser" DROP CONSTRAINT "fkAreaUserArea";

-- DropForeignKey
ALTER TABLE "AreaUser" DROP CONSTRAINT "fkAreaUserUser";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "fkMessageArea";

-- AlterTable
ALTER TABLE "Message" DROP COLUMN "areaId",
ADD COLUMN     "channelId" BIGINT NOT NULL;

-- AlterTable
ALTER TABLE "Session" DROP CONSTRAINT "pkSession",
DROP COLUMN "sessionId",
ADD COLUMN     "id" BIGSERIAL NOT NULL,
ADD CONSTRAINT "pkSession" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "Area";

-- DropTable
DROP TABLE "AreaUser";

-- CreateTable
CREATE TABLE "Channel" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "ownerId" BIGINT NOT NULL,

    CONSTRAINT "pkChannel" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChannelUser" (
    "channelId" BIGINT NOT NULL,
    "userId" BIGINT NOT NULL,

    CONSTRAINT "pkChannelUser" PRIMARY KEY ("channelId","userId")
);

-- CreateIndex
CREATE UNIQUE INDEX "akChannelName" ON "Channel"("name");

-- RenameForeignKey
ALTER TABLE "Session" RENAME CONSTRAINT "fkSessionAccount" TO "fkSessionUser";

-- AddForeignKey
ALTER TABLE "Channel" ADD CONSTRAINT "fkChannelOwner" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ChannelUser" ADD CONSTRAINT "fkChannelUserChannel" FOREIGN KEY ("channelId") REFERENCES "Channel"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ChannelUser" ADD CONSTRAINT "fkChannelUserUser" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "fkMessageChannel" FOREIGN KEY ("channelId") REFERENCES "Channel"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
