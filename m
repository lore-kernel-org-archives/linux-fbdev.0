From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:19:17 +0000
Subject: [PATCH] video: fbdev: exynos: exynos_mipi_dsi_common.c:  Cleaning up variable that is never used
Message-Id: <1404562757-19274-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
index 85edabf..9e4f9bd 100644
--- a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
@@ -219,11 +219,9 @@ int exynos_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
 	case MIPI_DSI_GENERIC_LONG_WRITE:
 	case MIPI_DSI_DCS_LONG_WRITE:
 	{
-		unsigned int size, payload = 0;
+		unsigned int payload = 0;
 		reinit_completion(&dsim_wr_comp);
 
-		size = data_size * 4;
-
 		/* if data count is less then 4, then send 3bytes data.  */
 		if (data_size < 4) {
 			payload = data0[0] |
-- 
1.7.10.4

