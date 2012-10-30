From: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Tue, 30 Oct 2012 18:15:40 +0000
Subject: [PATCH] da8xx: De-constify members in the platform config.
Message-Id: <1351698989-4049-1-git-send-email-panto@antoniou-consulting.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org

There's no need for this to be const. It interferes with
creating the platform data dynamically.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 include/video/da8xx-fb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index 5a0e4f9..a512d6b 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -35,9 +35,9 @@ struct display_panel {
 };
 
 struct da8xx_lcdc_platform_data {
-	const char manu_name[10];
+	char manu_name[10];
 	void *controller_data;
-	const char type[25];
+	char type[25];
 	void (*panel_power_ctrl)(int);
 };
 
-- 
1.7.12

