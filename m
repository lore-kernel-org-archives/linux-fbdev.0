From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Dec 2009 13:15:09 +0000
Subject: [PATCH] Revert "fbdev: atafb - add palette register check"
Message-Id: <alpine.DEB.2.00.0912171413560.17197@ayla.of.borg>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This reverts commit 8546e3ce6e37c359979b69862442f94e0ef0e03b, as it's a
partial duplicate of commit 2f390380ca69e1617cdddb12d8da94f0a9f4319d ("fbdev:
add palette register check to several drivers").
The former went in first through the m68k tree, the latter through Andrew
Morton.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/atafb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 2051c9d..b7687c5 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -2245,9 +2245,6 @@ static int ext_setcolreg(unsigned int regno, unsigned int red,
 	if (regno > 255)
 		return 1;
 
-	if (regno > 255)
-		return 1;
-
 	switch (external_card_type) {
 	case IS_VGA:
 		OUTB(0x3c8, regno);
-- 
1.6.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
