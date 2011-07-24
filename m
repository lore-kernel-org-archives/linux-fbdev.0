From: Wanlong Gao <wanlong.gao@gmail.com>
Date: Sun, 24 Jul 2011 04:18:42 +0000
Subject: [PATCH] drivers:video:remove the dup include file prefetch.h
Message-Id: <1311481122-11398-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

linux/prefetch.h has been incuded more than once.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/video/udlfb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 816a4fd..087fc99 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <linux/delay.h>
-#include <linux/prefetch.h>
 #include <video/udlfb.h>
 #include "edid.h"
 
-- 
1.7.4.1

