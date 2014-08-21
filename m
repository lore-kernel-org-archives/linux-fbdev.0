From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 21 Aug 2014 12:23:57 +0000
Subject: [PATCH] fbdev: Remove __init from chips_hw_init() to fix build failure
Message-Id: <1408623838-8275-1-git-send-email-bobby.prani@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Fix build failure caused as follows:

The function chipsfb_pci_init() references
the function __init chips_hw_init().
This is often because chipsfb_pci_init lacks a __init 
annotation or the annotation of chips_hw_init is wrong.

make: *** [drivers] Error 2

by removing the __init annotation from chips_hw_init(). The other thing that
could have been done was annotating chipsfb_pci_init(). But that cannot be done
since chipsfb_pci_init() is called from non __init functions.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 drivers/video/fbdev/chipsfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 206a66b..59abdc6 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -273,7 +273,7 @@ static struct chips_init_reg chips_init_xr[] = {
 	{ 0xa8, 0x00 }
 };
 
-static void __init chips_hw_init(void)
+static void chips_hw_init(void)
 {
 	int i;
 
-- 
1.9.1

