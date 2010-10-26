From: Julia Lawall <julia@diku.dk>
Date: Tue, 26 Oct 2010 10:25:41 +0000
Subject: [PATCH 12/14] drivers/video/omap/blizzard.c: delete double assignment
Message-Id: <1288088743-3725-13-git-send-email-julia@diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1288088743-3725-1-git-send-email-julia@diku.dk>
In-Reply-To: <1288088743-3725-1-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Delete successive assignments to the same location.  Initialize the out_y
field as well as the out_x field, rather than initializing the out_x field
twice.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression i;
@@

*i = ...;
 i = ...;
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
This changes the semantics and has not been tested.

 drivers/video/omap/blizzard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index 2ffb34a..87785c2 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -1590,7 +1590,7 @@ static int blizzard_init(struct omapfb_device *fbdev, int ext_mode,
 	blizzard.auto_update_window.width = fbdev->panel->x_res;
 	blizzard.auto_update_window.height = fbdev->panel->y_res;
 	blizzard.auto_update_window.out_x = 0;
-	blizzard.auto_update_window.out_x = 0;
+	blizzard.auto_update_window.out_y = 0;
 	blizzard.auto_update_window.out_width = fbdev->panel->x_res;
 	blizzard.auto_update_window.out_height = fbdev->panel->y_res;
 	blizzard.auto_update_window.format = 0;

