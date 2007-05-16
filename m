From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 07/10] imxfb: fix memory hole
Date: Thu, 17 May 2007 05:24:10 +0800
Message-ID: <464B767A.9030502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoR9q-0005w6-OX for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:42 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoR9q-0003Q1-Fn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:42 -0700
Received: by py-out-1112.google.com with SMTP id a29so647770pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 14:35:42 -0700 (PDT)
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

From: Sascha Hauer <s.hauer@pengutronix.de>

info->pseudo_palette was previously kmalloced. Do not overwrite
it afterwards

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/imxfb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 6cdf269..a125898 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -468,7 +468,6 @@ static int __init imxfb_init_fbinfo(stru
 
 	info->fbops			= &imxfb_ops;
 	info->flags			= FBINFO_FLAG_DEFAULT;
-	info->pseudo_palette		= (fbi + 1);
 
 	fbi->rgb[RGB_16]		= &def_rgb_16;
 	fbi->rgb[RGB_8]			= &def_rgb_8;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
