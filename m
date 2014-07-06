From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 19:01:20 +0000
Subject: [PATCH] video: fbdev: uvesafb.c:  Cleaning up variable that is never used
Message-Id: <1404673280-20585-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404564682-21983-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404564682-21983-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Wang YanQing <udknight@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/uvesafb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 509d452..50086b9 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -555,12 +555,12 @@ static int uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
 static int uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
 			      struct uvesafb_par *par)
 {
-	int i, err;
+	int i;
 
 	uvesafb_reset(task);
 	task->t.regs.eax = 0x4f0a;
 	task->t.regs.ebx = 0x0;
-	err = uvesafb_exec(task);
+	uvesafb_exec(task);
 
 	if ((task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
 		par->pmi_setpal = par->ypan = 0;
-- 
1.7.10.4

