From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 13 Jan 2014 15:22:34 +0000
Subject: [PATCH 2/4] i810: delete useless variable
Message-Id: <1389629847-5330-3-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389629847-5330-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1389629847-5330-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Delete a variable that is at most only assigned to a constant, but never
used otherwise.

A simplified version of the semantic patch that fixes this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
type T;
identifier i;
constant c;
@@

-T i;
<... when != i
-i = c;
...>
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/i810/i810_main.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 038192a..bb674e4 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -2011,9 +2011,7 @@ static int i810fb_init_pci(struct pci_dev *dev,
 	struct fb_info    *info;
 	struct i810fb_par *par = NULL;
 	struct fb_videomode mode;
-	int i, err = -1, vfreq, hfreq, pixclock;
-
-	i = 0;
+	int err = -1, vfreq, hfreq, pixclock;
 
 	info = framebuffer_alloc(sizeof(struct i810fb_par), &dev->dev);
 	if (!info)

