using System;

namespace NetStream.Server.Migrations;

/// <summary>
/// Marks an <see cref="NetStreamMigrationAttribute"/> migration and instructs the <see cref="NetStreamMigrationService"/> to perform a backup.
/// </summary>
[AttributeUsage(System.AttributeTargets.Class, Inherited = true, AllowMultiple = true)]
public sealed class NetStreamMigrationBackupAttribute : System.Attribute
{
    /// <summary>
    /// Gets or Sets a value indicating whether a backup of the old library.db should be performed.
    /// </summary>
    public bool LegacyLibraryDb { get; set; }

    /// <summary>
    /// Gets or Sets a value indicating whether a backup of the Database should be performed.
    /// </summary>
    public bool NetStreamDb { get; set; }

    /// <summary>
    /// Gets or Sets a value indicating whether a backup of the metadata folder should be performed.
    /// </summary>
    public bool Metadata { get; set; }

    /// <summary>
    /// Gets or Sets a value indicating whether a backup of the Trickplay folder should be performed.
    /// </summary>
    public bool Trickplay { get; set; }

    /// <summary>
    /// Gets or Sets a value indicating whether a backup of the Subtitles folder should be performed.
    /// </summary>
    public bool Subtitles { get; set; }
}
