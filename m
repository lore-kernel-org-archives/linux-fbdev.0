From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 27 Nov 2019 16:32:08 +0000
Subject: [PATCH 12/13] media: constify fb ops across all drivers
Message-Id: <2f8755b70308bf917c0ad8f5b6040fa2a4862b94.1574871797.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <cover.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andy Walls <awalls@md.metrocast.net>, jani.nikula@intel.com, intel-gfx@lists.freedesktop.org, ivtv-devel@ivtvdriver.org, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org

Now that the fbops member of struct fb_info is const, we can star making
the ops const as well.

Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Andy Walls <awalls@md.metrocast.net>
Cc: linux-media@vger.kernel.org
Cc: ivtv-devel@ivtvdriver.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/media/pci/ivtv/ivtvfb.c          | 3 +--
 drivers/media/platform/vivid/vivid-osd.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 95a56cce9b65..f2922b554b09 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -925,7 +925,7 @@ static int ivtvfb_blank(int blank_mode, struct fb_info *info)
 	return 0;
 }
 
-static struct fb_ops ivtvfb_ops = {
+static const struct fb_ops ivtvfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_write       = ivtvfb_write,
 	.fb_check_var   = ivtvfb_check_var,
@@ -1049,7 +1049,6 @@ static int ivtvfb_init_vidmode(struct ivtv *itv)
 
 	oi->ivtvfb_info.node = -1;
 	oi->ivtvfb_info.flags = FBINFO_FLAG_DEFAULT;
-	oi->ivtvfb_info.fbops = &ivtvfb_ops;
 	oi->ivtvfb_info.par = itv;
 	oi->ivtvfb_info.var = oi->ivtvfb_defined;
 	oi->ivtvfb_info.fix = oi->ivtvfb_fix;
diff --git a/drivers/media/platform/vivid/vivid-osd.c b/drivers/media/platform/vivid/vivid-osd.c
index f2e789bdf4a6..2160a4d3c2f2 100644
--- a/drivers/media/platform/vivid/vivid-osd.c
+++ b/drivers/media/platform/vivid/vivid-osd.c
@@ -311,7 +311,6 @@ static int vivid_fb_init_vidmode(struct vivid_dev *dev)
 
 	dev->fb_info.node = -1;
 	dev->fb_info.flags = FBINFO_FLAG_DEFAULT;
-	dev->fb_info.fbops = &vivid_fb_ops;
 	dev->fb_info.par = dev;
 	dev->fb_info.var = dev->fb_defined;
 	dev->fb_info.fix = dev->fb_fix;
-- 
2.20.1
