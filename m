From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Another problem, seemingly coming from mixing millennium and g400
Date: Tue, 15 Oct 2002 12:33:47 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021015103347.GA10733@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181P1P-0005KQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Oct 2002 03:33:55 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, gif@bek.no

Now that I can see the output of the second card, I have a new
problem. WIth both versions of the driver, the output on the second
head is influenced by what is sent to the first head. It is very
difficult for me to describe, especially because the relative PC is
very far from me. But I see that, if I set the second head to 16bpp,
the amount of disruption to it is little if the first head is set to
32bpp, medium if set to 16 and very high if the first head is set to
8bpp. It seems the info for the first head is spilling to the second
one. This does not happen if the g400 is by itself, only if the
Millennium is also present.

In both cases, the matrox_pins output is unchanged to what I had sent
to you before. But the lspci output changes a lot. Here you have a
diff: lspcialone is where the g400 is by itself, while lspciwithmill
is when the millennium is also present.


--- lspcialone  Tue Oct 15 11:55:21 2002
+++ lspciwithmill       Tue Oct 15 12:04:25 2002
@@ -1,33 +1,32 @@
 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
+       Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
-       Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
-       Expansion ROM at <unassigned> [disabled] [size=64K]
+       Expansion ROM at e6000000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
-               Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
-00: 2b 10 25 05 07 00 90 02 04 00 00 03 08 40 00 00
+               Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
+00: 2b 10 25 05 02 00 90 02 04 00 00 03 08 40 00 00
 10: 08 00 00 e8 00 00 00 e4 00 00 00 e5 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 7d 21
 30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20
-40: 20 41 04 50 00 3c 00 00 06 ff ff 06 00 00 00 00
-50: 00 30 00 01 19 a4 90 01 00 00 00 00 00 00 00 00
+40: 20 00 04 00 00 3c 00 00 2b ff ff 2b 00 00 00 00
+50: 00 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 f0 22 00
 e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-f0: 02 00 20 00 03 02 00 1f 01 03 00 1f 00 00 00 00
+f0: 02 00 20 00 03 02 00 1f 00 00 00 00 00 00 00 00

In case you need it, I also add the lspci info for the millennium:

00:09.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: Memory at eb000000 (32-bit, prefetchable) [size=8M]
        Expansion ROM at ec000000 [disabled] [size=64K]
00: 2b 10 19 05 83 00 80 02 01 00 00 03 00 00 00 00
10: 00 00 00 ea 08 00 00 eb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 ec 00 00 00 00 00 00 00 00 0a 01 00 00
40: 00 11 2c 5f 00 3c 00 00 06 aa ff 06 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

All the above comes from 2.4.20-pre10-ac2 with your previous
patch. Can you help again? Any other info that you may need?

Thanks in advance

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
