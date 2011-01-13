From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Date: Thu, 13 Jan 2011 12:42:16 +0000
Subject: [PATCH] OMAP: DSS2: Fix def_disp module param description
Message-Id: <1294922536-23852-1-git-send-email-ext-jani.1.nikula@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

MODULE_PARM_DESC() takes the name of the actual module parameter, not the
name of the variable, as input. Fix the module parameter description for
def_disp.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/dss/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8e89f60..cad73b1 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -62,7 +62,7 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks);
 
 static char *def_disp_name;
 module_param_named(def_disp, def_disp_name, charp, 0);
-MODULE_PARM_DESC(def_disp_name, "default display name");
+MODULE_PARM_DESC(def_disp, "default display name");
 
 #ifdef DEBUG
 unsigned int dss_debug;
-- 
1.7.3.2

