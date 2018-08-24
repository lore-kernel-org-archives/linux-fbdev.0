From: Mehdi Bounya <bounya9mehdi@gmail.com>
Date: Fri, 24 Aug 2018 12:49:08 +0000
Subject: [PATCH] Video: vgastate: fixed a spacing coding style
Message-Id: <1535114948-18615-1-git-send-email-contact.mehdi@pm.me>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Mehdi Bounya <contact.mehdi@pm.me>, Mehdi Bounya <mehdi.bounya@gmail.com>

Removed a space between function name and open parant.

Signed-off-by: Mehdi Bounya <mehdi.bounya@gmail.com>
---
 drivers/video/vgastate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
index 548c751..122fb3c 100644
--- a/drivers/video/vgastate.c
+++ b/drivers/video/vgastate.c
@@ -455,7 +455,7 @@ int save_vga(struct vgastate *state)
 	return 0;
 }
 
-int restore_vga (struct vgastate *state)
+int restore_vga(struct vgastate *state)
 {
 	if (state->vidstate = NULL)
 		return 1;
-- 
2.7.4
