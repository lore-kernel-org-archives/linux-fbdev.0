From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 Jan 2015 13:51:59 +0000
Subject: [PATCH 3/3] backlight: 88pm860x_bl: Use of_get_child_by_name() instead of refcount hack
Message-Id: <1421243519-6257-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421243519-6257-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421243519-6257-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

of_find_node_by_name() calls of_node_put() on its "from" parameter.
To counter this, pm860x_backlight_dt_init() calls of_node_get() first.

Use of_get_child_by_name() instead to get rid of the refcount hack.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-fbdev@vger.kernel.org
---
Compile-tested only
---
 drivers/video/backlight/88pm860x_bl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
index 9a23698b6fe8398c..2da5862876d1fe78 100644
--- a/drivers/video/backlight/88pm860x_bl.c
+++ b/drivers/video/backlight/88pm860x_bl.c
@@ -168,10 +168,7 @@ static int pm860x_backlight_dt_init(struct platform_device *pdev,
 	struct device_node *nproot, *np;
 	int iset = 0;
 
-	nproot = of_node_get(pdev->dev.parent->of_node);
-	if (!nproot)
-		return -ENODEV;
-	nproot = of_find_node_by_name(nproot, "backlights");
+	nproot = of_get_child_by_name(pdev->dev.parent->of_node, "backlights");
 	if (!nproot) {
 		dev_err(&pdev->dev, "failed to find backlights node\n");
 		return -ENODEV;
-- 
1.9.1

