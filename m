From: gutko@poczta.onet.pl
Subject: Framebuffer on modified Radeon 9500
Date: Sun, 11 May 2003 2:21:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <E19Eean-0000NG-00@f25.test.onet.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp4.poczta.onet.pl ([213.180.130.28])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Eeb2-0006gh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 May 2003 17:21:44 -0700
Received: from localhost ([127.0.0.1] helo=ps1.test.onet.pl)
	by f25.test.onet.pl with smtp mailer
	id 19Eean-0000NG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 May 2003 02:21:29 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hello,
I'm trying to run (with no effect) radeonfb on X-power Radeon 9500 non pro 128mb, which I modified to 9700 non pro. Some time ago it was loud in internet about this mod. The matter was simple soldering to unlock additional 4 rendering pipes, and a bios change to change hardwane ID's. I took bios from Hercules R9700(non pro). 
I tried radeonfb 0.1.8  and it always says: "cannot map FB". I tried vesafb and it doesn't print anything at all. I can use this card only in 80x25 mode on console. X works OK in any resolution, same Windows and all Windows games.

Maybe it doesn't work because difference between first controller "R300 NE" and second "R300"? I don't know how it looks on not modified cards.
I know there is a lot of people with such problem.

Is it possible to make radeonfb work on this card? 
Is there any chance in future to support it?? I'll be happy to provide any information to help.

Thank you,
Maciek

ps:

Here is "lspci -vv" output.
MODIFIED CARD:

02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE [Radeon 9700] (prog-if 00 [VGA])
 Subsystem: ATI Technologies Inc: Unknown device 0002
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 32 (2000ns min), cache line size 08
 Interrupt: pin A routed to IRQ 10
 Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
 Region 1: I/O ports at b000 [size=256]
 Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=64K]
 Expansion ROM at <unassigned> [disabled] [size=128K]
 Capabilities: [58] AGP version 3.0
  Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
  Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9700] (Secondary)
 Subsystem: ATI Technologies Inc: Unknown device 0003
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled] [size=128M]
 Region 1: Memory at e5010000 (32-bit, non-prefetchable) [disabled] [size=64K]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
