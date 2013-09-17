From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:03:19 +0000
Subject: [PATCH 09/19] video: sh_mobile_hdmi: use dev_get_platdata()
Message-Id: <000e01ceb363$39e44b00$adace100$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/sh_mobile_hdmi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index bfe4728..45417fa 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -498,7 +498,7 @@ static void sh_hdmi_video_config(struct sh_hdmi *hdmi)
 static void sh_hdmi_audio_config(struct sh_hdmi *hdmi)
 {
 	u8 data;
-	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+	struct sh_mobile_hdmi_info *pdata = dev_get_platdata(hdmi->dev);
 
 	/*
 	 * [7:4] L/R data swap control
@@ -815,7 +815,7 @@ static unsigned long sh_hdmi_rate_error(struct sh_hdmi *hdmi,
 		unsigned long *hdmi_rate, unsigned long *parent_rate)
 {
 	unsigned long target = PICOS2KHZ(mode->pixclock) * 1000, rate_error;
-	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+	struct sh_mobile_hdmi_info *pdata = dev_get_platdata(hdmi->dev);
 
 	*hdmi_rate = clk_round_rate(hdmi->hdmi_clk, target);
 	if ((long)*hdmi_rate < 0)
@@ -1271,7 +1271,7 @@ static void sh_hdmi_htop1_init(struct sh_hdmi *hdmi)
 
 static int __init sh_hdmi_probe(struct platform_device *pdev)
 {
-	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
+	struct sh_mobile_hdmi_info *pdata = dev_get_platdata(&pdev->dev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *htop1_res;
 	int irq = platform_get_irq(pdev, 0), ret;
-- 
1.7.10.4


