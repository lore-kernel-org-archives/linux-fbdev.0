From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Wed, 23 Jul 2014 21:20:27 +0000
Subject: [PATCH v2] video: fbdev: uvesafb.c:  Added additional error checking
Message-Id: <1406150427-26077-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Wang YanQing <udknight@gmail.com>, Jingoo Han <jg1.han@samsung.com>, David Fries <David@Fries.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable was assigned a value that is never used.
Now the variable is used, and the function returns if a call to
uvesafb_exec() returns a error.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/uvesafb.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 509d452..47c2d74 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -561,6 +561,8 @@ static int uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
 	task->t.regs.eax = 0x4f0a;
 	task->t.regs.ebx = 0x0;
 	err = uvesafb_exec(task);
+	if (err)
+		return err;
 
 	if ((task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
 		par->pmi_setpal = par->ypan = 0;
-- 
1.7.10.4

