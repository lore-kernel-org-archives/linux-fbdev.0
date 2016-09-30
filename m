From: Nahom <nahomagidew@gmail.com>
Date: Fri, 30 Sep 2016 01:31:33 +0000
Subject: [PATCH] drivers: video: console: bitblit.c
Message-Id: <1475199093-9254-1-git-send-email-nahomagidew@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixed an indentation coding style issue.

Signed-off-by: Nahom <nahomagidew@gmail.com>
---
 drivers/video/console/bitblit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index dbfe4ee..4e7d0e3 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -256,7 +256,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			y += softback_lines;
 	}
 
- 	c = scr_readw((u16 *) vc->vc_pos);
+	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
 
-- 
2.7.4

