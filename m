Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679474;
	b=wXcgIZf+GsXoiOh0GUNwRMKn5VItxKKzg0hT9COYCCwTAQczYPXc3OSgV94oagD2ZUch
	 hP8l47fQNhcAL6DD/UDZiVks7nMNyWX0WuLDO1Z1HHQnW82FOTcpwot3UjWc0ObomFnvR
	 9PzYGsKJG//3UltkfrYCc3CPa2ZjHPUOewSuZxEr1WnOQgMXUsFmebx++TILoWZQqt7FA
	 y8WtF+xyoD6ONCMYY1FBkHbbLz0sWq4htmFokGHjjP+Vhwyxttfj8Mrw5oBlEDzEQ2JIr
	 m3v8pij6UwSoTIrXpL0rbj9/gm/pYWsH8RfquNQdMBWzMrNIqBDeAPS53GaI2vxSICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679474;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=IyzjBZVnm+BVjQiOlWLrmXSFH8pVyNPp4HovYqOum/U=;
	b=DOdWAs7LjxDjiqRHwY7ZbwPeqLSCdHB48evcnFLkVqLV7C2thLMC35P797u5pm++w0Su
	 8iOHbn56lBG3KjbdlrlvlTl+RBBJwoqT7eI92mCU8ZwyBZaSjMuw3wN3kwSyy2vYXbgbU
	 Wkb9wviTIN/t4g9GB00OQQVvNwHFXbUYq+Ngfpx1r6FYEBjMNgyvNc3Itpz744FVNpUZc
	 X3Qsksh6MPlv/UyTQ2kJllKDnRru0djdDBwEurYPFZst9lcFDYGi/gQMFbzllmJmRZFC1
	 uDCMi9+GD9gQ9cxk9nku+lBL8Gu+jt8d+wCjBN1KmucGXRnPFwsOMOcpQSc23tP5DJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=d6BWzGxy;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DF60A6F69;
	Sat, 14 Nov 2026 18:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C25DF60A6F69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=d6BWzGxy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679472;
	bh=27/R3zwTOahXNB477OaTEOZ6QcZZkQ5UURFGh0TKeDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d6BWzGxyZU6nqkdYOp001+yt/vzPdbIxB5yHTuV3ZKs91qXe0TiF6m2BT3lX3JpfJ
	 UfubobQ8nEn+9zE4W1fxD6mKbO2Sf/tYSQhK5CpqouafXTkOlKBpPM6G9zAtxOhrRn
	 GinW8ofE/mQ0aFakwiHklhtW0ySwquOgPYimMdEV7BlnVUNSWANmRLnBtsk633ijsG
	 8XjqhRCdOuXbnpE4VO4sX/qu0rdvMPDEuK2wZ3ftI6v6WkWVWFeGJc+3cnjp66p7l6
	 mnSR0tRqdSm9i4xvzXc1EusKsu3uE7Ssde3R/K8Xu0tgDLeZ8/rlNz3GzucP2ocKLI
	 hE6lHW5PEnuxw==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 42E2D17E3BF6;
	Sat, 14 Nov 2026 19:04:32 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:44 +0200
Subject: [PATCH 20/25] drm/tests: hdmi: Add SPD InfoFrame vendor/product
 coverage
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-20-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

The vendor and product strings provided through struct
drm_connector_hdmi_funcs end up in the SPD InfoFrame, whose fields are
defined by the HDMI specification as fixed-size: 8 bytes for the vendor
name and 16 bytes for the product description, padded with zeros and
left without any trailing NUL when a name spans the whole field.

Add a connector variant implementing the SPD InfoFrame hooks, along with
parametrized tests covering both the padded and the exact length cases.
Check the names both in the connector state and in the packed InfoFrame
passed to the .write_infoframe() hook, which is captured for that
purpose.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 167 ++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index b98060b73742..294be8f4a307 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -38,6 +38,9 @@ struct drm_atomic_helper_connector_hdmi_priv {
 	size_t current_edid_len;
 
 	int hdmi_update_failures;
+
+	u8 spd_infoframe[HDMI_INFOFRAME_SIZE(SPD)];
+	size_t spd_infoframe_len;
 };
 
 #define connector_to_priv(c) \
