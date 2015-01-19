From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 19 Jan 2015 08:23:03 +0000
Subject: [PATCH v2 4/7] staging: sm7xxfb: add missing blank line
Message-Id: <1421655067-7490-4-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

checkpatch cleanup to add missing blank line after declaration

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index c550b71..6bce9f1 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -259,6 +259,7 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 		if (regno < 16) {
 			if (sfb->fb.var.bits_per_pixel = 16) {
 				u32 *pal = sfb->fb.pseudo_palette;
+
 				val = chan_to_field(red, &sfb->fb.var.red);
 				val |= chan_to_field(green, &sfb->fb.var.green);
 				val |= chan_to_field(blue, &sfb->fb.var.blue);
@@ -273,6 +274,7 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 #endif
 			} else {
 				u32 *pal = sfb->fb.pseudo_palette;
+
 				val = chan_to_field(red, &sfb->fb.var.red);
 				val |= chan_to_field(green, &sfb->fb.var.green);
 				val |= chan_to_field(blue, &sfb->fb.var.blue);
-- 
1.8.1.2

