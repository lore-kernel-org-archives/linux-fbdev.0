From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 17:36:30 +0000
Subject: [PATCH] video: fbdev: sis: sis_main.c:  Cleaning up wrong type in format string
Message-Id: <1404668190-15199-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404566317-22987-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404566317-22987-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Wrong type in printf format string, requires 'unsigned int'
but the argument type is 'int'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/sis/sis_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 22ad028..ab7e5e4 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -237,7 +237,7 @@ static void sisfb_get_vga_mode_from_kernel(void)
 
 		if(mydepth = 24) mydepth = 32;
 
-		sprintf(mymode, "%ux%ux%u", screen_info.lfb_width,
+		sprintf(mymode, "%ux%ux%d", screen_info.lfb_width,
 					screen_info.lfb_height,
 					mydepth);
 
-- 
1.7.10.4

