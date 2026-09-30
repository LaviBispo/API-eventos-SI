/*
  Warnings:

  - You are about to drop the column `data` on the `Eventos` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Eventos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "palestranteId" INTEGER,
    CONSTRAINT "Eventos_palestranteId_fkey" FOREIGN KEY ("palestranteId") REFERENCES "Palestrante" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Eventos" ("descricao", "id", "local", "name", "palestranteId") SELECT "descricao", "id", "local", "name", "palestranteId" FROM "Eventos";
DROP TABLE "Eventos";
ALTER TABLE "new_Eventos" RENAME TO "Eventos";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
