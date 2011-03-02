From: Carl Vanderlip <carlv@codeaurora.org>
Date: Wed, 02 Mar 2011 21:18:19 +0000
Subject: [PATCH 4/4] [ARM] msm: mdp: Set the correct pack pattern for XRGB/ARGB
Message-Id: <1299100699-11705-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299100542-11120-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1299100542-11120-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Dima Zavin <dima@android.com>

Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp_hw.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/msm/mdp_hw.h b/drivers/video/msm/mdp_hw.h
index 9e1e92e..d804774 100644
--- a/drivers/video/msm/mdp_hw.h
+++ b/drivers/video/msm/mdp_hw.h
@@ -489,7 +489,7 @@ int mdp_ppp_blit(const struct mdp_info *mdp, struct mdp_blit_req *req,
 	MDP_GET_PACK_PATTERN(0, CLR_R, CLR_G, CLR_B, 8)
 #define PPP_PACK_PATTERN_MDP_RGB_888 PPP_PACK_PATTERN_MDP_RGB_565
 #define PPP_PACK_PATTERN_MDP_XRGB_8888 \
-	MDP_GET_PACK_PATTERN(CLR_ALPHA, CLR_R, CLR_G, CLR_B, 8)
+	MDP_GET_PACK_PATTERN(CLR_B, CLR_G, CLR_R, CLR_ALPHA, 8)
 #define PPP_PACK_PATTERN_MDP_ARGB_8888 PPP_PACK_PATTERN_MDP_XRGB_8888
 #define PPP_PACK_PATTERN_MDP_RGBA_8888 \
 	MDP_GET_PACK_PATTERN(CLR_ALPHA, CLR_B, CLR_G, CLR_R, 8)
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

