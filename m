From: Nahom <nahomagidew@gmail.com>
Date: Thu, 29 Sep 2016 01:51:14 +0000
Subject: [PATCH] video: console: bitblit: fixed an indentation coding style issue
Message-Id: <1475113874-8319-1-git-send-email-nahomagidew@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nahom <nahomagidew@gmail.com>

Fixed a coding style issue.
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

