From: Dave Martin <dave.martin@linaro.org>
Date: Wed, 05 Oct 2011 16:05:05 +0000
Subject: [PATCH 14/16] fbdev: amba: Enable module alias autogeneration for AMBA drivers
Message-Id: <1317830707-17517-15-git-send-email-dave.martin@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/video/amba-clcd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 2cda6ba..0a2cce7 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -621,6 +621,8 @@ static struct amba_id clcdfb_id_table[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, clcdfb_id_table);
+
 static struct amba_driver clcd_driver = {
 	.drv 		= {
 		.name	= "clcd-pl11x",
-- 
1.7.4.1

