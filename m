From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Sat, 10 Jun 2017 09:05:36 +0000
Subject: [PATCH 7/7] staging/atomisp: use MEDIA_VERSION instead of KERNEL_VERSION
Message-Id: <20170610090536.12472-8-jthumshirn@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170610090536.12472-1-jthumshirn@suse.de>
In-Reply-To: <20170610090536.12472-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>

Use MEDIA_VERSION instead of KERNEL_VERSION to encode the driver
version of the Atom ISP driver.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/staging/media/atomisp/include/linux/atomisp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp.h b/drivers/staging/media/atomisp/include/linux/atomisp.h
index 35865462ccf9..0b664ee6f825 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp.h
@@ -30,9 +30,9 @@
 
 /* struct media_device_info.driver_version */
 #define ATOMISP_CSS_VERSION_MASK	0x00ffffff
-#define ATOMISP_CSS_VERSION_15		KERNEL_VERSION(1, 5, 0)
-#define ATOMISP_CSS_VERSION_20		KERNEL_VERSION(2, 0, 0)
-#define ATOMISP_CSS_VERSION_21		KERNEL_VERSION(2, 1, 0)
+#define ATOMISP_CSS_VERSION_15		MEDIA_REVISION(1, 5, 0)
+#define ATOMISP_CSS_VERSION_20		MEDIA_REVISION(2, 0, 0)
+#define ATOMISP_CSS_VERSION_21		MEDIA_REVISION(2, 1, 0)
 
 /* struct media_device_info.hw_revision */
 #define ATOMISP_HW_REVISION_MASK	0x0000ff00
-- 
2.12.3

