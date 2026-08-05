using NetStream.Database.Implementations;
using NetStream.Database.Implementations.Locking;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Logging.Abstractions;

namespace NetStream.Database.Providers.Sqlite.Migrations
{
    /// <summary>
    /// The design time factory for <see cref="NetStreamDbContext"/>.
    /// This is only used for the creation of migrations and not during runtime.
    /// </summary>
    internal sealed class SqliteDesignTimeNetStreamDbFactory : IDesignTimeDbContextFactory<NetStreamDbContext>
    {
        public NetStreamDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<NetStreamDbContext>();
            optionsBuilder.UseSqlite("Data Source=netstream.db", f => f.MigrationsAssembly(GetType().Assembly));

            return new NetStreamDbContext(
                optionsBuilder.Options,
                NullLogger<NetStreamDbContext>.Instance,
                new SqliteDatabaseProvider(null!, NullLogger<SqliteDatabaseProvider>.Instance),
                new NoLockBehavior(NullLogger<NoLockBehavior>.Instance));
        }
    }
}
