Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679475;
	b=bP+4AEGRHw/UvyU+AX5kD3uRPeaMgJsBsm5Mv/qsWJvYkAMAg1SRnAaG21uU/RVbyPYr
	 OabzeEUc4WW5k03bUOFVOLacpLTmmt3WiyhtRKSdLz8p4pOVTfW8x83Wt8KKLNKfiPbac
	 vmJvYegGbs+Pamc+CQIdAlNJtXUzIEJddeOu4Oz/hXlPgxRBs/IjQovLpyF/9ssfhi7B5
	 j56DoJvY5yCUPVy/jqa278f4tGzoI56F15kE5YxcaSgcAE2D0d9Q1fmxUvQwtUQeHaFqa
	 T7HY26xr5afMUamOcEZZ+jcEbomMmVIBdjDQmY6YErqOTFv9sb6cUfBX7qfImXwLvqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679475;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=D8zifGSVG3hcY3J/xTKR4bLRn5FtsL9PY/w0j9SmVi8=;
	b=xqoxu6ECdBpmIO7hRGWiXDm4mj7C5SoApQuNeSODM9hBj9+UFdSUHrc65vHOt3qRG1Ky
	 EPaleneJZZXd+SsM3JBuXT9h3HpNCL/3XDf4tyPF6BsAPjiwNrWYLgo0GYtaCS2zshG3F
	 35gSA7xGoh+AFYjSZqJTxdXEXt0alYV9Lk3WY9CvePQedo7SibWgPObEsS4pmV6ttonbJ
	 I1L0ahZngZW3+rlERNfXqX66xVq/MCQq3UpwUMYr9xugz606ZlUuCUuLt63l6vOkOb+0j
	 88rnoUGF9vGIGNdni6t+oPgsAUPZ52PYwGp/nmTiLfMhbnntihSab8tZqClnhqNAQ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=C8r9wcvc;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF5606A88E;
	Sat, 14 Nov 2026 18:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53CF5606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=C8r9wcvc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679473;
	bh=9c+ztpssMq+5co5JuAnswcQK52kvlqN6pPC1WNH9Ax0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C8r9wcvc8bBI06R6OfqSvfXVHta+HL5o5wo8iTmhnyihxrN2Bpqsk+EoZ1KxXKe9N
	 FXBaiafKhILU3vH9C2rS4lVgeG7uUNBDwEX8CAVxMqHZzg8tTauK/fvzS9KatbS1TH
	 WGaBJuyZNKjDw8fX+qErRxsrsX5K2PiE9y/Dh1V3J7i+kvjyeS6Z8p7lCF4rb0ONcf
	 59EgkJ9tVXNzTFBy2Vko2b/ReZqEwxwX93TZi/VXwNH5hO/qjOOrihzTM3wp4sRy6F
	 PjAf6iZAELktGlD9+QAGKiLpW/gd0a1n0mztvC8V5DTLaFojlByaiXMkBlQbmlTeEk
	 eRy6BRVSE9o/Q==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C7A9D17E14F9;
	Sat, 14 Nov 2026 19:04:33 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:46 +0200
Subject: [PATCH 22/25] drm/tests: hdmi: Verify SCDC resync on hotplug
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
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-22-20e8a33a2286@collabora.com>
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

When a sink gets reconnected while the display pipeline is active, its
SCDC scrambling setup is lost and must be restored through a CRTC reset.
This is handled by drm_connector_hdmi_sync_scdc(), which is invoked by
the HDMI connector hotplug and .force_ctx() helpers.

Count the encoder enables to detect CRTC resets, and add tests to make
sure that:

- the CRTC is reset only if the sink got (re)plugged, the active mode
  needs scrambling and the sink reports scrambling as disabled
- drm_atomic_helper_connector_hdmi_hotplug() leaves the pipeline alone
  on disconnect, while on reconnect it restores the sink setup only if
  the sink lost it while being unplugged
- DDC errors are reported by drm_connector_hdmi_sync_scdc(), but not by
  drm_atomic_helper_connector_hdmi_hotplug(), as .detect_ctx() may only
  return a connector status or -EDEADLK
