From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 26 Dec 2012 08:15:39 +0000
Subject: [PATCH 4/4] video: s3c-fb: add the bit definitions for CSC EQ709 and EQ601
Message-Id: <032b01cde341$3121cad0$93656070$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds the bit definitions for CSC EQ709 and EQ601.
These definitons are used to control the CSC parameter such as
equation 709 and equation 601.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index be7b853..2f95d9a 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -176,6 +176,8 @@
 /* WINCONx */
 
 #define WINCON(_win)				(0x20 + ((_win) * 4))
+#define WINCONx_CSCCON_EQ601			(0x0 << 28)
+#define WINCONx_CSCCON_EQ709			(0x1 << 28)
 #define WINCONx_CSCWIDTH_MASK			(0x3 << 26)
 #define WINCONx_CSCWIDTH_SHIFT			26
 #define WINCONx_CSCWIDTH_WIDE			(0x0 << 26)
-- 
1.7.2.5


