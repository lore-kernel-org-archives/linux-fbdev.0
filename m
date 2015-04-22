From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 22 Apr 2015 23:14:37 +0000
Subject: [PATCH v3 1/3] phy: phy-core: allow specifying supply at port level
Message-Id: <1429744479-10410-2-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429744479-10410-1-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1429744479-10410-1-git-send-email-arun.ramamurthy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Dmitry Torokhov <dtor@chromium.org>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>

From: Dmitry Torokhov <dtor@chromium.org>

Multi-port phys may have per port power supplies. Let's change phy
core to look for supply at the port level when multiple ports are
specified. To keep compatibility with the existing device tree board
descriptions for single-port phys we will continue looking up the
power supply at the parent node level

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/phy/phy-core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 3791838..c7aa297 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -651,16 +651,6 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 		goto free_phy;
 	}
 
-	/* phy-supply */
-	phy->pwr = regulator_get_optional(dev, "phy");
-	if (IS_ERR(phy->pwr)) {
-		if (PTR_ERR(phy->pwr) = -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto free_ida;
-		}
-		phy->pwr = NULL;
-	}
-
 	device_initialize(&phy->dev);
 	mutex_init(&phy->mutex);
 
@@ -674,6 +664,16 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	if (ret)
 		goto put_dev;
 
+	/* phy-supply */
+	phy->pwr = regulator_get_optional(&phy->dev, "phy");
+	if (IS_ERR(phy->pwr)) {
+		ret = PTR_ERR(phy->pwr);
+		if (ret = -EPROBE_DEFER)
+			goto put_dev;
+
+		phy->pwr = NULL;
+	}
+
 	ret = device_add(&phy->dev);
 	if (ret)
 		goto put_dev;
@@ -689,9 +689,6 @@ put_dev:
 	put_device(&phy->dev);  /* calls phy_release() which frees resources */
 	return ERR_PTR(ret);
 
-free_ida:
-	ida_simple_remove(&phy_ida, phy->id);
-
 free_phy:
 	kfree(phy);
 	return ERR_PTR(ret);
-- 
2.3.4

