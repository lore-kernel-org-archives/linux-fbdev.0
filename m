From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 08 Jan 2010 13:22:46 +0000
Subject: [PATCH 12/15] OMAP: DSS2: OMAPFB: fix omapfb_free_fbmem()
Message-Id: <1262956969-1664-13-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-11-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-12-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1262956969-1664-12-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Fixes bug causing VRFB memory area to be released twice.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Reported-by: Eino-Ville Talvala <talvala@stanford.edu>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index ef29983..e61a75c 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1311,6 +1311,7 @@ static void omapfb_free_fbmem(struct fb_info *fbi)
 		if (rg->vrfb.vaddr[0]) {
 			iounmap(rg->vrfb.vaddr[0]);
 			omap_vrfb_release_ctx(&rg->vrfb);
+			rg->vrfb.vaddr[0] = NULL;
 		}
 	}
 
-- 
1.6.5

