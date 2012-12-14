From: Kamal Mostafa <kamal@whence.com>
Date: Fri, 14 Dec 2012 20:30:15 +0000
Subject: [PATCH] fbcon: clear the logo bitmap from the margin area
Message-Id: <1355517015-4926-1-git-send-email-kamal@whence.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Explicitly clear_margins when clearing the logo, in case the font dimensions
are non-integral to the framebuffer dimensions.

Signed-off-by: Kamal Mostafa <kamal@whence.com>
---
 drivers/video/console/fbcon.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 8745637..b51a4bd 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1236,8 +1236,16 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 	if (!height || !width)
 		return;
 
-	if (sy < vc->vc_top && vc->vc_top = logo_lines)
+	if (sy < vc->vc_top && vc->vc_top = logo_lines) {
 		vc->vc_top = 0;
+		/*
+		 * If the font dimensions are not an integral of the display
+		 * dimensions then the ops->clear below won't end up clearing
+		 * the margins.  Call clear_margins here in case the logo
+		 * bitmap stretched into the margin area.
+		 */
+		fbcon_clear_margins(vc, 0);
+	}
 
 	/* Split blits that cross physical y_wrap boundary */
 
-- 
1.7.10.4

