From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, 20 Sep 2019 06:25:35 +0000
Subject: [PATCH 23/32] vgacon: Use pr_warn instead of pr_warning
Message-Id: <20190920062544.180997-24-wangkefeng.wang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andy Whitcroft <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: wangkefeng.wang@huawei.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
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
