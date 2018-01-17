From: Max Staudt <mstaudt@suse.de>
Date: Wed, 17 Jan 2018 20:54:30 +0000
Subject: [RFC PATCH v3 08/13] sysrq: Disable bootsplash on SAK
Message-Id: <20180117205435.2860-9-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180117205435.2860-1-mstaudt@suse.de>
In-Reply-To: <20180117205435.2860-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, philm@manjaro.org, bernhard.rosenkranzer@linaro.org, kernel.max@enpas.org

When the user requests a clean TTY via the SAK SysRq, that means he
really wants to use the console.

Let's disable the bootsplash, even if the request is not on a VT, as
the user probably knows what he's doing and it's more helpful to get
out of his way.

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/tty/sysrq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 3ffc1ce29023..bc6a24c9dfa8 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -49,6 +49,7 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/bootsplash.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -104,6 +105,8 @@ static void sysrq_handle_SAK(int key)
 {
 	struct work_struct *SAK_work = &vc_cons[fg_console].SAK_work;
 	schedule_work(SAK_work);
+
+	bootsplash_disable();
 }
 static struct sysrq_key_op sysrq_SAK_op = {
 	.handler	= sysrq_handle_SAK,
-- 
2.12.3

