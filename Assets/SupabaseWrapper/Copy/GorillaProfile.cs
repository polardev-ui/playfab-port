using Postgrest.Models;
using Postgrest.Attributes;

[Table("profiles")]
public class GorillaProfile : BaseModel // written according to a GorillaComputer that was from 2023, so not super updated
{
    [PrimaryKey("id")]
    public string Id { get; set; }

    [Column("display_name")]
    public string DisplayName { get; set; }

    [Column("red_value")]
    public float Red { get; set; }

    [Column("green_value")]
    public float Green { get; set; }

    [Column("blue_value")]
    public float Blue { get; set; }

    [Column("allowed_in_competitive")]
    public bool AllowedInComp { get; set; }
}

