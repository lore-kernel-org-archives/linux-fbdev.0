Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679473;
	b=vxeycNGU0P3LdsqbDxflwiBIrJ8dkwVIClH0SW1khWruBPtewknCF5pjItQH4/KfwMT+
	 KX5N27aoTIQggaDsSNmkgnrgCKMVMkXk8ga8l1CyBijkf0ozv4O90FIztztXLl1qijUxZ
	 93bgxn+dvX8ueoT6WLGA2FBtwOwLynLZrH7Ro9uyjEi4CcTaLH55zapWaBvUKb7msM6Gr
	 5ArETV8SvF8yZDR9bw0+BHpjlscDxHCjAr2r7ctJro732UNwm+UCW4VG+7+VJoictFtlM
	 oCt1fMYrDDFOn2xf4FGDmL4CULDkxlKMipIiauEppMxXRn5leRmkrM9MF0lRx+ZAPLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679473;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=1Q3QjozH7PEkbgAKJELVlxjQi/apMM3biPsAfKdaWiU=;
	b=dNzvyKwf7S2aG9SDt+kwhPyjTFWjY99DsFYCO6iuX0cu+TXrqPrrMNRnqeEWffl+6OKF
	 Foneq3SdzVYjs3bCuU8x4Vcv8QZ0WMNRJYf7bs4gG6SB5YDGYBBKk02AxGNntotCvTb4k
	 bnEUj8NFIzrIrRSEv97LxyzQLS+pl/KkVZRTyp5H5X39puOJujrO+lccmNy/c8nps1iDN
	 O0JE0MojkWtlTxrBc36c4imhidRi+jUp5lff5rC5grKV7oTgUmUgT8oIIskHArBLgzdcF
	 v/sQ8DJnVM5RrWxXUZPRSokiFavARU67hnmVk56A6Cf/5v+s5CK2RbAG1PvF4s/w8Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P4Pk0KQH;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FEC60A6F4F;
	Sat, 14 Nov 2026 18:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05FEC60A6F4F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P4Pk0KQH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679471;
	bh=ovne9Xe5qJpQorhZjZ57Dceh/yXJoL+nWUJjU3Cg8gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P4Pk0KQH+ye8PzM1FZTl6zWEaO8dBbXRr4Ai678OQV6F1OtyfHFDUNxCvr1LKq3aw
	 a9OZlj16TXef6SEnCnkwtAYuewasUn8r2u0bC2CwA31H1Pa1kp/LIw1NYoC0QawK0T
	 hsUwdWAKRTb20G6jJgifE/hB/PyyoPsFjJyj5u2VUcxFqt//5h8Ipg5ZAZQWiHl0MK
	 dybxAqMJXTmRwYoNQvyNeOJ10bDqPIlbFydhaGkhlbym7n/jWtnmzCqyyVrw/gNLRv
	 qZ0ckrpmtrCAKtD8EF+1YkJ19ofkU6Wo8hDKk+dRLnr91krz27heQ4QQqcTui0f/I3
	 iQFOX8OJ2HYIQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 790B117E3BEB;
	Sat, 14 Nov 2026 19:04:31 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:43 +0200
Subject: [PATCH 19/25] drm/tests: hdmi: Verify scrambler_needed computation
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
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-19-20e8a33a2286@collabora.com>
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

Scrambling is only required when the TMDS character rate exceeds 340
MHz, so the decision must be based on that rate rather than on the mode
clock.  Add atomic-check tests on an HDMI 2.0 connector, for which the
core infers scrambler support and a 600 MHz TMDS limit, covering:

- 1080p@60 CEA (148.5 MHz TMDS): scrambler_needed clear
- 4K@60 RGB preferred mode (594 MHz TMDS): scrambler_needed set
- 4K@60 YUV420 (297 MHz TMDS): scrambler_needed clear
- 4K@30 RGB at 10 bpc (371.25 MHz TMDS): scrambler_needed set

Also check that scrambler_needed is cleared when switching from a
high-rate to a low-rate mode, instead of being carried over from the
previous state.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 390 +++++++++++++++++++++
 1 file changed, 390 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index d94ec8680a1e..b98060b73742 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -216,6 +216,34 @@ static const struct drm_connector_hdmi_funcs reject_over_165mhz_connector_hdmi_f
 	},
 };
 
