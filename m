From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Date: Wed, 05 May 2010 14:27:24 +0000
Subject: [PATCH v3 04/21] OMAP: DSS2: Taal: Cosmetic improvement to backlight properties initialization
Message-Id: <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Let the compiler worry about the type for us.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 0eed328..53fc369 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -559,7 +559,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	/* if no platform set_backlight() defined, presume DSI backlight
 	 * control */
-	memset(&props, 0, sizeof(struct backlight_properties));
+	memset(&props, 0, sizeof(props));
 	if (!dssdev->set_backlight)
 		td->use_dsi_bl = true;
 
-- 
1.6.5.2

