From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 13 Jan 2010 23:40:29 +0000
Subject: [PATCH 09/11] metronomefb: declare MODULE_FIRMWARE
Message-Id: <1263426029.3852.126.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/metronomefb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index 661bfd2..7b89532 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -792,3 +792,4 @@ module_exit(metronomefb_exit);
 MODULE_DESCRIPTION("fbdev driver for Metronome controller");
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("metronome.wbf");
-- 
1.6.5.7



