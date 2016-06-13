From: Max Staudt <mstaudt@suse.de>
Date: Mon, 13 Jun 2016 17:15:59 +0000
Subject: [PATCH RESEND] fbdev/efifb: Fix 16 color palette entry calculation
Message-Id: <1465838159-12940-1-git-send-email-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
In-Reply-To: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: pjones@redhat.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: mstaudt@suse.de, eich@suse.de, tiwai@suse.de, agraf@suse.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk, stable@vger.kernel.org

When using efifb with a 16-bit (5:6:5) visual, fbcon's text is rendered
in the wrong colors - e.g. text gray (#aaaaaa) is rendered as green
(#50bc50) and neighboring pixels have slightly different values
(such as #50bc78).

The reason is that fbcon loads its 16 color palette through
efifb_setcolreg(), which in turn calculates a 32-bit value to write
into memory for each palette index.
Until now, this code could only handle 8-bit visuals and didn't mask
overlapping values when ORing them.

With this patch, fbcon displays the correct colors when a qemu VM is
booted in 16-bit mode (in GRUB: "set gfxpayload=800x600x16").

Fixes: 7c83172b98e5 ("x86_64 EFI boot support: EFI frame buffer driver")  #=
 v2.6.24+
Signed-off-by: Max Staudt <mstaudt@suse.de>
Acked-By: Peter Jones <pjones@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/video/fbdev/efifb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 924bad4..37a37c4 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -50,9 +50,9 @@ static int efifb_setcolreg(unsigned regno, unsigned red, =
unsigned green,
 		return 1;
=20
 	if (regno < 16) {
-		red   >>=3D 8;
-		green >>=3D 8;
-		blue  >>=3D 8;
+		red   >>=3D 16 - info->var.red.length;
+		green >>=3D 16 - info->var.green.length;
+		blue  >>=3D 16 - info->var.blue.length;
 		((u32 *)(info->pseudo_palette))[regno]  			(red   << info->var.red.offse=
t)   |
 			(green << info->var.green.offset) |
--=20
2.6.6

