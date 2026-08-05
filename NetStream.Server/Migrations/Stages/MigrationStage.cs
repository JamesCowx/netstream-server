using System.Collections.ObjectModel;

namespace NetStream.Server.Migrations.Stages;

/// <summary>
/// Defines a Stage that can be Invoked and Handled at different times from the code.
/// </summary>
internal class MigrationStage : Collection<CodeMigration>
{
    public MigrationStage(NetStreamMigrationStageTypes stage)
    {
        Stage = stage;
    }

    public NetStreamMigrationStageTypes Stage { get; }
}
