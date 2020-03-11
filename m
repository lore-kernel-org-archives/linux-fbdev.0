From: "Jr Carreiro a.k.a Gordo" <jr@reversing.team>
Date: Wed, 11 Mar 2020 01:07:30 +0000
Subject: [PATCH] Staging: fbtft: Remove space prohibited before that close parenthesis ')'
Message-Id: <BN6PR04MB090145E76716CBDCD1289656B4FC0@BN6PR04MB0901.namprd04.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Gordo <jr@reversing.team>

This patch fixes the checkpatch.pl error:

FILE: drivers/staging/fbtft/fbtft-bus.c:65:
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )

 FILE: drivers/staging/fbtft/fbtft-bus.c:67:
 +define_fbtft_write_reg(fbtft_write_reg8_bus8, u16, u16, )
---
 README                            | 3 +++
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 init/main.c                       | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 669ac7c32..700e2fba3 100644
--- a/README
+++ b/README
@@ -16,3 +16,6 @@ several of them using the Restructured Text markup notation.
 Please read the Documentation/process/changes.rst file, as it contains the
 requirements for building and running the kernel, and information about
 the problems which may result by upgrading your kernel.
+
+Checking if send-email works
+
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 63c65dd67..847cbfbbd 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
diff --git a/init/main.c b/init/main.c
index f95b014a5..f8a2f6cb9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1360,6 +1360,7 @@ static int __ref kernel_init(void *unused)
 	numa_default_policy();
 
 	rcu_end_inkernel_boot();
+   pr_err("\n========\nHello LKCAMP !!!\n========\n\n"); 
 
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
-- 
2.20.1
