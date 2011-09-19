From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:53 +0000
Subject: [WIP/RFC 15/31] fbdev: sh_mobile_hdmi: Remove sh_mobile_hdmi_info lcd_chan field
Message-Id: <1316392089-27598-16-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The field is unused, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/video/sh_mobile_hdmi.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/video/sh_mobile_hdmi.h b/include/video/sh_mobile_hdmi.h
index 0b8d2cf..728f9de 100644
--- a/include/video/sh_mobile_hdmi.h
+++ b/include/video/sh_mobile_hdmi.h
@@ -31,7 +31,6 @@ struct clk;
 #define HDMI_SND_SRC_HBR	(3 << 0)
 
 struct sh_mobile_hdmi_info {
-	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
 	unsigned int			 flags;
 	long (*clk_optimize_parent)(unsigned long target, unsigned long *best_freq,
 				    unsigned long *parent_freq);
-- 
1.7.3.4

