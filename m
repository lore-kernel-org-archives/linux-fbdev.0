From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/7] nvidiafb: Ensure that CRTC
	registers are accessible
Date: Mon, 09 Apr 2007 19:43:09 +0800
Message-ID: <461A26CD.4060502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HasL1-0001qh-8Z for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:47:11 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HasL0-0006Kz-UE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:47:11 -0700
Received: by py-out-1112.google.com with SMTP id a29so1005416pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Apr 2007 04:47:10 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- Ensure that CRTC registers are accessible by unlocking them on
  set_par(), otherwise i2c reading will fail.

- The function nvidia_vga_protect(), does not protect the VGA
  registers, but turns off the screen.  Rename it to
  nvidia_screen_off().

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nvidia.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index b97ec69..c6afafc 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -200,7 +200,7 @@ static int nvidia_panel_tweak(struct nvi
    return tweak;
 }
 
-static void nvidia_vga_protect(struct nvidia_par *par, int on)
+static void nvidia_screen_off(struct nvidia_par *par, int on)
 {
 	unsigned char tmp;
 
@@ -649,7 +649,7 @@ static int nvidiafb_set_par(struct fb_in
 		NVLockUnlock(par, 0);
 	}
 
-	nvidia_vga_protect(par, 1);
+	nvidia_screen_off(par, 1);
 
 	nvidia_write_regs(par, &par->ModeReg);
 	NVSetStartAddress(par, 0);
@@ -687,7 +687,7 @@ #endif
 
 	par->cursor_reset = 1;
 
-	nvidia_vga_protect(par, 0);
+	nvidia_screen_off(par, 0);
 
 #ifdef CONFIG_BOOTX_TEXT
 	/* Update debug text engine */
@@ -696,6 +696,7 @@ #ifdef CONFIG_BOOTX_TEXT
 			     info->var.bits_per_pixel, info->fix.line_length);
 #endif
 
+	NVLockUnlock(par, 0);
 	NVTRACE_LEAVE();
 	return 0;
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
