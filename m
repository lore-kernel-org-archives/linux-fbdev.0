From: Johann Hanne <jhanne@gmx.de>
Subject: [patch] triviial: add PCI id to atyfb
Date: Thu, 25 Dec 2003 19:13:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200312251913.07445.jhanne@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ziy6/3kh492W66V"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZZz5-0002ny-9b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 10:13:19 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZZz4-0008N1-ND
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 10:13:18 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--Boundary-00=_ziy6/3kh492W66V
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the PCI id in this patch is used on an HP NetServer LH3000, where I've also 
successfully tested it.
00:07.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a)
00:07.0 Class 0300: 1002:4759 (rev 7a)

Cheers, Johann

--Boundary-00=_ziy6/3kh492W66V
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.4.23-kzviati"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-2.4.23-kzviati"

diff -uNr linux-2.4.23/drivers/video/aty/atyfb_base.c linux-2.4.23-kzviati/drivers/video/aty/atyfb_base.c
--- linux-2.4.23/drivers/video/aty/atyfb_base.c	2003-12-17 14:07:39.000000000 +0100
+++ linux-2.4.23-kzviati/drivers/video/aty/atyfb_base.c	2003-12-17 14:11:20.000000000 +0100
@@ -353,6 +353,7 @@
     { 0x4755, 0x4755, 0x00, 0x00, m64n_gtb,     200,  67,  67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
     { 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p,   230,  83,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
     { 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a,   230,  83,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+    { 0x4759, 0x4759, 0x00, 0x00, m64n_iic_p,   230,  83,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
     { 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a,   230,  83,  83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 
     /* Mach64 LT */

--Boundary-00=_ziy6/3kh492W66V--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
