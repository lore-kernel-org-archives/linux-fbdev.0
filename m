From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 18 Feb 2013 05:18:24 +0000
Subject: [PATCH 5/5 RESEND] video: s3c-fb: Fix typo in definition of VIDCON1_VSTATUS_FRONTPORCH value
Message-Id: <000601ce0d97$60175e10$20461a30$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000201ce0d96$9fa550b0$deeff210$%han@samsung.com>
In-Reply-To: <000201ce0d96$9fa550b0$deeff210$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jingoo Han' <jg1.han@samsung.com>

From: Tomasz Figa <t.figa@samsung.com>

The correct value for VIDCON1_VSTATUS_FRONTPORCH is 3, not 0.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index 2f95d9a..b039320 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -82,7 +82,7 @@
 #define VIDCON1_VSTATUS_VSYNC			(0x0 << 13)
 #define VIDCON1_VSTATUS_BACKPORCH		(0x1 << 13)
 #define VIDCON1_VSTATUS_ACTIVE			(0x2 << 13)
-#define VIDCON1_VSTATUS_FRONTPORCH		(0x0 << 13)
+#define VIDCON1_VSTATUS_FRONTPORCH		(0x3 << 13)
 #define VIDCON1_VCLK_MASK			(0x3 << 9)
 #define VIDCON1_VCLK_HOLD			(0x0 << 9)
 #define VIDCON1_VCLK_RUN			(0x1 << 9)
-- 
1.7.2.5


