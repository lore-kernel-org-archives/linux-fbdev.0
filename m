From: Francois Romieu <romieu@fr.zoreil.com>
Subject: [patch] Re: GeForce 4 MX have no working frame buffer at all..
Date: Sat, 21 Aug 2004 13:14:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040821111414.GA6818@electric-eye.fr.zoreil.com>
References: <412729BC.5000102@mitose.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByTsc-00078q-7O
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 04:17:50 -0700
Received: from electric-eye.fr.zoreil.com ([213.41.134.224] helo=fr.zoreil.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1ByTsZ-0004qk-8W
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 04:17:49 -0700
Content-Disposition: inline
In-Reply-To: <412729BC.5000102@mitose.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ploum@mitose.net

Ploum Ploum <ploum@mitose.net> :
[...]
> Here's the lspci -vvvv output for the card :
> 
> 0000:02:00.0 VGA compatible controller: nVidia Corporation NV18 
> [GeForce4 MX 440 AGP 8x] (rev a2) (prog-if 00 [VGA])

Try patch below. If it does not work, please send a complete dmesg and
lspci -vx.

diff -puN drivers/video/riva/fbdev.c~rivafb-missing-id drivers/video/riva/fbdev.c
--- linux-2.6.8.1/drivers/video/riva/fbdev.c~rivafb-missing-id	2004-08-21 13:05:41.000000000 +0200
+++ linux-2.6.8.1-romieu/drivers/video/riva/fbdev.c	2004-08-21 13:07:31.000000000 +0200
@@ -1836,6 +1836,7 @@ static u32 riva_get_arch(struct pci_dev 
 		case 0x0110:   /* GeForce2 MX */
 		case 0x0150:   /* GeForce2 */
 		case 0x0170:   /* GeForce4 MX */
+		case 0x0171:   /* GeForce4 MX */
 		case 0x0180:   /* GeForce4 MX (8x AGP) */
 		case 0x01A0:   /* nForce */
 		case 0x01F0:   /* nForce2 */

_


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
