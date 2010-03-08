From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Date: Mon, 08 Mar 2010 23:33:06 +0000
Subject: [PATCH] s3c2410fb: silence warning
Message-Id: <876356o0ct.fsf@lechat.rtp-net.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org

--=-=-=



When building s3c2410fb with CPU_FREQ set, one gets :

drivers/video/s3c2410fb.c: In function 's3c2410fb_cpufreq_transition':
drivers/video/s3c2410fb.c:769: warning: unused variable 'freqs'

Remove this useless declaration to silence the warning.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=fix_fb_warning.patch

---
 drivers/video/s3c2410fb.c |    1 	0 +	1 -	0 !
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.orig/drivers/video/s3c2410fb.c	2010-03-09 00:22:08.317640239 +0100
+++ linux-2.6/drivers/video/s3c2410fb.c	2010-03-09 00:22:33.117640575 +0100
@@ -766,7 +766,6 @@ static irqreturn_t s3c2410fb_irq(int irq
 static int s3c2410fb_cpufreq_transition(struct notifier_block *nb,
 					unsigned long val, void *data)
 {
-	struct cpufreq_freqs *freqs = data;
 	struct s3c2410fb_info *info;
 	struct fb_info *fbinfo;
 	long delta_f;

--=-=-=--
