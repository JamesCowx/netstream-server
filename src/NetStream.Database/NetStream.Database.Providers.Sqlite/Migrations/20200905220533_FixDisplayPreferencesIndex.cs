#pragma warning disable CS1591
#pragma warning disable SA1601

using Microsoft.EntityFrameworkCore.Migrations;

namespace NetStream.Server.Implementations.Migrations
{
    public partial class FixDisplayPreferencesIndex : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_DisplayPreferences_UserId",
                schema: "netstream",
                table: "DisplayPreferences");

            migrationBuilder.CreateIndex(
                name: "IX_DisplayPreferences_UserId",
                schema: "netstream",
                table: "DisplayPreferences",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_DisplayPreferences_UserId_Client",
                schema: "netstream",
                table: "DisplayPreferences",
                columns: new[] { "UserId", "Client" },
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_DisplayPreferences_UserId",
                schema: "netstream",
                table: "DisplayPreferences");

            migrationBuilder.DropIndex(
                name: "IX_DisplayPreferences_UserId_Client",
                schema: "netstream",
                table: "DisplayPreferences");

            migrationBuilder.CreateIndex(
                name: "IX_DisplayPreferences_UserId",
                schema: "netstream",
                table: "DisplayPreferences",
                column: "UserId",
                unique: true);
        }
    }
}
