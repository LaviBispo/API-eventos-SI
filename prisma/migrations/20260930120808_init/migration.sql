/*
  Warnings:

  - Added the required column `local` to the `Eventos` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Eventos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "local" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "palestranteId" INTEGER,
    CONSTRAINT "Eventos_palestranteId_fkey" FOREIGN KEY ("palestranteId") REFERENCES "Palestrante" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Eventos" ("data", "descricao", "id", "name", "palestranteId") SELECT "data", "descricao", "id", "name", "palestranteId" FROM "Eventos";
DROP TABLE "Eventos";
ALTER TABLE "new_Eventos" RENAME TO "Eventos";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
