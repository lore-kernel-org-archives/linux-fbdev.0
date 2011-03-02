From: Carl Vanderlip <carlv@codeaurora.org>
Date: Wed, 02 Mar 2011 21:17:51 +0000
Subject: [PATCH 3/4] [ARM] msm_fb: Fix framebuffer console
Message-Id: <1299100671-11665-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299100542-11120-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1299100542-11120-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

From: Arve Hjønnevåg <arve@android.com>

Don't allow non panning updates to bypass the wait for the panel to turn on.

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/msm_fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/msm/msm_fb.c b/drivers/video/msm/msm_fb.c
index fe5efe5..ec35130 100644
--- a/drivers/video/msm/msm_fb.c
+++ b/drivers/video/msm/msm_fb.c
@@ -219,8 +219,8 @@ restart:
 
 	sleeping = msmfb->sleeping;
 	/* on a full update, if the last frame has not completed, wait for it */
-	if (pan_display && (msmfb->frame_requested != msmfb->frame_done ||
-			    sleeping = UPDATING)) {
+	if ((pan_display && msmfb->frame_requested != msmfb->frame_done) ||
+			    sleeping = UPDATING) {
 		int ret;
 		spin_unlock_irqrestore(&msmfb->update_lock, irq_flags);
 		ret = wait_event_interruptible_timeout(msmfb->frame_wq,
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

