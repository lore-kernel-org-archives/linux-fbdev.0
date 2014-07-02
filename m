From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Wed, 02 Jul 2014 21:57:12 +0000
Subject: [PATCH] video: fbdev: sh_mipi_dsi.c:  Cleaning up Boolean used in bitwise operation
Message-Id: <1404338232-6708-2-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404338232-6708-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404338232-6708-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Boolean variable is used in bitwise operation.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/sh_mipi_dsi.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mipi_dsi.c b/drivers/video/fbdev/sh_mipi_dsi.c
index 8f6e8ff..39417ab 100644
--- a/drivers/video/fbdev/sh_mipi_dsi.c
+++ b/drivers/video/fbdev/sh_mipi_dsi.c
@@ -113,11 +113,18 @@ static int sh_mipi_dcs_param(int handle, u8 cmd, u8 param)
 
 static void sh_mipi_dsi_enable(struct sh_mipi *mipi, bool enable)
 {
+	unsigned int enable_value;
+
+	if (enable)
+		enable_value = 0x00000003;
+	else
+		enable_value = 0x00000002;
+
 	/*
 	 * enable LCDC data tx, transition to LPS after completion of each HS
 	 * packet
 	 */
-	iowrite32(0x00000002 | enable, mipi->linkbase + DTCTR);
+	iowrite32(enable_value, mipi->linkbase + DTCTR);
 }
 
 static void sh_mipi_shutdown(struct platform_device *pdev)
-- 
1.7.10.4

