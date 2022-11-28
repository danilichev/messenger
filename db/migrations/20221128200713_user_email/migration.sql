/*
  Warnings:

  - You are about to drop the column `login` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `email` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "akUserLogin";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "login",
ADD COLUMN     "email" VARCHAR(64) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "akUserEmail" ON "User"("email");