From: Anton Vasilyev <vasilyev@ispras.ru>
Date: Wed, 01 Mar 2017 16:38:08 +0000
Subject: [PATCH] Incorrect URL given in drivers/video/fbdev/Kconfig
Message-Id: <1488386288-27328-1-git-send-email-vasilyev@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

Modify link to FrameBuffer HOWTO because original link become unavailable

Found by Linux Driver Verification project (linuxtesting.org)

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 5d3b0db..f78043e 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -26,7 +26,7 @@ menuconfig FB
 	  You need an utility program called fbset to make full use of frame
 	  buffer devices. Please read <file:Documentation/fb/framebuffer.txt>
 	  and the Framebuffer-HOWTO at
-	  <http://www.munted.org.uk/programming/Framebuffer-HOWTO-1.3.html> for more
+	  <http://www.tldp.org/HOWTO/pdf/Framebuffer-HOWTO.pdf> for more
 	  information.
 
 	  Say Y here and to the driver for your graphics board below if you
-- 
2.7.4

