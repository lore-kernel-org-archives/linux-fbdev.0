From: Ondrej Zary <linux@rainbow-software.org>
Date: Thu, 12 Feb 2015 21:11:28 +0000
Subject: gxt4500 on x86 (Fire GL2)
Message-Id: <201502122211.28752.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Hello,
I'm trying to get gxt4500 driver to work on x86 with Diamond/ATI Fire GL2 AGP
card:
01:00.0 VGA compatible controller [0300]: IBM GXT6000P Graphics Adapter [1014:0170] (rev 02) (prog-if 00 [VGA controller])
        Subsystem: Diamond Multimedia Systems Fire GL2 [1092:0172]
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+ DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size8K]
        Region 1: Memory at f0000000 (32-bit, non-prefetchable) [sizedM]
        [virtual] Expansion ROM at 30000000 [disabled] [size%6K]
        Capabilities: [60] Power Management version 0
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] AGP version 2.0
                Status: RQ2 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x1
        Kernel driver in use: gxt4500

After patching Kconfig, the driver compiled but does not work - monitor shows
no signal after driver load. Realized that PPC is big-endian while x86 is
little-endian and there are no endian conversions in the driver so did this:

--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -137,8 +137,8 @@ static const unsigned char watfmt[] = {
 /* Colormap array; 1k entries of 4 bytes each */
 #define CMAP                   0x6000

-#define readreg(par, reg)      readl((par)->regs + (reg))
-#define writereg(par, reg, val)        writel((val), (par)->regs + (reg))
+#define readreg(par, reg)      be32_to_cpu(readl((par)->regs + (reg)))
+#define writereg(par, reg, val)        writel(cpu_to_be32(val), (par)->regs + (reg))

 struct gxt4500_par {
        void __iomem *regs;


But nothing changed, still no signal. Any ideas?

I was able to get the ancient fgl23 driver (from AMD web site) to work by
installing Debian Woody to a small partition. It's not very useful today but
it might be possible to dump the chip's registers and compare with gxt4500.

-- 
Ondrej Zary