@@ -3444,6 +3447,167 @@ static void drm_test_check_infoframes(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+struct drm_hdmi_spd_infoframe_test {
+	const char *name;
+	const char *vendor;
+	const char *product;
+	char expected_vendor[HDMI_SPD_INFOFRAME_VENDOR_LEN];
+	char expected_product[HDMI_SPD_INFOFRAME_PRODUCT_LEN];
+};
+
+static const struct drm_hdmi_spd_infoframe_test drm_hdmi_spd_infoframe_tests[] = {
+	{
+		.name = "shorter-than-field",
+		.vendor = "Vend",
+		.product = "Prod",
+		.expected_vendor = { 'V', 'e', 'n', 'd' },
+		.expected_product = { 'P', 'r', 'o', 'd' },
+	},
+	{
+		.name = "whole-field",
+		.vendor = "VendorVe",
+		.product = "ProductProductPr",
+		.expected_vendor = {
+			'V', 'e', 'n', 'd', 'o', 'r', 'V', 'e',
+		},
+		.expected_product = {
+			'P', 'r', 'o', 'd', 'u', 'c', 't',
+			'P', 'r', 'o', 'd', 'u', 'c', 't',
+			'P', 'r',
+		},
+	},
+};
+
+static void drm_hdmi_spd_infoframe_desc(const struct drm_hdmi_spd_infoframe_test *t,
+					char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_hdmi_spd_infoframe, drm_hdmi_spd_infoframe_tests,
+		  drm_hdmi_spd_infoframe_desc);
+
+static int capture_spd_write_infoframe(struct drm_connector *connector,
+				       const u8 *buffer, size_t len)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv =
+		connector_to_priv(connector);
+
+	if (len > sizeof(priv->spd_infoframe))
+		return -EINVAL;
+
+	memcpy(priv->spd_infoframe, buffer, len);
+	priv->spd_infoframe_len = len;
+
+	return 0;
+}
+
+/*
+ * The SPD InfoFrame is only generated for connectors implementing the
+ * related hooks, hence the SPD tests cannot rely on the plain dummy funcs.
+ */
+static const struct drm_connector_hdmi_funcs dummy_connector_hdmi_spd_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.avi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.hdmi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.spd = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = capture_spd_write_infoframe,
+	},
+};
+
+/*
+ * Test that the vendor and product names end up in the SPD InfoFrame padded
+ * with zeros, and without any trailing NUL when spanning the whole field,
+ * both in the connector state and in the packed buffer handed over to the
+ * driver.
+ */
+static void drm_test_check_spd_infoframe(struct kunit *test)
+{
+	const struct drm_hdmi_spd_infoframe_test *param = test->param_value;
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_spd_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_mode *preferred;
+	struct hdmi_spd_infoframe *frame;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	const u8 *payload;
+	int ret;
+
+	hdmi_funcs.vendor = param->vendor;
+	hdmi_funcs.product = param->product;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_encoder_helper_add(&priv->encoder, &test_encoder_helper_funcs);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, priv->hdmi_update_failures, 0);
+
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	KUNIT_ASSERT_TRUE(test, conn_state->hdmi.infoframes.spd.set);
+
+	frame = &conn_state->hdmi.infoframes.spd.data.spd;
+
+	KUNIT_EXPECT_MEMEQ(test, frame->vendor, param->expected_vendor,
+			   sizeof(frame->vendor));
+	KUNIT_EXPECT_MEMEQ(test, frame->product, param->expected_product,
+			   sizeof(frame->product));
+
+	KUNIT_ASSERT_EQ(test, priv->spd_infoframe_len, HDMI_INFOFRAME_SIZE(SPD));
+	KUNIT_EXPECT_EQ(test, priv->spd_infoframe[0], HDMI_INFOFRAME_TYPE_SPD);
+
+	payload = priv->spd_infoframe + HDMI_INFOFRAME_HEADER_SIZE;
+	KUNIT_EXPECT_MEMEQ(test, payload, param->expected_vendor,
+			   HDMI_SPD_INFOFRAME_VENDOR_LEN);
+	KUNIT_EXPECT_MEMEQ(test, payload + HDMI_SPD_INFOFRAME_VENDOR_LEN,
+			   param->expected_product,
+			   HDMI_SPD_INFOFRAME_PRODUCT_LEN);
+	KUNIT_EXPECT_EQ(test,
+			payload[HDMI_SPD_INFOFRAME_VENDOR_LEN +
+				HDMI_SPD_INFOFRAME_PRODUCT_LEN],
+			HDMI_SPD_SDI_PC);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static int reject_infoframe_write_infoframe(struct drm_connector *connector,
 					    const u8 *buffer, size_t len)
 {
@@ -3917,9 +4081,10 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
-
 static struct kunit_case drm_atomic_helper_connector_hdmi_infoframes_tests[] = {
 	KUNIT_CASE(drm_test_check_infoframes),
+	KUNIT_CASE_PARAM(drm_test_check_spd_infoframe,
+			 drm_hdmi_spd_infoframe_gen_params),
 	KUNIT_CASE(drm_test_check_reject_avi_infoframe),
 	KUNIT_CASE(drm_test_check_reject_hdr_infoframe_bpc_8),
 	KUNIT_CASE(drm_test_check_reject_hdr_infoframe_bpc_10),

-- 
2.56.0

