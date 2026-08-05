using System.Collections.Generic;
using NetStream.Database.Implementations.Entities.Libraries;

namespace NetStream.Database.Implementations.Interfaces;

/// <summary>
/// An abstraction representing an entity that has releases.
/// </summary>
public interface IHasReleases
{
    /// <summary>
    /// Gets a collection containing this entity's releases.
    /// </summary>
    ICollection<Release> Releases { get; }
}
