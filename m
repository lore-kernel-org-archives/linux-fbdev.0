From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Date: Wed, 05 May 2010 14:27:41 +0000
Subject: [PATCH v3 21/21] OMAP: DSS2: Taal: CABC workaround is Taal specific
Message-Id: <04807eb255f204f61884b06cde6819e0a087ea33.1273067195.git.ext-jani.1.nikula@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
 <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
 <adb61d94ee2a25284f6bd3f55ec4213501cbe8e3.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4cb510ffbc3216e2a7dac16edaff5fb1980b3315.1273067195.git.ext-jani.1.nikula@nokia.com>
 <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
 <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <ca7ff2e5a165ca8488190520f1f75e6e37642d3b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4f2a95d67d2b8004f4a2055681690920ebeb8e8f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <690ef5c45aee3fb87a40fa03039356f8238925dc.1273067195.git.ext-jani.1.nikula@nokia.com>
 <025c12267d4bd88e1f59d9e13aafec247fe3c730.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e149b5cf7d3dbed1961e06dc82291412e3223101.1273067195.git.ext-jani.1.nikula@nokia.com>
 <5e7384699d72bad3865dc9604b18ad05775bfb27.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1b93af2daf403f2fe822469b71c12ea7eb1cc68a.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <1b93af2daf403f2fe822469b71c12ea7eb1cc68a.1273067195.git.ext-jani.1.nikula@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Prepare for supporting panels other than Taal in this driver.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 617723b..981e38d 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -856,8 +856,9 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	/* on early revisions CABC is broken */
-	if (id2 = 0x00 || id2 = 0xff || id2 = 0x81)
+	/* on early Taal revisions CABC is broken */
+	if (td->panel_config->type = PANEL_TAAL &&
+		(id2 = 0x00 || id2 = 0xff || id2 = 0x81))
 		td->cabc_broken = true;
 
 	r = taal_dcs_write_1(DCS_BRIGHTNESS, 0xff);
-- 
1.6.5.2

