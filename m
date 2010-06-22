From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Tue, 22 Jun 2010 19:05:56 +0000
Subject: [PATCH] fbcon: deinline large static function get_color()
Message-Id: <1277233556-14827-1-git-send-email-vda.linux@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, Denys Vlasenko <vda.linux@googlemail.com>

This function's body is good two screenfuls and it has six callsites.
No apparent reason why it is marked "iniline".

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
---
 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index b0a3fa0..24983e4 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -286,7 +286,7 @@ static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 		vc->vc_mode != KD_TEXT || ops->graphics);
 }
 
-static inline int get_color(struct vc_data *vc, struct fb_info *info,
+static int get_color(struct vc_data *vc, struct fb_info *info,
 	      u16 c, int is_fg)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
-- 
1.6.2.5

