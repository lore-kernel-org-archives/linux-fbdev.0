From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/5] neofb: take existing display configuration as default
Date: Wed, 11 Jan 2006 19:52:17 +0800
Message-ID: <43C4F171.2010902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ewf5L-0005pR-JJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:15 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ewf5L-0006rP-By
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:15 -0800
Received: by zproxy.gmail.com with SMTP id 13so123669nzp
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Jan 2006 04:28:13 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Christian Trefzer <ctrefzer@gmx.de>

From: Christian Trefzer <ctrefzer@gmx.de>

on a Dell Latitude CPi-A I noticed a strangeness wrt. the handling of an
external monitor by the neomagic framebuffer driver, namely when the
laptop is docked in a C/Dock II with the lid shut.

A cold boot would result in the BIOS configuring the video chip to use
the "external monitor only" mode, yet neofb would default to "internal
LCD only".  An attempt for a quick fix by using the Fn-F8 keystroke to
toggle the display combination modes resulted in a reproductible hard
lock, powering down being the only solution.

The attached patch makes neofb probe the register for the current
display mode, using that value as a default if nothing was specified as
kernel/module parameter.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/neofb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index e18c9f9..747602a 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -853,7 +853,7 @@ static int neofb_set_par(struct fb_info 
 	/* If the user did not specify any display devices, then... */
 	if (par->PanelDispCntlReg1 == 0x00) {
 		/* Default to internal (i.e., LCD) only. */
-		par->PanelDispCntlReg1 |= 0x02;
+		par->PanelDispCntlReg1 = vga_rgfx(NULL, 0x20) & 0x03;
 	}
 
 	/* If we are using a fixed mode, then tell the chip we are. */



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
