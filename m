From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:04 +0000
Subject: [WIP/RFC 26/31] media: Initialize media controller core with subsys_initcall
Message-Id: <1316392089-27598-27-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The media controller core needs to be initialized before the frame
buffer devices. Use subsys_initcall() instead of module_init().

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/media-devnode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/media-devnode.c b/drivers/media/media-devnode.c
index 7b42ace..06a06b1 100644
--- a/drivers/media/media-devnode.c
+++ b/drivers/media/media-devnode.c
@@ -312,8 +312,8 @@ static void __exit media_devnode_exit(void)
 	unregister_chrdev_region(media_dev_t, MEDIA_NUM_DEVICES);
 }
 
-module_init(media_devnode_init)
-module_exit(media_devnode_exit)
+subsys_initcall(media_devnode_init);
+module_exit(media_devnode_exit);
 
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
 MODULE_DESCRIPTION("Device node registration for media drivers");
-- 
1.7.3.4

