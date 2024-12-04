unit Loldle;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, system.Generics.Collections, System.JSON, System.IOUtils;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    MLane: TMemo;
    MRange: TMemo;
    MRegion: TMemo;
    MResource: TMemo;
    MRace: TMemo;
    MSex: TMemo;
    Button2: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    LabelPontuacao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExportarJson(Chave, Valor: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  character = class
    sex: string;
    name: string;
    lane: string;
    range: string;
    race: string;
    resource: string;
    region: string;


    public
      constructor Create(const sex: string; name: string; race: string; lane: string; range: string; resource: string; region: string);
  end;



var
  Form3: TForm3;
  characters: TList<character>;
  selectedCharacter: character;
  Pontuacao: integer;

implementation

{$R *.dfm}


constructor character.Create(const sex: string; name: string; race: string; lane: string; range: string; resource: string; region: string);
begin
  Self.sex := sex;
  Self.name := name;
  Self.race := race;
  Self.lane := lane;
  Self.range := range;
  Self.resource := resource;
  Self.region := region;
end;


procedure TForm3.Button1Click(Sender: TObject);
var userTry: character;
    i: integer;
begin
  userTry := nil;

  if selectedCharacter=nil then begin
    MessageDlg('Primeiro, clique no botão "sort" para sortear um personagem!', mtInformation, [mbOK], 0);
  end else begin

    for i := 0 to characters.Count-1 do begin
    if SameText(Edit1.Text, characters[i].name) then begin
      userTry:=characters[i];
    end;
    end;


    if not characters.Contains(userTry) then begin
      MessageDlg('Persongem não adicionado ainda', mtInformation, [mbOK], 0);
    end else begin
      if userTry.sex = selectedCharacter.sex then begin
        Msex.Color:=clGreen;
        MSex.lines[1]:=userTry.sex;
      end else begin
        Msex.Color:=clRed;
        MSex.lines[1]:=userTry.sex;
      end;
      if userTry.race = selectedCharacter.race then begin
        Mrace.Color:=clGreen;
        Mrace.lines[1]:=userTry.race;
      end else begin
        Mrace.Color:=clRed;
        Mrace.lines[1]:=userTry.race;
      end;
      if userTry.range = selectedCharacter.range then begin
        Mrange.Color:=clGreen;
        Mrange.lines[1]:=userTry.range;
      end else begin
        Mrange.Color:=clRed;
        Mrange.lines[1]:=userTry.range;
      end;
      if userTry.lane = selectedCharacter.lane then begin
        Mlane.Color:=clGreen;
        Mlane.lines[1]:=userTry.lane;
      end else begin
        Mlane.Color:=clRed;
        Mlane.lines[1]:=userTry.lane;
      end;
      if userTry.resource = selectedCharacter.resource then begin
        Mresource.Color:=clGreen;
        Mresource.lines[1]:=userTry.resource;
      end else begin
        Mresource.Color:=clRed;
        Mresource.lines[1]:=userTry.resource;
      end;
      if userTry.region = selectedCharacter.region then begin
        Mregion.Color:=clGreen;
        Mregion.lines[1]:=userTry.region;
      end else begin
        Mregion.Color:=clRed;
        Mregion.lines[1]:=userTry.region;
      end;


      if userTry.name=selectedCharacter.name then begin
        Inc(Pontuacao);
        LabelPontuacao.Caption:=IntToStr(Pontuacao);
        MessageDlg('Parabéns, você acertou! O campeão era: '+userTry.name, mtInformation, [mbOK], 0);
        ExportarJson('Pontuacao', IntToStr(Pontuacao));
      end else begin
        Memo1.Lines.Add(userTry.name);
      end;
    end;
  end;
end;


procedure TForm3.ExportarJson(Chave, Valor: string);
var
  ArquivoJSON: TJSONObject;
  Arquivo: string;
begin
  Arquivo := 'C:\Users\rpinfo3\Documents\dados.json';

  // Carrega o JSON existente ou cria um novo
  if TFile.Exists(Arquivo) then
    ArquivoJSON := TJSONObject.ParseJSONValue(TFile.ReadAllText(Arquivo)) as TJSONObject
  else
    ArquivoJSON := TJSONObject.Create;

  try
    // Adiciona ou atualiza a chave com o novo valor
    ArquivoJSON.AddPair(Chave, Valor);

    // Salva o JSON no arquivo
    TFile.WriteAllText(Arquivo, ArquivoJSON.ToString);
  finally
    ArquivoJSON.Free;
  end;
end;

function LerJson(Chave: string): string;
var
  ArquivoJSON: TJSONObject;
  Arquivo: string;
  Valor: TJSONValue;
begin
//  Arquivo := TPath.Combine(ExtractFilePath(ParamStr(0)), 'dados.json'); // Caminho do arquivo JSON
   Arquivo:='C:\Users\rpinfo3\Documents\dados.json';
  // Verifica se o arquivo existe
  if TFile.Exists(Arquivo) then begin
    ArquivoJSON := TJSONObject.ParseJSONValue(TFile.ReadAllText(Arquivo)) as TJSONObject;
    try
      // Tenta buscar o valor associado à chave
      Valor := ArquivoJSON.GetValue(Chave);
      if Assigned(Valor) then
        Result := Valor.Value
      else
        Result := ''; // Chave não encontrada
    finally
      ArquivoJSON.Free;
    end;
  end
  else
    Result := ''; // Arquivo não existe
    ShowMessage(Arquivo);
    ShowMessage('nao existe o arquivo');
end;


procedure TForm3.Button2Click(Sender: TObject);
begin
  if characters.Count > 0 then begin
    selectedCharacter := characters[Random(characters.Count)];
    Label2.Caption:='Personagem Sorteado!';
  end;
end;



procedure TForm3.FormCreate(Sender: TObject);
var
  teemo, yasuo, yone, ekko, katarina, caitlyn, jinx, thresh, kayn: character;
  ahri, zed, lux, garen, missFortune, ashe, mordekaiser, veigar, diana, shen,
  leeSin, vayne, ryze, fiora, draven, jax, nidalee, rengar, twitch, leona, graves, elise,
  trundle, sejuani, brand, blitzcrank: character;
  ValorLido: string;
begin
  Randomize;
  characters := TList<character>.Create;
  selectedCharacter:=nil;
  Pontuacao:=0;

  Memo1.Lines.Clear;
  Memo1.Lines.Add('Personagens já chutados:');

  ValorLido:=LerJson('Pontuacao');
  if ValorLido<>'' then
    Pontuacao:=StrToInt(ValorLido)
  else
    Pontuacao := 0; // Valor padrão se a chave não for encontrada
  LabelPontuacao.Caption := IntToStr(Pontuacao);

  teemo := character.Create('male', 'Teemo', 'yordle', 'top', 'range', 'mana', 'bandopolis');
  yasuo := character.Create('male', 'Yasuo', 'human', 'mid', 'meelee', 'flow', 'ionia');
  yone := character.Create('male', 'Yone', 'altered human', 'mid', 'meelee', 'no mana', 'ionia');
  ekko := character.Create('male', 'Ekko', 'human', 'mid', 'range', 'mana', 'zaun');
  katarina := character.Create('female', 'Katarina', 'human', 'mid', 'meelee', 'no mana', 'noxus');
  caitlyn := character.Create('female', 'Caitlyn', 'human', 'bot', 'range', 'mana', 'piltover');
  jinx := character.Create('female', 'Jinx', 'human', 'bot', 'range', 'mana', 'zaun');
  thresh := character.Create('male', 'Thresh', 'undead', 'sup', 'range', 'mana', 'shadow island');
  kayn := character.Create('male', 'Kayn', 'darkin', 'jungle', 'meelee', 'mana', 'runeterra');

  ahri := character.Create('female', 'Ahri', 'vastaya', 'mid', 'range', 'mana', 'ionia');
  zed := character.Create('male', 'Zed', 'human', 'mid', 'meelee', 'energy', 'ionia');
  lux := character.Create('female', 'Lux', 'human', 'mid', 'range', 'mana', 'demacia');
  garen := character.Create('male', 'Garen', 'human', 'top', 'meelee', 'no mana', 'demacia');
  missFortune := character.Create('female', 'Miss Fortune', 'human', 'bot', 'range', 'mana', 'bilgewater');
  ashe := character.Create('female', 'Ashe', 'human', 'bot', 'range', 'mana', 'freljord');
  mordekaiser := character.Create('male', 'Mordekaiser', 'undead', 'top', 'meelee', 'shield', 'shadow island');
  veigar := character.Create('male', 'Veigar', 'yordle', 'mid', 'range', 'mana', 'bandopolis');
  diana := character.Create('female', 'Diana', 'ascended', 'jungle', 'meelee', 'mana', 'targon');
  shen := character.Create('male', 'Shen', 'human', 'top', 'meelee', 'energy', 'ionia');

  leeSin := character.Create('male', 'Lee Sin', 'human', 'jungle', 'meelee', 'energy', 'ionia');
  vayne := character.Create('female', 'Vayne', 'human', 'bot', 'range', 'mana', 'demacia');
  ryze := character.Create('male', 'Ryze', 'human', 'mid', 'range', 'mana', 'runeterra');
  fiora := character.Create('female', 'Fiora', 'human', 'top', 'meelee', 'mana', 'demacia');
  draven := character.Create('male', 'Draven', 'human', 'bot', 'range', 'mana', 'noxus');
  jax := character.Create('male', 'Jax', 'unknown', 'top', 'meelee', 'mana', 'icathia');
  nidalee := character.Create('female', 'Nidalee', 'human', 'jungle', 'range', 'mana', 'kumungu jungle');
  rengar := character.Create('male', 'Rengar', 'vastaya', 'jungle', 'meelee', 'ferocity', 'kumungu jungle');
  twitch := character.Create('male', 'Twitch', 'mutant rat', 'bot', 'range', 'mana', 'zaun');
  leona := character.Create('female', 'Leona', 'ascended', 'sup', 'meelee', 'mana', 'targon');
  graves := character.Create('male', 'Graves', 'human', 'jungle', 'range', 'no mana', 'bilgewater');
  elise := character.Create('female', 'Elise', 'spider demon', 'jungle', 'range', 'mana', 'shadow island');
  trundle := character.Create('male', 'Trundle', 'troll', 'top', 'meelee', 'mana', 'freljord');
  sejuani := character.Create('female', 'Sejuani', 'human', 'jungle', 'meelee', 'mana', 'freljord');
  brand := character.Create('male', 'Brand', 'human', 'mid', 'range', 'mana', 'shadow island');
  blitzcrank := character.Create('male', 'Blitzcrank', 'golem', 'sup', 'meelee', 'mana', 'zaun');


  characters.Add(teemo);
  characters.Add(yasuo);
  characters.Add(yone);
  characters.Add(ekko);
  characters.Add(katarina);
  characters.Add(caitlyn);
  characters.Add(jinx);
  characters.Add(thresh);
  characters.Add(kayn);
  characters.Add(ahri);
  characters.Add(zed);
  characters.Add(lux);
  characters.Add(garen);
  characters.Add(missFortune);
  characters.Add(ashe);
  characters.Add(mordekaiser);
  characters.Add(veigar);
  characters.Add(diana);
  characters.Add(shen);
  characters.Add(leeSin);
  characters.Add(vayne);
  characters.Add(ryze);
  characters.Add(fiora);
  characters.Add(draven);
  characters.Add(jax);
  characters.Add(nidalee);
  characters.Add(rengar);
  characters.Add(twitch);
  characters.Add(leona);
  characters.Add(graves);
  characters.Add(elise);
  characters.Add(trundle);
  characters.Add(sejuani);
  characters.Add(brand);
  characters.Add(blitzcrank);
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ExportarJson('Pontuacao', IntToStr(Pontuacao));
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  characters.Free;
  selectedCharacter.Free;
end;

end.



//  Lanes:=TList<string>.Create;
//  Lanes.Add('top');
//  Lanes.Add('mid');
//  Lanes.Add('jungle');
//  Lanes.Add('bot');
//  Lanes.Add('sup');
//
//  Attacks:=TList<string>.Create;
//  Attacks.Add('meelee');
//  Attacks.Add('range');
//
//  SexList:=TList<string>.Create;
//  SexList.Add('male');
//  SexList.Add('female');
//
//  Races:=TList<string>.Create;
//  Races.Add('yordle');
//  Races.Add('human');
//  Races.Add('wizard');
//  Races.Add('darkin');
//  Races.Add('undead');
//  Races.Add('vastaya');

