From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 18 Dec 2018 13:25:08 +0000
Subject: [PATCH v2 -next] staging: fbtft: use strcmp() instead of strncmp() for
Message-Id: <20181218132508.18672-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, leobras.c@gmail.co, radek.dostal@streamunlimited.co
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>

strncmp() stops comparing when either the end of one of the first two 
arguments is reached or when 'n' characters have been compared, whichever
comes first.That means that strncmp(s1, s2, n) is equivalent to 
strcmp(s1, s2) if n exceeds the length of s1 or the length of s2.

This patch avoids that the following warning is reported by smatch:

drivers/staging/fbtft/fbtft_device.c:1458
 fbtft_device_init() error: strncmp() '"list"' too small (5 vs 32)

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix patch title
---
 drivers/staging/fbtft/fbtft_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 50e97da..0e995028 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -1455,7 +1455,7 @@ static int __init fbtft_device_init(void)
 	}
 
 	/* name=list lists all supported displays */
-	if (strncmp(name, "list", FBTFT_GPIO_NAME_SIZE) = 0) {
+	if (strcmp(name, "list") = 0) {
 		pr_info("Supported displays:\n");
 
 		for (i = 0; i < ARRAY_SIZE(displays); i++)
-- 
2.7.0
