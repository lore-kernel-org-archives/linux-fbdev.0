From: Boris Bezlaj <boris@gajba.net>
Subject: [PATCH] imsttfb small fix
Date: Sat, 31 May 2003 00:28:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030530222844.GA1426@gajba.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
Cc: kernel-janitor-discuss@lists.sourceforge.net

Hi,
patch below should shut the bug messages at kbugs.org(unreleased region,
memory non-free). Please apply(2.5.70).

BTW, i would apreciate some more brainpower  on how to solve this
problem..see photo: http://knjiznica-jesenice.org/~boris/boot/screen.jpg
(wrapping of graphics on left/right border of visible screen).

--- linux-2.5.50/drivers/video/imsttfb.c.orig	2003-05-30 23:43:42.000000000 +0200
+++ linux-2.5.50/drivers/video/imsttfb.c	2003-05-30 23:44:19.000000000 +0200
@@ -1495,6 +1495,8 @@
 		default:
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
+			release_mem_region(addr, size);
+			kfree(info);
 			return -ENODEV;
 	}
 


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
