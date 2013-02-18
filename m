From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 18 Feb 2013 05:16:38 +0000
Subject: [PATCH 4/5 RESEND] video: s3c-fb: add the bit definitions for CSC EQ709 and EQ601
Message-Id: <000501ce0d97$21294a60$637bdf20$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000201ce0d96$9fa550b0$deeff210$%han@samsung.com>
In-Reply-To: <000201ce0d96$9fa550b0$deeff210$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jingoo Han' <jg1.han@samsung.com>

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


