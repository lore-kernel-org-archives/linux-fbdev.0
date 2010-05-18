From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 18 May 2010 12:35:11 +0000
Subject: [PATCH 20/23] OMAP2: DSS: Add missing line for update bg color
Message-Id: <1274186114-26951-21-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Carlos Lopez <carlos.cruz@sasken.com>

The driver set the background color canvas but never writes it in
DISPC_DEFAULT_COLOR_m register, which changes the background color
on the LCD or TV.

This patch adds a line to call to dispc_set_default_color() which is
the function in charge to write the DISPC_DEFAULT_COLOR_m register.

Signed-off-by: Carlos Lopez <carlos.cruz@sasken.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/manager.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 32ec2ff..9e1fbe5 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -843,6 +843,7 @@ static void configure_manager(enum omap_channel channel)
 
 	c = &dss_cache.manager_cache[channel];
 
+	dispc_set_default_color(channel, c->default_color);
 	dispc_set_trans_key(channel, c->trans_key_type, c->trans_key);
 	dispc_enable_trans_key(channel, c->trans_enabled);
 	dispc_enable_alpha_blending(channel, c->alpha_enabled);
-- 
1.7.0.4

