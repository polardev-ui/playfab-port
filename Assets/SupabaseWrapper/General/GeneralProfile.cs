using Postgrest.Models;
using Postgrest.Attributes;

[Table("profiles")]
public class GeneralProfile : BaseModel // for basic stuff like RPG, FPS, racing, etc.
{
    [PrimaryKey("id")]
    public string Id { get; set; }

    [Column("username")]
    public string Username { get; set; }

    [Column("xp")]
    public int XP { get; set; }

    [Column("level")]
    public int Level { get; set; }

    [Column("currency_soft")]
    public int Coins { get; set; }
}