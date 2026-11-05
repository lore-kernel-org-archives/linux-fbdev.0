Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894228;
	b=1R3Al/K3mXIbvQATC26YFeNlL72oaDRXMmXEzU9yMR/ytA/4BCokeCZ4W6R05crqPZ82
	 VkOXWD4XEBxz455JmYvtx2M++g19Ae66NBet6zXI2o/lDCga5NZ+NKsvZzHshcNTDZPV1
	 m5MR+FQjxtwzgp8atoD4ZXY0Gl0smdDSnhPfGnjnbD6xZYA9SkcxcLp/Dc+WdyJ/daWw4
	 w2WCWL1+c9q9RcasHPJqhdDSbsyhF1vHZ4YtgJEU3wrJI+FCWqu8UCf6nrOBYZkuAKhpo
	 BlqA0bQUWGPcyh8B0mooQA6eQyfUYshUrj9rNil42NGeZRzxmI1/W5PgjNEDVWopR7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894228;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=flsuFq14o816MWACouGrfjkvB7UYKbtN0BBr46XFxiI=;
	b=k2WKaV21lqyxJjzJ6/stw5xcJOWnki3qCJJvY+1MC4kQBzcztv//wahmHU7Wl3XBW2sp
	 0LPlzhEs5NwsYAoH82JQikVDUvVW4o5ro+ghcxnskejyD3MUUY0JzamAYtRzFhtyPZBbr
	 qLAWx5oIGFFWl+6nntMmkqIVwNi/srIXwQpzvoeNHetu/KyLVAJGcievZbgJZdsLLNy+o
	 qHT4WmPQmtfpUib7YmYzYqurWMQS0Je3hRPsVDDq590DjcfQ8lnAN1HplOf6kQg69vHVy
	 6LlEmMCr9PrA7H+KXsYyo4dueCTOR/nwvhiWnbPhRCcrjA5Foa+QhiyOjvQG+vxUTtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=FVsdXPwr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539860720DB;
	Thu,  5 Nov 2026 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8539860720DB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=FVsdXPwr
ARC-Seal: i=1; a=rsa-sha256; t=1793894099; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fh4F7EtcB9gi3lPi/lziXVS+1zV3VHmrx+QNYClWb0fIU4yClugt9sK9n21fpuQCuLfNPG8TmcmSub2eiJBnUfQPDfkjEiZ1ggij9PaaqfFo3GKQPOa/JkmJEkWWoDYUYEPsqlY2iqElvt//8APmH2CEiXH5H5VQ6YaXnw/T9Gs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894099; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=flsuFq14o816MWACouGrfjkvB7UYKbtN0BBr46XFxiI=; 
	b=JLCTF/rsE/8QeIXWu4b7JIwQ/0P/iaFyaaTcw8hf5l9XC37HwlwPGbfAjb50HfWcE29E/HUJ8Hz+0v3dECSUs/0r9J2QPTxljuMdYxCgxbzPVCwyeTuw77hsf02wtHkMYlm0BbFymm/sEGkbS8AJ6uIQIBbnBqiZAh1TWU6bgFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=FVsdXPwrwBtURlUgfQPLp4ym0WpOJ5LAqE/fYV1xyUOl7kePTUkis1+6bFvm34IqDP0ar4+D8SwsHUpC48Xft+IrUZFaGNG1KdwKnAMnQJsDAFLiY6622M3CUG8d7WtmqZlrNnCobPmHAYnnwxfjDEvjejcL23zNlIfRIAhEGVM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=flsuFq14o816MWACouGrfjkvB7UYKbtN0BBr46XFxiI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894097520640.942599913008;
	Thu, 5 Nov 2026 07:54:57 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:14 +0100
Subject: [PATCH v2 23/27] drm/tests: hdmi: Add Fixed/Constrained rate VRR
 tests
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
Message-Id: <20261105-vrr-limiter-uapi-v2-23-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2

Add tests to verify the functionality of the
VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR} properties and the HDMI state
helpers that make use of them.

This includes tests for fixed rate scenarios, as well as a test for a
constrained game mode scenario. A parametric test case checks that
various erroneous target rates are rejected.

Proper handling of CinemaVRR is tested as well.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 386 +++++++++++++++++++++
 1 file changed, 386 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index def414085069..4d9bcab57778 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -3674,10 +3674,396 @@ static void drm_test_check_hdmi_vrr_flush_vsync(struct kunit *test)
 			crtc_state->vrr_state.max_vtotal);
 }
 
