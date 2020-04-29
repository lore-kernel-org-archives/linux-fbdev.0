From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 29 Apr 2020 04:34:38 +0000
Subject: [PATCH] video: fbdev: pxa3xx_gcu: Fix some resource leak in an error handling path in 'pxa3xx_gcu_pr
Message-Id: <20200429043438.96212-1-christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, mpe@ellerman.id.au, zhenzhong.duan@gmail.com, arnd@arndb.de, tglx@linutronix.de, eric.y.miao@gmail.com, daniel@caiaq.de
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

If an error occurs in the loop where we call 'pxa3xx_gcu_add_buffer()',
any resource already allocated should be freed.

In order to fix it, add a call to 'pxa3xx_gcu_free_buffers()' in the error
handling path, as already done in the remove function.

Fixes: 364dbdf3b6c3 ("video: add driver for PXA3xx 2D graphics accelerator")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 4279e13a3b58..68d9c7a681d4 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -675,6 +675,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 err_disable_clk:
 	clk_disable_unprepare(priv->clk);
+	pxa3xx_gcu_free_buffers(dev, priv);
 
 	return ret;
 }
-- 
2.25.1