+static int accept_scrambler_enable(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static int accept_scrambler_disable(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static const struct drm_connector_hdmi_funcs scrambler_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_2_0,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.scrambler_enable = accept_scrambler_enable,
+	.scrambler_disable = accept_scrambler_disable,
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
 static int dummy_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv =
@@ -2263,6 +2291,363 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Test that on an HDMI connector with source+sink scrambling support, driving
+ * a sub-340 MHz CEA mode, we end up with scrambler_needed cleared.
+ */
+static void drm_test_check_scrambler_needed_low_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_info *info;
+	struct drm_display_mode *low_rate_mode;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	unsigned long long rate;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&scrambler_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	info = &conn->display_info;
+	KUNIT_ASSERT_TRUE(test, drm_connector_hdmi_scrambler_supported(conn));
+	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.supported);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.scrambling.supported);
+
+	low_rate_mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
+	KUNIT_ASSERT_NOT_NULL(test, low_rate_mode);
+
+	rate = drm_hdmi_compute_mode_clock(low_rate_mode, 8,
+					   DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_LT(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     low_rate_mode, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_LE(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that on an HDMI connector with source+sink scrambling support, driving
+ * the 4K@60 RGB preferred mode (594 MHz TMDS, above the 340 MHz threshold),
+ * we end up with scrambler_needed set.
+ */
+static void drm_test_check_scrambler_needed_high_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_info *info;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	unsigned long long rate;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&scrambler_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	info = &conn->display_info;
+	KUNIT_ASSERT_TRUE(test, drm_connector_hdmi_scrambler_supported(conn));
+	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.supported);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.scrambling.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	rate = drm_hdmi_compute_mode_clock(preferred, 8,
+					   DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_GT(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_GT(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that on an HDMI connector with source+sink scrambling support, driving
+ * the 4K@60 preferred mode with a YUV420 output format (297 MHz TMDS), we end
+ * up with scrambler_needed cleared.
+ */
+static void drm_test_check_scrambler_needed_yuv420(struct kunit *test)
+{
+	struct drm_connector_hdmi_funcs hdmi_funcs = scrambler_connector_hdmi_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_commit *state;
+	struct drm_display_info *info;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	info = &conn->display_info;
+	KUNIT_ASSERT_TRUE(test, drm_connector_hdmi_scrambler_supported(conn));
+	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.supported);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.scrambling.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_ASSERT_TRUE(test, drm_mode_is_420_also(&conn->display_info, preferred));
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format,
+			DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_EXPECT_GT(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.scrambler_needed);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_conn_state:
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	if (PTR_ERR(conn_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->color_format = DRM_CONNECTOR_COLOR_FORMAT_YCBCR420;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format,
+			DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+	KUNIT_EXPECT_LE(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that on an HDMI connector with source+sink scrambling support, driving
+ * a 4K@30 mode (297 MHz TMDS at 8 bpc) with 10 bpc RGB (371.25 MHz TMDS), we
+ * end up with scrambler_needed set, i.e. the decision accounts for the bpc.
+ */
+static void drm_test_check_scrambler_needed_deep_color(struct kunit *test)
+{
+	struct drm_connector_hdmi_funcs hdmi_funcs = scrambler_connector_hdmi_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_mode *mode;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	unsigned long long rate;
+	int ret;
+
+	hdmi_funcs.max_bpc = 10;
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 95);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	rate = drm_hdmi_compute_mode_clock(mode, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_LE(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	rate = drm_hdmi_compute_mode_clock(mode, 10, DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_GT(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     mode, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 10);
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format,
+			DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_EXPECT_GT(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that on an HDMI connector with source+sink scrambling support,
+ * switching from the 4K@60 RGB preferred mode (594 MHz TMDS) to a 1080p@60
+ * CEA mode (148.5 MHz TMDS), we end up with scrambler_needed cleared.
+ */
+static void drm_test_check_scrambler_needed_cleared(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *low_rate_mode;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	unsigned long long rate;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&scrambler_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	rate = drm_hdmi_compute_mode_clock(preferred, 8,
+					   DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_GT(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	low_rate_mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
+	KUNIT_ASSERT_NOT_NULL(test, low_rate_mode);
+
+	rate = drm_hdmi_compute_mode_clock(low_rate_mode, 8,
+					   DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_LE(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_GT(test, conn->state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_ASSERT_TRUE(test, conn->state->hdmi.scrambler_needed);
+
+retry_conn_low_rate:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     low_rate_mode, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_low_rate;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_LE(test, conn->state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_FALSE(test, conn->state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 struct color_format_test_param {
 	enum drm_connector_color_format fmt;
 	enum drm_output_color_format expected;
@@ -2505,6 +2890,11 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_8bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_10bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_12bpc),
+	KUNIT_CASE(drm_test_check_scrambler_needed_low_rate),
+	KUNIT_CASE(drm_test_check_scrambler_needed_high_rate),
+	KUNIT_CASE(drm_test_check_scrambler_needed_yuv420),
+	KUNIT_CASE(drm_test_check_scrambler_needed_deep_color),
+	KUNIT_CASE(drm_test_check_scrambler_needed_cleared),
 	KUNIT_CASE_PARAM(drm_test_check_hdmi_color_format,
 			 check_hdmi_color_format_gen_params),
 	KUNIT_CASE_PARAM(drm_test_check_hdmi_color_format_420_only,

-- 
2.56.0

