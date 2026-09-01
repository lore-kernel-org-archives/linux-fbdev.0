Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71414A99DF;
	Tue,  1 Sep 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288700; cv=none; b=oH9ujC21lDJB7LLCZajqmhc2tbTjuy5kqnhCPdMTJNvQNjM7Q5BJbBWVKskSp6vpWVGfl6jD69Yws/bQGU4Rw4gR98s94soFSlSaUNQkR/H1ZYyhava5WWAu/HOO2/Mbu3W8VUCh4sec+FQs6Or1XHMwXKEFOSPUDgk4l4xj7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288700; c=relaxed/simple;
	bh=oTnYR6YHaalFFMtLK/1IlAYPejOGFOtQvt5j73EJZXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CwnSf50Dv1r6dmgCm4aeKE15z9F14Ml+OkR3V0XztCLcV2f4FNKUXeGkBXjAuohgwgim7aVuuePxzpBVcOKGA3okPkG6ZXrD54bVF3CzlDt1ktvN3TKki1hEDiTiFeUCO+RKjsKFfl99vJu1noyqiSpx1MXV0cECYVRatoNx6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CfLKEVYC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CfLKEVYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288692;
	bh=oTnYR6YHaalFFMtLK/1IlAYPejOGFOtQvt5j73EJZXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CfLKEVYC39mRDIjkQ9RVyAzrZI69QbSPJWy2Mk5LfAe6KDfNFn2TBLhBhWgGThh0E
	 MdFzskD2X9Dvhu6VSFQEKIlMoLOGV9G4IYxLl/ag4WXSHzVG3BGleuuVP+FEzv50q0
	 uzx9/nXUZv8i0+i+uE1T+HzrOMn+ZXG6jn5EVAZjpQFJE9jyinde+ht5/SLQinVQUS
	 2C3r/R3vSdFb/B7DwLRwnHGMbTNXoDJqFK4GKVKRmkgBGNQXMx7PzYYiovE7Ta/iI9
	 7NgKkPorZm2QyTJBrmZvvsOGQ8H9G64ZeLj2CsOZVeAqtg+B9s5JZ0QWxATAri9BLz
	 mmPvBVoT8jQzw==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D639617E3C9F;
	Tue, 01 Sep 2026 20:51:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:33 +0300
Subject: [PATCH v11 69/74] drm/connector: Drop redundant hdmi
 vendor/product fields
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-69-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>
X-Mailer: b4 0.15.2

Now that all users migrated to the new drmm_connector_hdmi_init()
signature, vendor and product are provided through struct
drm_connector_hdmi_funcs, a reference to which is already stored in
drm_connector_hdmi.

Drop the redundant fields from drm_connector_hdmi and point its users to
hdmi.funcs->vendor and hdmi.funcs->product instead.

The connector registration tests used to verify that both names were
stored zero-padded and without any trailing NUL, as the SPD InfoFrame
requires.  That will be covered by dedicated SPD InfoFrame tests, hence
drop the KUNIT_EXPECT_MEMEQ() checks on the removed fields.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +--
 drivers/gpu/drm/drm_connector.c                 |  4 ---
 drivers/gpu/drm/tests/drm_connector_test.c      | 41 +++----------------------
 include/drm/drm_connector.h                     | 14 ++-------
 4 files changed, 8 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index d661385c3e64..289dce6c6281 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -786,8 +786,8 @@ static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
 		return 0;
 
 	ret = hdmi_spd_infoframe_init(frame,
-				      connector->hdmi.vendor,
-				      connector->hdmi.product);
+				      connector->hdmi.funcs->vendor,
+				      connector->hdmi.funcs->product);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index c9540d58719a..4d580aaec247 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -646,10 +646,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 		connector->hdmi.max_tmds_char_rate = hdmi_funcs->supported_tmds_char_rate;
 	}
 
-	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
-	strtomem_pad(connector->hdmi.vendor, hdmi_funcs->vendor, 0);
-	strtomem_pad(connector->hdmi.product, hdmi_funcs->product, 0);
-
 	/*
 	 * drm_connector_attach_max_bpc_property() requires the
 	 * connector to have a state.
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 0613568ef5b7..be2d24abeeb8 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -771,14 +771,11 @@ static void drm_test_connector_hdmi_init_null_product(struct kunit *test)
 
 /*
  * Test that the registration of a connector with a valid, shorter than
- * the max length, product name succeeds, and is stored padded with 0.
+ * the max length, product name succeeds.
  */
 static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] = {
-		'P', 'r', 'o', 'd',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -793,25 +790,15 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.product,
-			   expected_product,
-			   sizeof(priv->connector.hdmi.product));
 }
 
 /*
  * Test that the registration of a connector with a valid, at max
- * length, product name succeeds, and is stored padded without any
- * trailing \0.
+ * length, product name succeeds.
  */
 static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] = {
-		'P', 'r', 'o', 'd', 'u', 'c', 't',
-		'P', 'r', 'o', 'd', 'u', 'c', 't',
-		'P', 'r',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -826,10 +813,6 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.product,
-			   expected_product,
-			   sizeof(priv->connector.hdmi.product));
 }
 
 /*
@@ -857,14 +840,11 @@ static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *t
 
 /*
  * Test that the registration of a connector with a vendor name smaller
- * than the maximum length succeeds, and is stored padded with zeros.
+ * than the maximum length succeeds.
  */
 static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
-		'V', 'e', 'n', 'd',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -879,24 +859,15 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.vendor,
-			   expected_vendor,
-			   sizeof(priv->connector.hdmi.vendor));
 }
 
 /*
  * Test that the registration of a connector with a vendor name at the
- * maximum length succeeds, and is stored padded without the trailing
- * zero.
+ * maximum length succeeds.
  */
 static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
-		'V', 'e', 'n', 'd', 'o', 'r',
-		'V', 'e',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -911,10 +882,6 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.vendor,
-			   expected_vendor,
-			   sizeof(priv->connector.hdmi.vendor));
 }
 
 /*
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index d62a79b9699a..182946279194 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1485,11 +1485,13 @@ struct drm_connector_infoframe_funcs {
  * and controller capabilities
  */
 struct drm_connector_hdmi_funcs {
+#define DRM_CONNECTOR_HDMI_VENDOR_LEN	8
 	/**
 	 * @vendor: HDMI Controller Vendor name.
 	 */
 	const char *vendor;
 
+#define DRM_CONNECTOR_HDMI_PRODUCT_LEN	16
 	/**
 	 * @product: HDMI Controller Product name
 	 */
@@ -2190,18 +2192,6 @@ struct drm_connector_hdmi_audio {
  * struct drm_connector_hdmi - DRM Connector HDMI-related structure
  */
 struct drm_connector_hdmi {
-#define DRM_CONNECTOR_HDMI_VENDOR_LEN	8
-	/**
-	 * @vendor: HDMI Controller Vendor Name
-	 */
-	unsigned char vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] __nonstring;
-
-#define DRM_CONNECTOR_HDMI_PRODUCT_LEN	16
-	/**
-	 * @product: HDMI Controller Product Name
-	 */
-	unsigned char product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] __nonstring;
-
 	/**
 	 * @supported_formats: Bitmask of @drm_output_color_format
 	 * supported by the controller.

-- 
2.55.0