+/*
+ * Check that on a VRR-capable sink with VRR enabled and a fixed target rate
+ * set, an atomic commit works, and the derived vtotals are as expected.
+ */
+static void drm_test_check_hdmi_vrr_fixed_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_TRUE(test, priv->connector.display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, priv->connector.display_info.hdmi.vrr_cap.supported);
+	KUNIT_ASSERT_TRUE(test, priv->connector.display_info.hdmi.vrr_cap.cinema_vrr);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
+
+	guard(modeset_lock)(&ctx);
+
+	allocate_state_for_vrr_test(test, priv, &ctx, preferred, &state);
+
+retry:
+	prepare_state_for_vrr_test(test, priv, &ctx, state, &crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 40;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	/* Equivalent fraction, expressed differently to pose a hurdle */
+	crtc_state->vrr_state.vrr_max_n = 40000;
+	crtc_state->vrr_state.vrr_max_d = 1000;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, priv->crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 40);
+
+	/* Minimum rate is 24Hz because of the CinemaVRR flag */
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.max_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 24);
+}
+
+/*
+ * Check that the drm_hdmi_helper_vrr_flush() and drm_hdmi_helper_vrr_vsync()
+ * helpers return the expected values on a VRR-capable sink with VRR enabled
+ * and a fixed target set.
+ */
+static void drm_test_check_hdmi_vrr_fixed_rate_flush_vsync(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_TRUE(test, priv->connector.display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, priv->connector.display_info.hdmi.vrr_cap.supported);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
+
+	scoped_guard(modeset_lock, &ctx) {
+		allocate_state_for_vrr_test(test, priv, &ctx, preferred, &state);
+
+retry:
+		prepare_state_for_vrr_test(test, priv, &ctx, state, &crtc_state);
+
+		crtc_state->vrr_enabled = true;
+		crtc_state->vrr_state.vrr_min_n = 40000;
+		crtc_state->vrr_state.vrr_min_d = 1001;
+		/* Equivalent fraction, expressed differently to pose a hurdle */
+		crtc_state->vrr_state.vrr_max_n = 80000;
+		crtc_state->vrr_state.vrr_max_d = 2002;
+
+		ret = drm_atomic_commit(state);
+		if (ret == -EDEADLK) {
+			drm_atomic_commit_clear(state);
+			ret = drm_modeset_backoff(&ctx);
+			if (!ret)
+				goto retry;
+		}
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		crtc_state = drm_atomic_get_new_crtc_state(state, priv->crtc);
+		KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+		KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+				mult_frac(preferred->crtc_vtotal, mode_refresh * 1000, 39960));
+
+		/* Fixed rate case: flush should never trigger a vtotal update. */
+		KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_flush(crtc_state));
+		KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal, 0);
+
+		/*
+		 * Invoking drm_hdmi_helper_vrr_flush() again should not change
+		 * cur_vtotal, meaning it should return false.
+		 */
+		KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_flush(crtc_state));
+		KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal, 0);
+
+		/* First vsync will set cur_vtotal. */
+		KUNIT_EXPECT_TRUE(test, drm_crtc_helper_vrr_vsync(crtc_state));
+		KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+				crtc_state->vrr_state.base_vtotal);
+		/* First vsync with fixed rate will still be dynamic. */
+		KUNIT_EXPECT_TRUE(test, crtc_state->vrr_state.dynamic);
+	}
+
+	/* Try a second commit to evaluate the dynamic flag */
+	scoped_guard(modeset_lock, &ctx) {
+		allocate_state_for_vrr_test(test, priv, &ctx, preferred, &state);
+
+retry_2:
+		prepare_state_for_vrr_test(test, priv, &ctx, state, &crtc_state);
+
+		ret = drm_atomic_commit(state);
+		if (ret == -EDEADLK) {
+			drm_atomic_commit_clear(state);
+			ret = drm_modeset_backoff(&ctx);
+			if (!ret)
+				goto retry_2;
+		}
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		crtc_state = drm_atomic_get_new_crtc_state(state, priv->crtc);
+		KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+		KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_flush(crtc_state));
+		KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+				crtc_state->vrr_state.base_vtotal);
+		KUNIT_EXPECT_FALSE(test, crtc_state->vrr_state.dynamic);
+		KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_vsync(crtc_state));
+		KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+				crtc_state->vrr_state.base_vtotal);
+		/* Subsequent vsyncs with fixed rate won't be dynamic. */
+		KUNIT_EXPECT_FALSE(test, crtc_state->vrr_state.dynamic);
+	}
+}
+
+struct vrr_target_error_params {
+	unsigned int vrr_min_n;
+	unsigned int vrr_min_d;
+	unsigned int vrr_max_n;
+	unsigned int vrr_max_d;
+	bool cinema_vrr_override;
+	const char *desc;
+};
+
+static struct vrr_target_error_params vrr_target_errors[] = {
+	{ 26, 1, 26 * 2000, 2000, false, "VRR target <= min rate should fail" },
+	{ 200, 1, 200, 1, true, "VRR target <= max rate should fail" },
+	{ 60, 1, 40, 1, true, "VRR max target <= VRR min target should fail" },
+	{ 40, 1, 60, 0, true, "VRR max target denominator of 0 should fail" },
+	{ 40, 0, 60, 1, true, "VRR min target denominator of 0 should fail" },
+	{ 25000, 1001, 30, 1, true, "CinemaVRR with non-fixed rate should fail" },
+	{ 0, 1000, 60, 1, true, "Minimum-Incomplete range should fail" },
+	{ 40, 1, 0, 0, false, "Maximum-Incomplete range should fail" },
+};
+
+KUNIT_ARRAY_PARAM_DESC(check_vrr_target_errors, vrr_target_errors, desc);
+
+/*
+ * Check that on a VRR-capable sink with VRR enabled and various erroneous
+ * combinations of target rates set, an atomic commit fails.
+ */
+static void drm_test_check_hdmi_vrr_target_rate_fail(struct kunit *test)
+{
+	const struct vrr_target_error_params *params = test->param_value;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_cap.supported);
+	KUNIT_ASSERT_LT(test, 24, conn->display_info.hdmi.vrr_cap.vrr_min);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	guard(modeset_lock)(&ctx);
+
+	allocate_state_for_vrr_test(test, priv, &ctx, preferred, &state);
+
+retry:
+	prepare_state_for_vrr_test(test, priv, &ctx, state, &crtc_state);
+
+	/*
+	 * Allow individual test parameters to play with the CinemaVRR flag
+	 * without needing to bring their own modified EDID.
+	 */
+	conn->display_info.hdmi.vrr_cap.cinema_vrr = params->cinema_vrr_override;
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = params->vrr_min_n;
+	crtc_state->vrr_state.vrr_min_d = params->vrr_min_d;
+	crtc_state->vrr_state.vrr_max_n = params->vrr_max_n;
+	crtc_state->vrr_state.vrr_max_d = params->vrr_max_d;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a VRR-capable sink that has the CinemaVRR flag set, with VRR
+ * enabled and a fixed target rate set, an atomic commit succeeds at a rate
+ * only possible if CinemaVRR is supported and a fixed target is used.
+ */
+static void drm_test_check_hdmi_vrr_fixed_rate_cinema_vrr(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_cap.supported);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_cap.cinema_vrr);
+	KUNIT_ASSERT_LT(test, 24, conn->display_info.hdmi.vrr_cap.vrr_min);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
+
+	guard(modeset_lock)(&ctx);
+
+	allocate_state_for_vrr_test(test, priv, &ctx, preferred, &state);
+
+retry:
+	prepare_state_for_vrr_test(test, priv, &ctx, state, &crtc_state);
+
+	crtc_state->vrr_enabled = true;
+
+	/* 24/1.001 Hz should work */
+	crtc_state->vrr_state.vrr_min_n = 24000;
+	crtc_state->vrr_state.vrr_min_d = 1001;
+	crtc_state->vrr_state.vrr_max_n = 24000;
+	crtc_state->vrr_state.vrr_max_d = 1001;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+			mult_frac(preferred->crtc_vtotal, mode_refresh * 1000, 23976));
+}
+
+/*
+ * Check that on a VRR-capable sink, an atomic commit with a VRR minimum and
+ * maximum target rate that's more narrow than the monitor's target rate
+ * succeeds and produces the expected derived values.
+ */
+static void drm_test_check_hdmi_vrr_constrained_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_cap.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
+
+	guard(modeset_lock)(&ctx);
+
+	allocate_state_for_vrr_test(test, priv, &ctx, preferred, &state);
+
+retry:
+	prepare_state_for_vrr_test(test, priv, &ctx, state, &crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 40;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	crtc_state->vrr_state.vrr_max_n = 80;
+	crtc_state->vrr_state.vrr_max_d = 1;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, priv->crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 80);
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.max_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 40);
+}
+
 static struct kunit_case drm_atomic_helper_connector_hdmi_vrr_tests[] = {
 	KUNIT_CASE(drm_test_check_hdmi_vrr),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_sink_fail),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_flush_vsync),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate_flush_vsync),
+	KUNIT_CASE_PARAM(drm_test_check_hdmi_vrr_target_rate_fail,
+			 check_vrr_target_errors_gen_params),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate_cinema_vrr),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_constrained_rate),
 	{ }
 };
 

-- 
2.56.0

