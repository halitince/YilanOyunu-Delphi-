object frmSkorlar: TfrmSkorlar
  Left = 0
  Top = 0
  Width = 268
  Height = 347
  TabOrder = 0
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 268
    Height = 347
    Align = alClient
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = SkorD
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '  '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      Styles.StyleSheet = cxGridTableViewStyleSheet1
      object cxGrid1DBTableView1RecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object cxGrid1DBTableView1skor: TcxGridDBColumn
        DataBinding.FieldName = 'skor'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0  ;-,0  '
        Width = 80
      end
      object cxGrid1DBTableView1kullanici: TcxGridDBColumn
        DataBinding.FieldName = 'kullanici'
        Width = 171
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Skorlar: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000001900000001000A006B756C6C616E696369
      000400000003000500736B6F7200000000000000}
    SortOptions = []
    Left = 48
    Top = 128
    object Skorlarkullanici: TStringField
      FieldName = 'kullanici'
      Size = 25
    end
    object Skorlarskor: TIntegerField
      FieldName = 'skor'
    end
  end
  object SkorD: TDataSource
    DataSet = Skorlar
    Left = 76
    Top = 128
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 56
    Top = 48
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 13158600
    end
    object cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet
      Styles.Background = cxStyle1
      Styles.IncSearch = cxStyle1
      Styles.Navigator = cxStyle1
      Styles.NavigatorInfoPanel = cxStyle1
      Styles.Header = cxStyle1
      Styles.Inactive = cxStyle1
      Styles.Indicator = cxStyle1
      Styles.NewItemRowInfoText = cxStyle1
      Styles.Preview = cxStyle1
      Styles.Selection = cxStyle1
      BuiltIn = True
    end
  end
  object tmrListeGuncelle: TTimer
    Enabled = False
    OnTimer = tmrListeGuncelleTimer
    Left = 160
    Top = 128
  end
end
