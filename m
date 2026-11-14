Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679469;
	b=MznQeTole68OEh146aopYl1OU+nZ4fGNPIKnno9Am4YZIFTZWRzfvf4n0mvXIAwPqvMT
	 g0eECiGV0RY6x80PiDSuVlfhFHinTrPleOacNgcuYpchWnahDVXmxKYRgwLuc5snAdpBW
	 B8LKX89AC7XLhYT4QgaG+1+HeLRyoG93mrBSgAlJg7zbHHotrOSvQjbCqcTHSdLj+vEMD
	 gZMo/4SyA6nmz3A3AoguuPZKWLITdNOmVqpm0oofI3zhfuzS5sZT3EGo15hWIyCBFBvY3
	 8xuxrIjEiCkBquM7TWFx6OQjew4agjWM1EOVam5vLgox01TbmPJ0ca1h1nTKuH/1pHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679469;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=+gmtjGwMCIrmtgYaT1KuXhD6CFKfhDTaa1rfMzOjnrE=;
	b=Qvwdu9NAwsJbzVNlXkWc51mMlgULoLRt/mr8GpAlmbiL4wyG1c5vF1VAb7BDaQ6AEF4X
	 ZDAWJBtn8h0eDcSZ1ZiBZcMPvutLxkCK6iASh6e8sucQSrp1OB7Hd+q7I4+TINwy4pxrC
	 n+sa/0mJk9XfHfKn2sfPxGp4CkNeMqOWijYouN40WZY+V3IzcLg+a6+634YrPELaLyX/H
	 YX58VFZKXecGm0HfGfQZofE/dvdCKPtsLGF4bZdcvsqRxmiKJvoCnOJvjWea8sNPfaal0
	 GTGVKToq7uEpoBSZb+OddToj9ybY52xgfp7QHR70WwXWfQgLEvb1dLUQ4QwhXco1qKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="iQJ/iJSm";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3160A2608;
	Sat, 14 Nov 2026 18:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F3160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iQJ/iJSm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679465;
	bh=VTBut2vqwoV3MoKcvT6GQaYP+gKhRzrB6Xtx7U7fro0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQJ/iJSmG9cixrksVRQyNvAyW6ekGou7nyTC0wIj85ZtXgA3ViCxieaf8U8iLgxTT
	 eC1bYwLEUFL/A5QWn6UfJZY9hJ1Djs73vPKvJHUN5basavBmx3Z35x2rv0kyI/D4+E
	 MYTrTS8d4MZIVRfxgd6dsilPGAljL1hFgLzLrFvJwj7KzecE0mJxYVj2A+a1AsS4UZ
	 KBHUvrqhFCnGmV1eeRrCxTpWfFD3g9ZNEmv1xFvhNFAOz1X9RZXipU5a9oGzE3BfCN
	 KNP0Nu3tvCwGyWmbeoHGct5p5a/Jzd7pB5q0oKUju+htNs/QArDhIaN+i7OIvqBBLI
	 PgyXWa1guOD7w==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7CCD817E37E7;
	Sat, 14 Nov 2026 19:04:25 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:35 +0200
Subject: [PATCH 11/25] drm/connector: Use the SPD InfoFrame field length
 defines
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-11-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Robin_R=C3=A4ber?= <robin.raebi@gmail.com>, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2

DRM_CONNECTOR_HDMI_{VENDOR,PRODUCT}_LEN used to size the vendor and
product arrays in struct drm_connector_hdmi.  Those arrays are gone and
both names are now only validated before being copied into the SPD
InfoFrame, hence the limits they have to be checked against are the ones
of the SPD InfoFrame fields themselves.

Switch the remaining users over to
HDMI_SPD_INFOFRAME_{VENDOR,PRODUCT}_LEN and drop the DRM specific
defines, so that the two cannot drift apart.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Robin Räber <robin.raebi@gmail.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588 Orange Pi 5 Plus, dual HDMI
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c            |  4 ++--
 drivers/gpu/drm/tests/drm_connector_test.c | 13 +++++++------
 include/drm/drm_connector.h                |  8 ++++----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 95dd4012580c..355ba53cab6b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -579,8 +579,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (!hdmi_funcs->vendor || !hdmi_funcs->product)
 		return -EINVAL;
 
-	if ((strlen(hdmi_funcs->vendor) > DRM_CONNECTOR_HDMI_VENDOR_LEN) ||
-	    (strlen(hdmi_funcs->product) > DRM_CONNECTOR_HDMI_PRODUCT_LEN))
+	if ((strlen(hdmi_funcs->vendor) > HDMI_SPD_INFOFRAME_VENDOR_LEN) ||
+	    (strlen(hdmi_funcs->product) > HDMI_SPD_INFOFRAME_PRODUCT_LEN))
 		return -EINVAL;
 
 	if (!hdmi_funcs->supported_formats ||
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index d98c6a42ccae..591557c4a8bb 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -771,7 +771,7 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 	priv->hdmi_funcs.product = "Prod";
 
 	KUNIT_ASSERT_LT(test, strlen(priv->hdmi_funcs.product),
-			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+			HDMI_SPD_INFOFRAME_PRODUCT_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -794,7 +794,7 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 	priv->hdmi_funcs.product = "ProductProductPr";
 
 	KUNIT_ASSERT_EQ(test, strlen(priv->hdmi_funcs.product),
-			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+			HDMI_SPD_INFOFRAME_PRODUCT_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -817,7 +817,7 @@ static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *t
 	priv->hdmi_funcs.product = "ProductProductProduct";
 
 	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.product),
-			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+			HDMI_SPD_INFOFRAME_PRODUCT_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -840,7 +840,7 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 	priv->hdmi_funcs.vendor = "Vend";
 
 	KUNIT_ASSERT_LT(test, strlen(priv->hdmi_funcs.vendor),
-			DRM_CONNECTOR_HDMI_VENDOR_LEN);
+			HDMI_SPD_INFOFRAME_VENDOR_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -863,7 +863,7 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 	priv->hdmi_funcs.vendor = "VendorVe";
 
 	KUNIT_ASSERT_EQ(test, strlen(priv->hdmi_funcs.vendor),
-			DRM_CONNECTOR_HDMI_VENDOR_LEN);
+			HDMI_SPD_INFOFRAME_VENDOR_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -884,7 +884,8 @@ static void drm_test_connector_hdmi_init_vendor_length_too_long(struct kunit *te
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
 	priv->hdmi_funcs.vendor = "VendorVendor";
-	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.vendor), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.vendor),
+			HDMI_SPD_INFOFRAME_VENDOR_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 262bc4d91a3c..2d9ae3a99329 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1485,15 +1485,15 @@ struct drm_connector_infoframe_funcs {
  * and controller capabilities
  */
 struct drm_connector_hdmi_funcs {
-#define DRM_CONNECTOR_HDMI_VENDOR_LEN	8
 	/**
-	 * @vendor: HDMI Controller Vendor name.
+	 * @vendor: HDMI Controller Vendor name, at most
+	 * HDMI_SPD_INFOFRAME_VENDOR_LEN characters long.
 	 */
 	const char *vendor;
 
-#define DRM_CONNECTOR_HDMI_PRODUCT_LEN	16
 	/**
-	 * @product: HDMI Controller Product name
+	 * @product: HDMI Controller Product name, at most
+	 * HDMI_SPD_INFOFRAME_PRODUCT_LEN characters long.
 	 */
 	const char *product;
 

-- 
2.56.0

