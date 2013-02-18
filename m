From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 18 Feb 2013 05:13:01 +0000
Subject: [PATCH 1/5 RESEND] video: s3c-fb: use ARCH_ dependancy
Message-Id: <000201ce0d96$9fa550b0$deeff210$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses ARCH_ dependancy when using s3c-fb.
S3C_DEV_FB, S5P_DEV_FIMD0 cannot be enabled on EXYNOS5.
So, ARCH_ should be used as dependancy for s3c-fb.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e7068c5..049fff1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2025,7 +2025,8 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && (S3C_DEV_FB || S5P_DEV_FIMD0)
+	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX || ARCH_S5P64X0 || \
+		ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.2.5


