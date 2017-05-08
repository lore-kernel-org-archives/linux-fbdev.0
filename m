From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 08 May 2017 06:11:16 +0000
Subject: [PATCH] sm501fb: Silence a coccinelle script warning.
Message-Id: <20170508061116.31471-1-christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, khoroshilov@ispras.ru
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

According to surrounding goto, it is likely that 'goto err_probed_panel' is
expected here.
This change is just done in order to silence some coccinelle scripts
which try to detect wrongly ordered goto.

If 'info->fb[HEAD_PANEL]' and' 'info->fb[HEAD_CRT]' are both NULL, this
means that no 'framebuffer_alloc' has been performed, so 'goto err_alloc'
looks fine.
Anyway, it is also harmless in this case to call 'framebuffer_release'.
The code looks more straight forward.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/sm501fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 67e314fdd947..4d89b045ce40 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1990,7 +1990,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 	    info->fb[HEAD_CRT] = NULL) {
 		dev_err(dev, "no framebuffers found\n");
 		ret = -ENODEV;
-		goto err_alloc;
+		goto err_probed_panel;
 	}
 
 	/* get the resources for both of the framebuffers */
-- 
2.11.0

