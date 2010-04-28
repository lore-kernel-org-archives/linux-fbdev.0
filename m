From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Wed, 28 Apr 2010 10:25:02 +0000
Subject: [PATCH 1/4] cocbalt_lcdfb: correct sections
Message-Id: <1272450305-7284-1-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: ralf@linux-mips.org, arnaud.patard@rtp-net.org, jayakumar.lkml@gmail.com, gregkh@suse.de, yuasa@linux-mips.org, lethal@linux-sh.org, akpm@linux-foundation.org, adobriyan@gmail.com, support@simtec.co.uk, ben@simtec.co.uk, linux@simtec.co.uk, jkosina@suse.cz, pjones@redhat.com, linux-kernel@vger.kernel.org, Henrik Kretzschmar <henne@nachtwindheim.de>

Since the drivers probe call was changed from .init.text
to .devinit.text in commit c2e13037e6794bd0d9de3f9ecabf5615f15c160b
the fb_fix_screeninfo structure must be
changed from .init.data to .devinit.data, too.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
It would be nice if someone with a MIPS gcc could test this patch and
give me some feedback if it works the way it should, since atm I'm lacking
a crosscompiler setup.
---
 drivers/video/cobalt_lcdfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index 5eb61b5..42fe155 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -123,7 +123,7 @@ static void lcd_clear(struct fb_info *info)
 	lcd_write_control(info, LCD_RESET);
 }
 
-static struct fb_fix_screeninfo cobalt_lcdfb_fix __initdata = {
+static struct fb_fix_screeninfo cobalt_lcdfb_fix __devinitdata = {
 	.id		= "cobalt-lcd",
 	.type		= FB_TYPE_TEXT,
 	.type_aux	= FB_AUX_TEXT_MDA,
-- 
1.7.0

