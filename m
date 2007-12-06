From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: radeonfb: Please enable support for X850XT
Date: Thu, 6 Dec 2007 22:28:09 +0100
Message-ID: <20071206212809.GA8249@aragorn.home.lxtec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J0OGh-0000ZV-0N for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 13:28:27 -0800
Received: from smtpout.hostsharing.net ([83.223.95.98])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J0OGX-0004XE-Ud
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 13:28:20 -0800
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="ibm855"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Luca Tettamanti <kronos.it@gmail.com>


Hi gents,

I've built in a new graphic adapter. DRI and r300 works well.

Xorg.0.log:
(--) RADEON(0): Chipset: "ATI Radeon X850 XT (R480) (AGP)" (ChipID =3D 0x4b=
49)

lspci:

01:00.0 VGA compatible controller: ATI Technologies Inc R480 [Radeon X850XT=
] (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=3D128M]
        Region 1: I/O ports at d800 [size=3D256]
        Region 2: Memory at c7000000 (32-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at d7fe0000 [disabled] [size=3D128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=3D80 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit-=
 FW- Rate=3Dx4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


There was a patch which looked like enabling this card:

http://marc.info/?l=3Dlinux-fbdev-devel&m=3D116768377303703&w=3D2

but didn't went into mainline. The patch doesn't apply to recent kernels. So
could you please tell me how support for the X850XT (AGP) canbe applied?

I've tried:

diff -Naurd linux-2.6.23.orig/drivers/video/aty/ati_ids.h linux-2.6.23/driv=
ers/video/aty/ati_ids.h
--- linux-2.6.23.orig/drivers/video/aty/ati_ids.h_=B7=B7=B7=B7=B7=B72007-10=
-10 00:33:44.000000000 +0200
+++ linux-2.6.23/drivers/video/aty/ati_ids.h_=B7=B7=B72007-12-06 20:25:03.0=
00000000 +0100
@@ -72,6 +72,7 @@
 #define PCI_CHIP_R420_JM                0x4A4D
 #define PCI_CHIP_R420_JN                0x4A4E
 #define PCI_CHIP_R420_JP                0x4A50
+#define PCI_CHIP_R480_KI               0x4B49
 #define PCI_CHIP_MACH64LB              0x4C42
 #define PCI_CHIP_MACH64LD              0x4C44
 #define PCI_CHIP_RAGE128LE             0x4C45
diff -Naurd linux-2.6.23.orig/drivers/video/aty/radeon_base.c linux-2.6.23/=
drivers/video/aty/radeon_base.c
--- linux-2.6.23.orig/drivers/video/aty/radeon_base.c_=B7=B72007-10-10 00:3=
3:44.000000000 +0200
+++ linux-2.6.23/drivers/video/aty/radeon_base.c_=B7=B7=B7=B7=B7=B7=B72007-=
12-06 20:26:18.000000000 +0100
@@ -220,6 +220,7 @@
        CHIP_DEF(PCI_CHIP_R423_UR,      R420,   CHIP_HAS_CRTC2),
        CHIP_DEF(PCI_CHIP_R423_UT,      R420,   CHIP_HAS_CRTC2),
        CHIP_DEF(PCI_CHIP_R423_5D57,    R420,   CHIP_HAS_CRTC2),
+       CHIP_DEF(PCI_CHIP_R480_KI,      R420,   CHIP_HAS_CRTC2),
        /* Original Radeon/7200 */
        CHIP_DEF(PCI_CHIP_RADEON_QD,    RADEON,_0),
        CHIP_DEF(PCI_CHIP_RADEON_QE,    RADEON,_0),


with no success :(

Thanks
Elimar


-- =

  Do you smell something burning or ist it me?

-------------------------------------------------------------------------
SF.Net email is sponsored by: =

Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
