From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 25 Feb 2011 21:05:47 +0000
Subject: [PATCH] video: msmfb: Put the partial update magic value into the fix_screen struct.
Message-Id: <1298667947-22123-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davidb@codeaurora.org
Cc: Dima Zavin <dima@android.com>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

From: Dima Zavin <dima@android.com>

This can then be tested by userspace to see if the capability is supported.
Userspace cannot rely on that value being left in var_screen, since userspace
itself can change it.

---
 drivers/video/msm/msm_fb.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/video/msm/msm_fb.c b/drivers/video/msm/msm_fb.c
index 5436aeb..bbf841e 100644
--- a/drivers/video/msm/msm_fb.c
+++ b/drivers/video/msm/msm_fb.c
@@ -469,6 +469,14 @@ static void setup_fb_info(struct msmfb_info *msmfb)
 	fb_info->var.yoffset = 0;
 
 	if (msmfb->panel->caps & MSMFB_CAP_PARTIAL_UPDATES) {
+		/* set the param in the fixed screen, so userspace can't
+		 * change it. This will be used to check for the
+		 * capability. */
+		fb_info->fix.reserved[0] = 0x5444;
+		fb_info->fix.reserved[1] = 0x5055;
+
+		/* This preloads the value so that if userspace doesn't
+		 * change it, it will be a full update */
 		fb_info->var.reserved[0] = 0x54445055;
 		fb_info->var.reserved[1] = 0;
 		fb_info->var.reserved[2] = (uint16_t)msmfb->xres |
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

