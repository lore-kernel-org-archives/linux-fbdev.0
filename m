From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Tue, 24 Jan 2012 15:44:42 +0000
Subject: [PATCH] fix NULL pointer dereference in DSS2 VENC sysfs debug attr on OMAP4
Message-Id: <1327419882-13578-1-git-send-email-danny.kukawka@bisect.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Commit ba02fa37de80bea10d706f39f076dd848348320a disabled the
venc driver registration on OMAP4. Since the driver never gets
probed/initialised your get a dereferenceed NULL pointer if you
try to get info from /sys/kernel/debug/omapdss/venc

Return info message about disabled venc if venc_dump_regs() gets called.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/video/omap2/dss/venc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index b3e9f90..82865be 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -699,6 +699,11 @@ void venc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, venc_read_reg(r))
 
+	if (cpu_is_omap44xx()) {
+		seq_printf(s, "VENC currently disabled on OMAP44xx\n");
+		return;
+	}
+
 	if (venc_runtime_get())
 		return;
 
-- 
1.7.7.3

