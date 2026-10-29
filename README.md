# Musica Desktop Widget

Widget desktop per Windows con player musicale, timer personalizzabile e volume del PC. Interfaccia monocromatica trasparente, copertine reali e animazioni.

## Avvio

Scarica il repository come ZIP, estrailo e apri **`portable/Musica.exe`**. Mantieni nella stessa cartella l'eseguibile, `Musica.ps1` e le due DLL.

Richiede Windows 10/11 x64, Windows PowerShell 5.1 e .NET Framework 4.8. Non richiede Python, Node.js, Spotify API o chiavi di accesso. L'eseguibile non e firmato digitalmente.

## Uso

- Rotellina sul widget: **Musica → Timer → Volume**. Gli indicatori laterali permettono anche di selezionare la scheda.
- Musica: copertina, titolo, artista, play/pausa, brano precedente/successivo e avanzamento, se il lettore supporta queste funzioni.
- Timer: durata da 1 a 1440 minuti, pulsanti rapidi da 5/15/25/45 minuti, pausa e ripresa. Continua anche cambiando scheda o riducendo il widget.
- Volume: volume generale di Windows, mute e stato dell'alimentazione/batteria.
- Pulsante **−**: riduce il widget a una pillola con copertina circolare, titolo ed equalizzatore animato durante la riproduzione.
- Clic sulla pillola: riapre la scheda precedente. Trascina dalla copertina o dalla parte superiore per spostare il widget. Clic destro sulla pillola per aprire o chiudere.
- Il cambio di dimensione mantiene la posizione sul desktop, compresi i monitor secondari e le coordinate negative.

Il lettore deve esporre una sessione multimediale a Windows. Le funzioni disponibili e la copertina dipendono dall'app in riproduzione. Le immagini mantengono le proporzioni nel player; nella pillola vengono adattate al cerchio.

## Compilazione

Da Windows PowerShell nella cartella del progetto:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Build.ps1
```

Il comando usa il compilatore C# e i metadati Windows installati nel sistema e genera la cartella `portable`. Per eseguire anche la verifica dell'interfaccia:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Build.ps1 -Check
```

La verifica controlla timer, navigazione, modalita ridotta, trasparenza degli angoli e stabilita della posizione durante il ridimensionamento, anche con coordinate di monitor a sinistra e sopra il principale. Non modifica volume o riproduzione.

## Struttura

| File | Funzione |
| --- | --- |
| `src/Musica.ps1` | Interfaccia WPF, animazioni, timer e navigazione |
| `src/MusicRuntime.cs` | Lettura in background delle sessioni multimediali di Windows |
| `src/DesktopControls.cs` | Windows Core Audio e stato alimentazione |
| `src/MusicHost.cs` | Avvio dell'interfaccia senza console e singola istanza |
| `Build.ps1` | Compilazione riproducibile e verifica |

Preferenze e posizione vengono salvate localmente in `%LOCALAPPDATA%\AuraWidgets`. Il nome della cartella e mantenuto per compatibilita con le prime versioni. Il progetto non include preferenze personali, log, screenshot del desktop, copertine scaricate o vecchie versioni del widget.
