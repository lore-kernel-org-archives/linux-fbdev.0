From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:55:02 +0000
Subject: [PATCH 06/20] video: msm: Simplify mdp_blit function
Message-Id: <1300485302-27123-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move the enabling of mdp interrupt, blitting and waiting for blit
to complete to a separate function to simplify the actions completed
by mdp_blit.

Authors:
Dima Zavin <dima@android.com>
Rebecca Schultz Zavin <rebecca@android.com>
Colin Cross <ccross@android.com>

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp.c |   53 ++++++++++++++++++++++++++--------------------
 1 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index c046982..765df06 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -308,6 +308,29 @@ void put_img(struct file *src_file, struct file *dst_file)
 {
 }
 
+int mdp_blit_and_wait(struct mdp_info *mdp, struct mdp_blit_req *req,
+		struct file *src_file, unsigned long src_start,
+		unsigned long src_len, struct file *dst_file,
+		unsigned long dst_start, unsigned long dst_len)
+{
+	int ret;
+	enable_mdp_irq(mdp, DL0_ROI_DONE);
+	ret = mdp_ppp_blit(mdp, req,
+			src_file, src_start, src_len,
+			dst_file, dst_start, dst_len);
+	if (unlikely(ret)) {
+		disable_mdp_irq(mdp, DL0_ROI_DONE);
+		return ret;
+	}
+	ret = mdp_ppp_wait(mdp);
+	if (unlikely(ret)) {
+		printk(KERN_ERR "%s: failed!\n", __func__);
+		BUG();
+		return ret;
+	}
+	return 0;
+}
+
 int mdp_blit(struct mdp_device *mdp_dev, struct fb_info *fb,
 	     struct mdp_blit_req *req)
 {
@@ -354,15 +377,11 @@ int mdp_blit(struct mdp_device *mdp_dev, struct fb_info *fb,
 		req->src_rect.w = 16*req->src_rect.w / req->dst_rect.h;
 		req->dst_rect.h = 16;
 		for (i = 0; i < tiles; i++) {
-			enable_mdp_irq(mdp, DL0_ROI_DONE);
-			ret = mdp_ppp_blit(mdp, req, src_file, src_start,
-					   src_len, dst_file, dst_start,
-					   dst_len);
-			if (ret)
-				goto err_bad_blit;
-			ret = mdp_ppp_wait(mdp);
+			ret = mdp_blit_and_wait(mdp, req,
+						src_file, src_start, src_len,
+						dst_file, dst_start, dst_len);
 			if (ret)
-				goto err_wait_failed;
+				goto end;
 			req->dst_rect.y += 16;
 			req->src_rect.x += req->src_rect.w;
 		}
@@ -371,24 +390,12 @@ int mdp_blit(struct mdp_device *mdp_dev, struct fb_info *fb,
 		req->src_rect.w = remainder*req->src_rect.w / req->dst_rect.h;
 		req->dst_rect.h = remainder;
 	}
-	enable_mdp_irq(mdp, DL0_ROI_DONE);
-	ret = mdp_ppp_blit(mdp, req, src_file, src_start, src_len, dst_file,
-			   dst_start,
-			   dst_len);
-	if (ret)
-		goto err_bad_blit;
-	ret = mdp_ppp_wait(mdp);
-	if (ret)
-		goto err_wait_failed;
+	ret = mdp_blit_and_wait(mdp, req,
+				src_file, src_start, src_len,
+				dst_file, dst_start, dst_len);
 end:
 	put_img(src_file, dst_file);
 	mutex_unlock(&mdp_mutex);
-	return 0;
-err_bad_blit:
-	disable_mdp_irq(mdp, DL0_ROI_DONE);
-err_wait_failed:
-	put_img(src_file, dst_file);
-	mutex_unlock(&mdp_mutex);
 	return ret;
 }
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

