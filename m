From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Nov 2011 20:53:55 +0000
Subject: [PATCH 4/8] fbdev/amifb: Make amifb_setup() static
Message-Id: <1321908839-11419-4-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index d7961bd..d3847e7 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2363,7 +2363,7 @@ static void __init amifb_setup_mcap(char *spec)
 	fb_info.monspecs.hfmax = hmax;
 }
 
-int __init amifb_setup(char *options)
+static int __init amifb_setup(char *options)
 {
 	char *this_opt;
 
-- 
1.7.0.4

