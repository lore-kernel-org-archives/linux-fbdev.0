From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:51:22 +0000
Subject: [PATCH] video: fbdev: uvesafb.c:  Cleaning up variable that is never used
Message-Id: <1404564682-21983-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Wang YanQing <udknight@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>, Sachin Kamat <sachin.kamat@linaro.org>, David Fries <David@Fries.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

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

