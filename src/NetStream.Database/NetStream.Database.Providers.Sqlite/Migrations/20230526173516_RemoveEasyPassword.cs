using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NetStream.Server.Implementations.Migrations
{
    /// <inheritdoc />
    public partial class RemoveEasyPassword : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "EasyPassword",
                schema: "netstream",
                table: "Users");

            migrationBuilder.RenameTable(
                name: "Users",
                schema: "netstream",
                newName: "Users");

            migrationBuilder.RenameTable(
                name: "Preferences",
                schema: "netstream",
                newName: "Preferences");

            migrationBuilder.RenameTable(
                name: "Permissions",
                schema: "netstream",
                newName: "Permissions");

            migrationBuilder.RenameTable(
                name: "ItemDisplayPreferences",
                schema: "netstream",
                newName: "ItemDisplayPreferences");

            migrationBuilder.RenameTable(
                name: "ImageInfos",
                schema: "netstream",
                newName: "ImageInfos");

            migrationBuilder.RenameTable(
                name: "HomeSection",
                schema: "netstream",
                newName: "HomeSection");

            migrationBuilder.RenameTable(
                name: "DisplayPreferences",
                schema: "netstream",
                newName: "DisplayPreferences");

            migrationBuilder.RenameTable(
                name: "Devices",
                schema: "netstream",
                newName: "Devices");

            migrationBuilder.RenameTable(
                name: "DeviceOptions",
                schema: "netstream",
                newName: "DeviceOptions");

            migrationBuilder.RenameTable(
                name: "CustomItemDisplayPreferences",
                schema: "netstream",
                newName: "CustomItemDisplayPreferences");

            migrationBuilder.RenameTable(
                name: "ApiKeys",
                schema: "netstream",
                newName: "ApiKeys");

            migrationBuilder.RenameTable(
                name: "ActivityLogs",
                schema: "netstream",
                newName: "ActivityLogs");

            migrationBuilder.RenameTable(
                name: "AccessSchedules",
                schema: "netstream",
                newName: "AccessSchedules");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "netstream");

            migrationBuilder.RenameTable(
                name: "Users",
                newName: "Users",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "Preferences",
                newName: "Preferences",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "Permissions",
                newName: "Permissions",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "ItemDisplayPreferences",
                newName: "ItemDisplayPreferences",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "ImageInfos",
                newName: "ImageInfos",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "HomeSection",
                newName: "HomeSection",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "DisplayPreferences",
                newName: "DisplayPreferences",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "Devices",
                newName: "Devices",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "DeviceOptions",
                newName: "DeviceOptions",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "CustomItemDisplayPreferences",
                newName: "CustomItemDisplayPreferences",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "ApiKeys",
                newName: "ApiKeys",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "ActivityLogs",
                newName: "ActivityLogs",
                newSchema: "netstream");

            migrationBuilder.RenameTable(
                name: "AccessSchedules",
                newName: "AccessSchedules",
                newSchema: "netstream");

            migrationBuilder.AddColumn<string>(
                name: "EasyPassword",
                schema: "netstream",
                table: "Users",
                type: "TEXT",
                maxLength: 65535,
                nullable: true);
        }
    }
}
