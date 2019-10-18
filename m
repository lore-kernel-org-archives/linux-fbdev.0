From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, 18 Oct 2019 03:18:41 +0000
Subject: [PATCH v2 24/33] vgacon: Use pr_warn instead of pr_warning
Message-Id: <20191018031850.48498-24-wangkefeng.wang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/video/console/vgacon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index c6b3bdbbdbc9..de7b8382aba9 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -113,9 +113,9 @@ static int __init text_mode(char *str)
 {
 	vgacon_text_mode_force = true;
 
-	pr_warning("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
-	pr_warning("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
-	pr_warning("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
+	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
+	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
+	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
 
 	return 1;
 }
-- 
2.20.1
