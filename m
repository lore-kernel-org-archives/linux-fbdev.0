From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Mon, 14 Oct 2002 07:50:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021014055053.GA1953@casa.fluido.as>
References: <20021012153641.GA13798@casa.fluido.as> <20021013001324.GF4267@ppc.vc.cvut.cz> <20021013141516.GA9973@casa.fluido.as> <20021013145604.GC20348@ppc.vc.cvut.cz> <20021013160746.GA17618@casa.fluido.as> <20021013223507.GA5348@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180y8B-0005qZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 22:51:07 -0700
Content-Disposition: inline
In-Reply-To: <20021013223507.GA5348@ppc.vc.cvut.cz>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

	Subject: Re: Mixing g400 dualhead and old Millennium.
	Date: lun, ott 14, 2002 at 12:35:07 +0200

Quoting Petr Vandrovec (vandrove@vc.cvut.cz):

> Really... I did not notice in your original email that it
> reports G400 as 2MB only device... Can you send me
> output of 'lspci -s X:Y.Z -vvvxxx' (where X:Y.Z is
> your G400 device, probably 1:00.0 or 2:00.0) with
> 2.4.19-pre10, and with Alan version? Alan's version
> uses data from BIOS to set memory type, and it
> apparently made mistake.

So, the output from 2.4.19-pre10 is

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e6000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 2b 10 25 05 02 00 90 02 04 00 00 03 08 40 00 00
10: 08 00 00 e8 00 00 00 e4 00 00 00 e5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 7d 21
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20
40: 20 00 04 00 00 3c 00 00 2b ff ff 2b 00 00 00 00
50: 00 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 f0 22 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 20 00 03 02 00 1f 00 00 00 00 00 00 00 00

The output from 2.4.19-pre10-ac2 differs in only one number. Here is the diff:

--- lspciold	Mon Oct 14 07:30:53 2002
+++ lspcinew	Mon Oct 14 07:35:09 2002
@@ -17,7 +17,7 @@
 10: 08 00 00 e8 00 00 00 e4 00 00 00 e5 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 7d 21
 30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20
-40: 20 00 04 00 00 3c 00 00 2b ff ff 2b 00 00 00 00
+40: 20 08 04 00 00 3c 00 00 2b ff ff 2b 00 00 00 00
 50: 00 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

> In Alan's kernel you should have option to enable procfs
> interface - can you enable it and send me also
> contents of /proc/driver/mga/fb*/pins. It is binary
> file, if you want, you can parse it by matrox_pins
> from ftp://platan.vc.cvut.cz/pub/linux/matrox-latest.

Info for the G400:

PINS from /proc/driver/mga/fb1/pins
  PINS:                          new, version 4.1, length 128
  DVD Info:                      FF
  Program date:                  C96C (2000-11-12)
  Program count:                 0003
  Product ID:                    0700
  Serial No:                     GAM73189        
  Part info:                     403   
  PCB info:                      38A4
  Max pixel VCO:                 360 MHz
  Max system VCO:                360 MHz
  Max CRTC1 VCO                  
    8bpp:                        360 MHz
    16bpp:                       360 MHz
    24bpp:                       360 MHz
    32bpp:                       360 MHz
  Max CRTC2 VCO                  
    16bpp:                       136 MHz
    32bpp:                       136 MHz
  OPTION flags:                  0xC2
  VGA Mode                       
    GClk VCO:                    328 MHz
    Reserved:                    29
    OPTION3 register:            0x0190A419
    MCTLWTST register:           0x20049911
    Clk1:                        standard
    Clk2:                        standard
  2D Mode                        
    GClk VCO:                    600 MHz
    Reserved:                    4B
    OPTION3 register:            0x019B8419
    MCTLWTST register:           0x20049911
  3D Mode                        
    GClk VCO:                    600 MHz
    Reserved:                    4B
    OPTION3 register:            0x019B8419
    MCTLWTST register:           0x20049911
  GClk Derate:                   FF
  MemRdBk:                       0C88
  MemRdBkMod:                    0C88
  VidCtrl:                       EE
  Factory options                
    Reference Freq:              27.000 MHz
    Memory size:                 32MB
    Memory type:                 SGLVTTL16
    MAVEN:                       present
    DVD:                         not present
    MJPEG:                       not present
    Decoder:                     not present
    Tuner:                       not present
    Audio:                       not present
    Panel Link:                  not present

I am also including info from the Millennium:

PINS from /proc/driver/mga/fb0/pins
  Product ID:                    0005
  Serial No:                     CAG81904  
  Manuf date:                    C0CC (1996-6-12)
  Manuf ID:                      0004
  PCB Info:                      49C3
  PMB Info:                      2642
  Ramdac speed:                  1
  Ramdac type:                   0
  Max PCLK:                      0
  Max LCLK:                      0
  ClkBase:                       5000
  Clk4MB:                        0
  Clk8MB:                        0
  ClkMod:                        0
  TestClk:                       0
  VGAFreq1:                      2517
  VGAFreq2:                      2832
  Program date:                  C4C8 (1998-6-8)
  Program count:                 5
  Ser No Ext:                    0F8B0000
  Feature flags:                 00000000
  VGA Clock:                     0
  Struct rev:                    0105
  Vid Ctrl:                      00
  Rsvd:                          00 00 00 00 00

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
