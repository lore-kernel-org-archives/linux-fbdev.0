From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Tue, 20 May 2014 21:37:32 +0000
Subject: [PATCH] video: fbdev: s3fb.c:  Fix for possible null pointer dereference
Message-Id: <1400621852-7886-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

There is otherwise a risk of a possible null pointer dereference.

Was largely found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/s3fb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 9a3f8f1..c43b969 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1401,9 +1401,10 @@ err_enable_device:
 static void s3_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	struct s3fb_info __maybe_unused *par = info->par;
+	struct s3fb_info __maybe_unused *par;
 
 	if (info) {
+		par = info->par;
 
 #ifdef CONFIG_MTRR
 		if (par->mtrr_reg >= 0) {
-- 
1.7.10.4

