From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 09/10] nvidiafb: Adjust flags to take
 advantage of new scroll method
Date: Thu, 17 May 2007 05:26:28 +0800
Message-ID: <464B7704.2030405@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoR9w-0005wD-Qk for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:49 -0700
Received: from wr-out-0506.google.com ([64.233.184.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoR9v-0003Tr-51
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:48 -0700
Received: by wr-out-0506.google.com with SMTP id i20so716473wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 14:35:46 -0700 (PDT)
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

The SCROLL_MOVE method has been optimized such that it is significantly faster
than SCROLL_REDRAW. Adjust flags to indicate that blitting is preferred over
rendering.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nvidia.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 41f6365..8c3a253 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -674,6 +674,7 @@ #endif
 		info->fbops->fb_sync = nvidiafb_sync;
 		info->pixmap.scan_align = 4;
 		info->flags &= ~FBINFO_HWACCEL_DISABLED;
+		info->flags |= FBINFO_READS_FAST;
 		NVResetGraphics(info);
 	} else {
 		info->fbops->fb_imageblit = cfb_imageblit;
@@ -682,6 +683,7 @@ #endif
 		info->fbops->fb_sync = NULL;
 		info->pixmap.scan_align = 1;
 		info->flags |= FBINFO_HWACCEL_DISABLED;
+		info->flags &= ~FBINFO_READS_FAST;
 	}
 
 	par->cursor_reset = 1;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
