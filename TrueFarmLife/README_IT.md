# True Farm Life — Realismo Meccanico per FS25

## Installazione

1. Chiudi Farming Simulator 25.
2. Copia `FS25_TrueFarmLife.zip` nella cartella Mods di FS25.
3. Dal salvataggio, abilita **True Farm Life — Realismo Meccanico** nella schermata delle mod.
4. Entra in un trattore, una mietitrebbia o un attrezzo e premi `I` per la diagnostica, `K` per la checklist e `O` per cambiare profilo. Tutti i comandi sono modificabili dal menu Comandi.

Non estrarre lo ZIP nella cartella Mods: FS25 rileva direttamente l'archivio.

## Cosa cambia

- Quattro profili: `REALISTICO`, `HARDCORE`, `SIMULAZIONE` e `ULTRA REALISTICO`. Il profilo iniziale è `SIMULAZIONE`; in partita singola o come host usa `O` in un mezzo per scorrerli. I profili variano usura, probabilità di guasto, costo ricambi, lavoro su bagnato e perdita di trazione.
- Ogni trattore, mezzo semovente, rimorchio o attrezzo dotato di usura riceve dati persistenti per motore/parti di lavoro, batteria/impianto elettrico, pneumatici/parti mobili e idraulica.
- Le ore operative avanzano con il tempo di gioco mentre il mezzo è in funzione. Campo, attrezzo acceso, sporcizia e temperatura elevata aumentano l'usura.
- In campo e con pioggia significativa, il profilo applica una perdita prestazionale attraverso il sistema di danno del gioco: è la base concreta per trazione e lavoro su bagnato.
- In `ULTRA REALISTICO`, con pioggia intensa il lavoro attivabile in campo viene bloccato: occorre attendere una finestra operativa asciutta.
- Ogni cambio di periodo addebita un'assicurazione mezzi proporzionale al valore dei veicoli aziendali. I costi di carburante, leasing, prestiti, stipendi, sementi, fertilizzanti e trasporti restano quelli dinamici già contabilizzati da FS25 e dalle sue catene produttive.
- Sotto il 40% di condizione può comparire un guasto. Motore e batteria bloccano l'avviamento; una gomma danneggiata riduce le prestazioni; idraulica e attrezzi bloccano il lavoro.
- La riparazione va fatta alla normale officina di FS25. Il pulsante **Ripara** aggiunge il costo dei ricambi True Farm Life e risolve il guasto; un tagliando migliora anche i componenti non guasti.
- Il valore di ogni componente, le ore e il guasto sono scritti nei dati del veicolo del salvataggio e sincronizzati in multiplayer dal server.
- **Manutenzione avanzata 1.2:** oltre alle quattro condizioni generali, ogni mezzo registra livello e qualità olio, refrigerante, filtri aria/carburante/olio, alternatore, motorino d'avviamento, cinghie, trasmissione (frizione/cambio/differenziale), PTO, freni, luci/tergicristalli e quattro pneumatici con condizione e pressione separate. Temperatura motore, sporco, carico e pressione errata alimentano l'usura; olio/refrigerante/cinghie o avviamento elettrico critici bloccano concretamente il motore.
- Premi `K` prima del lavoro: la checklist individua il componente più critico. La normale officina ripristina anche i nuovi elementi e registra un evento nel breve storico persistente del mezzo.

## Compatibilità e limiti della versione 1.2

- Compatibile con le mappe e con mezzi base/mod perché usa una specializzazione aggiunta al caricamento, senza modificare XML originali.
- Richiede PC o Mac: le mod con script Lua non possono essere pubblicate crossplay su console secondo le regole ModHub.
- È pensata per funzionare con la normale officina del gioco. Le mod che sostituiscono integralmente `repairVehicle`, `getRepairPrice`, l'accensione o l'azione di lavoro possono cambiare l'ordine degli effetti; prova prima su una copia del salvataggio.
- Il primo avvio su un salvataggio esistente parte dal 100% per i dati True Farm Life. L'usura originale del gioco rimane invariata.
- Il profilo selezionato con `O` è attivo per la sessione; per una nuova scelta predefinita modifica `DEFAULT_PROFILE` in `scripts/TrueFarmLifeProfiles.lua` prima di iniziare la carriera.

## Verifica rapida

1. Avvia una nuova partita con la mod attiva e acquista o usa un trattore.
2. Premi `I`: deve apparire il pannello diagnostico.
3. Salva, ricarica la partita e verifica che le ore operative rimangano memorizzate.
4. Porta un mezzo all'officina e verifica che il preventivo di riparazione includa anche la condizione della mod.

Per provare velocemente i guasti durante lo sviluppo, riduci temporaneamente le quattro costanti `*_WEAR_PER_HOUR` in modo inverso (aumentandole) all'inizio di `scripts/specializations/TrueFarmLifeCondition.lua`. Non farlo in una carriera principale.
