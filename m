From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Thu, 29 Jan 2015 10:24:16 +0000
Subject: [PATCH 2/3 v3] hyperv: hyperv_fb.c: match wait_for_completion_timeout return type
Message-Id: <1422527056-24929-1-git-send-email-der.herr@hofr.at>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devel@linuxdriverproject.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

The return type of wait_for_completion_timeout is unsigned long not
int. This patch fixes up the declarations only.

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---

v2: fixed subject line
v3: fixed patch description as recommended by Dan Carpenter
    <dan.carpenter@oracle.com>

Patch was compile tested only for x86_64_defconfig + CONFIG_X86_VSMP=y
CONFIG_HYPERV=m, CONFIG_FB_HYPERV=m

Patch is against 3.19.0-rc5 -next-20150123

 drivers/video/fbdev/hyperv_fb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 4254336..807ee22 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -415,7 +415,8 @@ static int synthvid_negotiate_ver(struct hv_device *hdev, u32 ver)
 	struct fb_info *info = hv_get_drvdata(hdev);
 	struct hvfb_par *par = info->par;
 	struct synthvid_msg *msg = (struct synthvid_msg *)par->init_buf;
-	int t, ret = 0;
+	int ret = 0;
+	unsigned long t;
 
 	memset(msg, 0, sizeof(struct synthvid_msg));
 	msg->vid_hdr.type = SYNTHVID_VERSION_REQUEST;
@@ -488,7 +489,8 @@ static int synthvid_send_config(struct hv_device *hdev)
 	struct fb_info *info = hv_get_drvdata(hdev);
 	struct hvfb_par *par = info->par;
 	struct synthvid_msg *msg = (struct synthvid_msg *)par->init_buf;
-	int t, ret = 0;
+	int ret = 0;
+	unsigned long t;
 
 	/* Send VRAM location */
 	memset(msg, 0, sizeof(struct synthvid_msg));
-- 
1.7.10.4

