From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 19 Dec 2011 02:09:35 +0000
Subject: [PATCH] MAINTAINERS: add a maintainer for Samsung Framebuffer driver
Message-Id: <003c01ccbdf3$41843df0$c48cb9d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add a maintainer for Samsung Framebuffer driver.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 855afd4..a03e288 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5667,6 +5667,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/samsung
 
+SAMSUNG FRAMEBUFFER DRIVER
+M:	Jingoo Han <jg1.han@samsung.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	drivers/video/s3c-fb.c
+
 SERIAL DRIVERS
 M:	Alan Cox <alan@linux.intel.com>
 L:	linux-serial@vger.kernel.org
-- 
1.7.1


