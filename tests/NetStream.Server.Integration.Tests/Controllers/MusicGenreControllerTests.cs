using System.Net;
using System.Threading.Tasks;
using Xunit;

namespace NetStream.Server.Integration.Tests.Controllers;

public sealed class MusicGenreControllerTests : IClassFixture<NetStreamApplicationFactory>
{
    private readonly NetStreamApplicationFactory _factory;
    private static string? _accessToken;

    public MusicGenreControllerTests(NetStreamApplicationFactory factory)
    {
        _factory = factory;
    }

    [Fact]
    public async Task MusicGenres_FakeMusicGenre_NotFound()
    {
        var client = _factory.CreateClient();
        client.DefaultRequestHeaders.AddAuthHeader(_accessToken ??= await AuthHelper.CompleteStartupAsync(client));

        var response = await client.GetAsync("MusicGenres/Fake-MusicGenre", TestContext.Current.CancellationToken);
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }
}