- drm_atomic_helper_connector_hdmi_force_ctx() restores the sink setup

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 312 +++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 46654d8fa45c..f17ccbf52bb1 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -42,6 +42,7 @@ struct drm_atomic_helper_connector_hdmi_priv {
 	size_t current_edid_len;
 
 	int hdmi_update_failures;
+	unsigned int encoder_enable_count;
 
 	u8 spd_infoframe[HDMI_INFOFRAME_SIZE(SPD)];
 	size_t spd_infoframe_len;
@@ -315,6 +316,8 @@ static void test_encoder_atomic_enable(struct drm_encoder *encoder,
 		encoder_to_priv(encoder);
 	int ret;
 
+	priv->encoder_enable_count++;
+
 	ret = drm_atomic_helper_connector_hdmi_update_infoframes(&priv->connector, state);
 	if (ret)
 		priv->hdmi_update_failures++;
@@ -4789,12 +4792,321 @@ static struct kunit_suite drm_atomic_helper_connector_hdmi_scrambling_test_suite
 	.test_cases	= drm_atomic_helper_connector_hdmi_scrambling_tests,
 };
 
+static const struct drm_edid *test_read_edid(struct drm_connector *connector)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv =
+		connector_to_priv(connector);
+
+	return drm_edid_alloc(priv->current_edid, priv->current_edid_len);
+}
+
+static const struct drm_connector_hdmi_funcs scdc_read_edid_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_2_0,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.read_edid = test_read_edid,
+	.scrambler_enable = count_scrambler_enable,
+	.scrambler_disable = count_scrambler_disable,
+	.avi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.hdmi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+};
+
+/*
+ * Sets up an HDMI 2.0 connector attached to a sink supporting scrambling and
+ * drives the given CEA mode on it, leaving the locks held in @ctx.
+ */
+static struct drm_atomic_helper_connector_hdmi_priv *
+sync_scdc_test_init(struct kunit *test,
+		    const struct drm_connector_hdmi_funcs *hdmi_funcs,
+		    u8 vic, struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *mode;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test, hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm_encoder_helper_add(&priv->encoder, &test_encoder_helper_funcs);
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, vic);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	drm_modeset_acquire_init(ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, &priv->drm,
+						     priv->crtc,
+						     &priv->connector,
+						     mode, ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, priv->encoder_enable_count, 1);
+
+	return priv;
+}
+
+struct drm_hdmi_sync_scdc_test {
+	const char *desc;
+	u8 vic;
+	bool plugged;
+	u8 tmds_config;
+	int xfer_err;
+	int expected_ret;
+	bool expected_reset;
+};
+
+static const struct drm_hdmi_sync_scdc_test drm_hdmi_sync_scdc_params[] = {
+	{
+		.desc = "scrambling lost",
+		.vic = 97,
+		.plugged = true,
+		.expected_reset = true,
+	},
+	{
+		.desc = "scrambling active",
+		.vic = 97,
+		.plugged = true,
+		.tmds_config = SCDC_SCRAMBLING_ENABLE,
+	},
+	{
+		.desc = "scrambling not needed",
+		.vic = 16,
+		.plugged = true,
+	},
+	{
+		.desc = "unplugged",
+		.vic = 97,
+		.plugged = false,
+	},
+	{
+		.desc = "ddc error",
+		.vic = 97,
+		.plugged = true,
+		.xfer_err = -EIO,
+		.expected_ret = -EIO,
+	},
+};
+
+static void drm_hdmi_sync_scdc_desc(const struct drm_hdmi_sync_scdc_test *t,
+				    char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_hdmi_sync_scdc, drm_hdmi_sync_scdc_params,
+		  drm_hdmi_sync_scdc_desc);
+
+/*
+ * Test that drm_connector_hdmi_sync_scdc() resets the CRTC to restore the sink
+ * scrambling setup only when the sink got (re)plugged, the active mode needs
+ * scrambling and the sink reports it as disabled.
+ */
+static void drm_test_hdmi_sync_scdc(struct kunit *test)
+{
+	const struct drm_hdmi_sync_scdc_test *params = test->param_value;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	unsigned int xfer_count;
+	int ret;
+
+	priv = sync_scdc_test_init(test, &scdc_connector_hdmi_funcs,
+				   params->vic, &ctx);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.state->hdmi.scrambler_needed,
+			params->vic == 97);
+
+	priv->scdc_regs[SCDC_TMDS_CONFIG] = params->tmds_config;
+	priv->scdc_xfer_err = params->xfer_err;
+	xfer_count = priv->scdc_xfer_count;
+
+retry:
+	ret = drm_connector_hdmi_sync_scdc(&priv->connector, params->plugged, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_EXPECT_EQ(test, ret, params->expected_ret);
+
+	KUNIT_EXPECT_EQ(test, priv->encoder_enable_count,
+			params->expected_reset ? 2 : 1);
+
+	if (!params->plugged || params->vic != 97)
+		KUNIT_EXPECT_EQ(test, priv->scdc_xfer_count, xfer_count);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+struct drm_hdmi_sync_scdc_hotplug_test {
+	const char *desc;
+	bool sink_reset;
+};
+
+static const struct drm_hdmi_sync_scdc_hotplug_test
+drm_hdmi_sync_scdc_hotplug_params[] = {
+	{ .desc = "sink setup lost", .sink_reset = true, },
+	{ .desc = "sink setup kept", .sink_reset = false, },
+};
+
+static void
+drm_hdmi_sync_scdc_hotplug_desc(const struct drm_hdmi_sync_scdc_hotplug_test *t,
+				char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_hdmi_sync_scdc_hotplug,
+		  drm_hdmi_sync_scdc_hotplug_params,
+		  drm_hdmi_sync_scdc_hotplug_desc);
+
+/*
+ * Test that drm_atomic_helper_connector_hdmi_hotplug() leaves the pipeline
+ * alone on disconnect, while on reconnect it restores the sink scrambling
+ * setup only if the sink lost it while being unplugged.
+ */
+static void drm_test_hdmi_sync_scdc_hotplug(struct kunit *test)
+{
+	const struct drm_hdmi_sync_scdc_hotplug_test *params = test->param_value;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = sync_scdc_test_init(test, &scdc_read_edid_connector_hdmi_funcs,
+				   97, &ctx);
+	KUNIT_ASSERT_TRUE(test, priv->connector.state->hdmi.scrambler_needed);
+
+	priv->scdc_regs[SCDC_TMDS_CONFIG] = SCDC_SCRAMBLING_ENABLE;
+	conn = &priv->connector;
+
+retry_disconnect:
+	ret = drm_atomic_helper_connector_hdmi_hotplug(conn, &ctx,
+						       connector_status_disconnected);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_disconnect;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->encoder_enable_count, 1);
+	KUNIT_EXPECT_FALSE(test, conn->display_info.is_hdmi);
+
+	/* Simulate the sink losing its SCDC setup while being unplugged */
+	if (params->sink_reset)
+		priv->scdc_regs[SCDC_TMDS_CONFIG] = 0;
+
+retry_connect:
+	ret = drm_atomic_helper_connector_hdmi_hotplug(conn, &ctx,
+						       connector_status_connected);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_connect;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+	KUNIT_EXPECT_EQ(test, priv->encoder_enable_count,
+			params->sink_reset ? 2 : 1);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that drm_atomic_helper_connector_hdmi_hotplug() doesn't report SCDC
+ * errors, as .detect_ctx() may only return a connector status or -EDEADLK.
+ */
+static void drm_test_hdmi_sync_scdc_hotplug_ddc_error(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	int ret;
+
+	priv = sync_scdc_test_init(test, &scdc_read_edid_connector_hdmi_funcs,
+				   97, &ctx);
+
+	priv->scdc_xfer_err = -EIO;
+
+retry:
+	ret = drm_atomic_helper_connector_hdmi_hotplug(&priv->connector, &ctx,
+						       connector_status_connected);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->encoder_enable_count, 1);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that drm_atomic_helper_connector_hdmi_force_ctx() restores the sink
+ * scrambling setup of a connector forced on.
+ */
+static void drm_test_hdmi_sync_scdc_force_ctx(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	int ret;
+
+	priv = sync_scdc_test_init(test, &scdc_read_edid_connector_hdmi_funcs,
+				   97, &ctx);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.status, connector_status_connected);
+
+retry:
+	ret = drm_atomic_helper_connector_hdmi_force_ctx(&priv->connector, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->encoder_enable_count, 2);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+static struct kunit_case drm_atomic_helper_connector_hdmi_sync_scdc_tests[] = {
+	KUNIT_CASE_PARAM(drm_test_hdmi_sync_scdc, drm_hdmi_sync_scdc_gen_params),
+	KUNIT_CASE_PARAM(drm_test_hdmi_sync_scdc_hotplug,
+			 drm_hdmi_sync_scdc_hotplug_gen_params),
+	KUNIT_CASE(drm_test_hdmi_sync_scdc_hotplug_ddc_error),
+	KUNIT_CASE(drm_test_hdmi_sync_scdc_force_ctx),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_helper_connector_hdmi_sync_scdc_test_suite = {
+	.name		= "drm_atomic_helper_connector_hdmi_sync_scdc",
+	.test_cases	= drm_atomic_helper_connector_hdmi_sync_scdc_tests,
+};
+
 kunit_test_suites(
 	&drm_atomic_helper_connector_hdmi_check_test_suite,
 	&drm_atomic_helper_connector_hdmi_reset_test_suite,
 	&drm_atomic_helper_connector_hdmi_mode_valid_test_suite,
 	&drm_atomic_helper_connector_hdmi_infoframes_test_suite,
 	&drm_atomic_helper_connector_hdmi_scrambling_test_suite,
+	&drm_atomic_helper_connector_hdmi_sync_scdc_test_suite,
 );
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");

-- 
2.56.0

