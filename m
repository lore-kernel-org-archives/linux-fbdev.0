From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] Make radeonfb work with R300
Date: Sun, 23 Mar 2003 18:11:56 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030323171156.GA505@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-6.tiscali.it ([195.130.225.152] helo=mail.tiscali.it)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18x84e-0000kg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Mar 2003 08:11:52 -0800
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, ajoshi@unixbox.com


Hi,
radeonfb is  unable to  acquire the  pll clock values  from the  BIOS on
newer radeon cards and uses default values which don't work.

Using ATI binary driver for X I founded this in the log:

(II) fglrx(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000; xclk=27000

This patch (against 2.5.65) sets pll values according to X:

--- drivers/video/radeonfb.orig.c	Sun Mar 23 16:15:04 2003
+++ drivers/video/radeonfb.c	Sun Mar 23 18:01:48 2003
@@ -881,6 +881,16 @@
 				rinfo->pll.ref_div = 12;
 				rinfo->pll.ref_clk = 2700;
 				break;
+			case PCI_DEVICE_ID_ATI_RADEON_ND:
+			case PCI_DEVICE_ID_ATI_RADEON_NE:
+			case PCI_DEVICE_ID_ATI_RADEON_NF:
+			case PCI_DEVICE_ID_ATI_RADEON_NG:
+				rinfo->pll.ppll_max = 40000;
+				rinfo->pll.ppll_min = 20000;
+				rinfo->pll.xclk = 27000;
+				rinfo->pll.ref_div = 12;
+				rinfo->pll.ref_clk = 2700;
+				break;
 			case PCI_DEVICE_ID_ATI_RADEON_QD:
 			case PCI_DEVICE_ID_ATI_RADEON_QE:
 			case PCI_DEVICE_ID_ATI_RADEON_QF:


It works on  a R300 NE (9500 Pro),  but should be ok also  for the other
R300 chips (don't have the hw to make a test though).

In X log there is also this line:

(II) fglrx(0): Primary V_BIOS segment is: 0xc000

I've no idea of what V_BIOS is (Video BIOS?), but it may be useful ;)


HTH,
Luca
-- 
Home: http://kronoz.cjb.net
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
