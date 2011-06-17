From: Pavel Shved <shved@ispras.ru>
Date: Fri, 17 Jun 2011 16:25:12 +0000
Subject: [PATCH] hecubafb: add module_put on error path in hecubafb_probe()
Message-Id: <1308327913-23220-3-git-send-email-shved@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308327913-23220-1-git-send-email-shved@ispras.ru>
In-Reply-To: <1308327913-23220-1-git-send-email-shved@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Pavel Shved <shved@ispras.ru>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@ispras.ru

In hecubafb_probe(), after a successful try_module_get, vzalloc may
fail and make the hecubafb_probe return, but the module is not put on
this error path.

This patch adds an exit point that calls module_put in such situation.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Pavel Shved <shved@ispras.ru>
---
 drivers/video/hecubafb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index fbef15f..614251a 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -233,7 +233,7 @@ static int __devinit hecubafb_probe(struct platform_device *dev)
 
 	videomemory = vzalloc(videomemorysize);
 	if (!videomemory)
-		return retval;
+		goto err_videomem_alloc;
 
 	info = framebuffer_alloc(sizeof(struct hecubafb_par), &dev->dev);
 	if (!info)
@@ -275,6 +275,7 @@ err_fbreg:
 	framebuffer_release(info);
 err_fballoc:
 	vfree(videomemory);
+err_videomem_alloc:
 	module_put(board->owner);
 	return retval;
 }
-- 
1.7.0.2

