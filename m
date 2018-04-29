From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 29 Apr 2018 17:53:07 +0000
Subject: [PATCH] staging: sm750fb: add drm development branch details
Message-Id: <1525024387-8678-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The sm750 driver in staging has no future as new framebuffer driver
will not be added to fbdev anymore. A drm driver is being prepared, and
the details added to the TODO file. This sm750fb driver will be removed
as soon as the drm driver is ready. Also, remove my old email.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/staging/sm750fb/TODO | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
index f710ab1..aeb2df3 100644
--- a/drivers/staging/sm750fb/TODO
+++ b/drivers/staging/sm750fb/TODO
@@ -9,8 +9,11 @@ TODO:
 - must be ported to the atomic kms framework in the drm subsystem (which will
   give you a basic fbdev driver for free)
 
+Note:
+- This driver will be removed from staging after the drm driver is ready
+- The drm driver is getting ready at https://gitlab.com/sudipm/sm750/tree/sm750
+
 Please send any patches to
 	Greg Kroah-Hartman <greg@kroah.com>
 	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 	Teddy Wang <teddy.wang@siliconmotion.com>
-	Sudip Mukherjee <sudip@vectorindia.org>
-- 
1.9.1

