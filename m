From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:35 +0000
Subject: [PATCH 13/15] fbdev: sh_mobile_hdmi: improve HDMI PHY parameters
Message-Id: <Pine.LNX.4.64.1009030916300.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

High monitor resolutions also require higher clock frequencies, current HDMI
PHY parameters do not work well for resolutions higher than 720p.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 6f6a042..e1d70e2 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -401,7 +401,7 @@ static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
 		 * [6]		DRV_TEST_EN
 		 * [7]		DRV_TEST_IN
 		 */
-		hdmi_write(hdmi, 0x19, HDMI_SLIPHDMIT_PARAM_SETTINGS_1);
+		hdmi_write(hdmi, 0x0f, HDMI_SLIPHDMIT_PARAM_SETTINGS_1);
 		/* PLLB_CONFIG[17], PLLA_CONFIG[17] - not in PHY datasheet */
 		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_2);
 		/*
@@ -422,7 +422,7 @@ static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
 		 * PLLB_CONFIG[15:8]: regulator voltage[0], CP current,
 		 * LPF capacitance, LPF resistance[1]
 		 */
-		hdmi_write(hdmi, 0x0E, HDMI_SLIPHDMIT_PARAM_SETTINGS_8);
+		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_8);
 		/* DRV_CONFIG, PE_CONFIG */
 		hdmi_write(hdmi, 0x25, HDMI_SLIPHDMIT_PARAM_SETTINGS_9);
 		/*
-- 
1.7.1

