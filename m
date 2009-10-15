From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH 2/8] trivial: fix typo s/complied-in/compiled-in/
Date: Thu, 15 Oct 2009 16:45:25 -0300
Message-ID: <1255635925-5738-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935342AbZJOTqO@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trivial@kernel.org
Cc: jayalk@intworks.biz, lethal@linux-sh.org, damm@igel.co.jp, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/video/fb_defio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index c27ab1e..e59c083 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -71,7 +71,7 @@ int fb_deferred_io_fsync(struct file *file, struct dentry *dentry, int datasync)
 {
 	struct fb_info *info = file->private_data;
 
-	/* Skip if deferred io is complied-in but disabled on this fbdev */
+	/* Skip if deferred io is compiled-in but disabled on this fbdev */
 	if (!info->fbdefio)
 		return 0;
 
-- 
1.6.3.3
