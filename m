From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:42 +0000
Subject: [PATCH 1/9] MAINTAINERS: Make Timur Tabi the maintainer for the Freescale DIU driver
Message-Id: <1350426830-12140-1-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Timur has been cleaning up this driver, so just make it official.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdc0119..1eeaaf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2895,6 +2895,12 @@ F:	drivers/video/
 F:	include/video/
 F:	include/linux/fb.h
 
+FREESCALE DIU FRAMEBUFFER DRIVER
+M:	Timur Tabi <timur@freescale.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Supported
+F:	drivers/video/fsl-diu-fb.*
+
 FREESCALE DMA DRIVER
 M:	Li Yang <leoli@freescale.com>
 M:	Zhang Wei <zw@zh-kernel.org>
-- 
1.7.3.4


