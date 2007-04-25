From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/41] rivafb: Fix IO access
Date: Wed, 25 Apr 2007 14:22:42 +0800
Message-ID: <462EF3B2.4070507@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc5V-0000ph-AV for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:53 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc5V-0002pB-1g
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:53 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:38:52 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix IO access, with the following sparse warnings:

drivers/video/riva/fbdev.c:320:25: warning: dereference of noderef expression
drivers/video/riva/fbdev.c:321:29: warning: dereference of noderef expression
drivers/video/riva/fbdev.c:327:18: warning: dereference of noderef expression
drivers/video/riva/fbdev.c:328:15: warning: dereference of noderef expression

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/riva/fbdev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 2dcdf0e..0fe5478 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -317,15 +317,15 @@ static int riva_bl_update_status(struct 
 	else
 		level = bd->props.brightness;
 
-	tmp_pmc = par->riva.PMC[0x10F0/4] & 0x0000FFFF;
-	tmp_pcrt = par->riva.PCRTC0[0x081C/4] & 0xFFFFFFFC;
+	tmp_pmc = NV_RD32(par->riva.PMC, 0x10F0) & 0x0000FFFF;
+	tmp_pcrt = NV_RD32(par->riva.PCRTC0, 0x081C) & 0xFFFFFFFC;
 	if(level > 0) {
 		tmp_pcrt |= 0x1;
 		tmp_pmc |= (1 << 31); /* backlight bit */
 		tmp_pmc |= riva_bl_get_level_brightness(par, level) << 16; /* level */
 	}
-	par->riva.PCRTC0[0x081C/4] = tmp_pcrt;
-	par->riva.PMC[0x10F0/4] = tmp_pmc;
+	NV_WR32(par->riva.PCRTC0, 0x081C, tmp_pcrt);
+	NV_WR32(par->riva.PMC, 0x10F0, tmp_pmc);
 
 	return 0;
 }


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
