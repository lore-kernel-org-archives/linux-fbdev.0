From: jaswinder.singh@linaro.org
Date: Sat, 23 Jun 2012 08:19:02 +0000
Subject: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Message-Id: <1340438822-25657-1-git-send-email-jaswinder.singh@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
In-Reply-To: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, Jassi Brar <jaswinder.singh@linaro.org>

From: Jassi Brar <jaswinder.singh@linaro.org>

It is simpler to read the current status from a register as compared
to maintaining a state variable to hold the information.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    1 -
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index e734cb4..d174ca1 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -177,7 +177,6 @@ struct hdmi_ip_data {
 
 	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct */
 	int hpd_gpio;
-	bool phy_tx_enabled;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 4dae1b2..3fa3d98 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -157,6 +157,10 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip_data)
 /* PHY_PWR_CMD */
 static int hdmi_set_phy_pwr(struct hdmi_ip_data *ip_data, enum hdmi_phy_pwr val)
 {
+	/* Return if already the state */
+	if (REG_GET(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, 5, 4) = val)
+		return 0;
+
 	/* Command for power control of HDMI PHY */
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, val, 7, 6);
 
@@ -241,11 +245,6 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 
 	hpd = gpio_get_value(ip_data->hpd_gpio);
 
-	if (hpd = ip_data->phy_tx_enabled) {
-		spin_unlock_irqrestore(&phy_tx_lock, flags);
-		return 0;
-	}
-
 	if (hpd)
 		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
 	else
@@ -257,7 +256,6 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 		goto err;
 	}
 
-	ip_data->phy_tx_enabled = hpd;
 err:
 	spin_unlock_irqrestore(&phy_tx_lock, flags);
 	return r;
@@ -327,7 +325,6 @@ void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
 	free_irq(gpio_to_irq(ip_data->hpd_gpio), ip_data);
 
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
-	ip_data->phy_tx_enabled = false;
 }
 
 static int hdmi_core_ddc_init(struct hdmi_ip_data *ip_data)
-- 
1.7.4.1

