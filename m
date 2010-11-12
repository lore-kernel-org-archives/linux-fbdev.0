From: Samreen <samreen@ti.com>
Date: Fri, 12 Nov 2010 11:59:15 +0000
Subject: [PATCH] OMAP: DSS2: OMAPFB: Fix null pointer check
Message-Id: <1289562435-8056-1-git-send-email-samreen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTik2WToLpQCK7zM+4xwwnbxY_PbRnZF-H40iYhuW@mail.gmail.com>
In-Reply-To: <AANLkTik2WToLpQCK7zM+4xwwnbxY_PbRnZF-H40iYhuW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>

A null pointer check added.

Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 6a704f1..55bed89 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2133,6 +2133,8 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 	int r = 0;
 
 	str = kmalloc(strlen(def_mode) + 1, GFP_KERNEL);
+	if (str = NULL)
+		return -EINVAL;
 	strcpy(str, def_mode);
 	options = str;
 
-- 
1.5.6.3

