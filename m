From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:54 +0000
Subject: [RFC 06/14] bootsplash: Disable on SysRq SAK
Message-Id: <20171025124602.28292-7-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

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

