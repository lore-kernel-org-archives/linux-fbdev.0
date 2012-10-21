From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sun, 21 Oct 2012 12:54:26 +0000
Subject: [PATCH] OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs()
Message-Id: <CAPgLHd--5Y4cq3ieoRSueg-i0boqRa4JqRPL7+cJ0UfesunjoQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock on the error handling path in function
hdmi_dump_regs().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
no test
---
 drivers/video/omap2/dss/hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a48a7dd..8c9b8b3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -644,8 +644,10 @@ static void hdmi_dump_regs(struct seq_file *s)
 {
 	mutex_lock(&hdmi.lock);
 
-	if (hdmi_runtime_get())
+	if (hdmi_runtime_get()) {
+		mutex_unlock(&hdmi.lock);
 		return;
+	}
 
 	hdmi.ip_data.ops->dump_wrapper(&hdmi.ip_data, s);
 	hdmi.ip_data.ops->dump_pll(&hdmi.ip_data, s);


