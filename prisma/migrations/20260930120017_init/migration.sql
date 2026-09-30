/*
  Warnings:

  - You are about to drop the `Palestrantes` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `local` on the `Eventos` table. All the data in the column will be lost.
  - You are about to drop the column `nome` on the `Eventos` table. All the data in the column will be lost.
  - Added the required column `name` to the `Eventos` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Palestrantes_email_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Palestrantes";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Palestrante" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Eventos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "descricao" TEXT NOT NULL,
    "palestranteId" INTEGER,
    CONSTRAINT "Eventos_palestranteId_fkey" FOREIGN KEY ("palestranteId") REFERENCES "Palestrante" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Eventos" ("data", "descricao", "id") SELECT "data", "descricao", "id" FROM "Eventos";
DROP TABLE "Eventos";
ALTER TABLE "new_Eventos" RENAME TO "Eventos";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "Palestrante_email_key" ON "Palestrante"("email");
