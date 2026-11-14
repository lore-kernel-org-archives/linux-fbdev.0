Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679477;
	b=Beg+KokPRO3oGPAGRFSjHiW/06Vqm3+G5Bcw6bQYgrNoZQuz/CS5ukUW/FNY3QzXns4W
	 Rf6eBjDkoPpyEIrm4CeVZ34rooZqpLL+/dsgOkift6CUyaaTjnYfqvT9bx36IXM2bp7YJ
	 Tk3wlURYY6lTMi9cJVj2cF1gnBni2voeeU3NZmcYf9LSKkeO+26FYw82utHuKXpUMUJ3b
	 fZA98LzMFgUwX51JyHDL2Rm8z/tkj0cioDY2sKBsJNg1qvNOglTHkuSELMSKvXwzDNBxh
	 CosM1r3iex8uTpomPlTC6snwTa4gdLhlnode4YTnQYuMWaNIyta8tL+MsiSOw7WVUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679477;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=KqlR6Og/xf6HdkcNgQx2/yYhjlmI9dtnOU/aICd5uJI=;
	b=WX4SBvGhSfreXWa467AK9UJjIPa/CBwBaLbjnthta2OK3fAHMB5khBKBurNPzOqwgkTJ
	 sCGSTYGcLnwKkUb87/iRBpweG2bSNOEwMjzOUQAlapyo2CQupRMRPKkhxwOtJfyPIoph6
	 +QK72vw16OvoglWdTFpzy48HvfYammTjfs2URtBhc9yA6Hi/QBDRgj9QF7LakL/i7eYPz
	 R5Ggwhyyvd67O5LDb/1Qc6KJnd9aBMe+/cNZyawCtgtlvaVbOVmlQPYd+mVlfYbKFLh9y
	 Mn9erlBwFe4BAwFTO1k2uwLld9oOS92HDKMrynooFenwVSglkwCbuOxIy1TPtTbjyuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DBLsOyUf;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3A606B5EB;
	Sat, 14 Nov 2026 18:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D3A606B5EB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DBLsOyUf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679475;
	bh=Xv0UPm/o8racomvn8bPDXM+ntONsGF0X3DJtkfA58Jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DBLsOyUfT6PaYPM7Op3GrmLObv5HpzFiiBMPTYgEV7DTS1VOOEVi0930GH7Gfvhk/
	 c19DYj/gmhqkqkRwiQ0ahQck5kzp3cE9++pgjXeo+KO4+vVQBBWMpa0QGtd78LgsdC
	 Sjzo3wGai3DJ4Q3OHFcjzTmkQXlZ58VYVPa+u71R/zXwtXwytrlYZXeXYyuaU9CI6X
	 GWUZVaK+IkKqi813ULdpAd/Za9X2YEVoMoPLTMJhGy2BK++9FA+23/IBEY3argJfwO
	 mf9oaRiqF4X2hG4AXSbWGGgp8d4kF11TiX+Vm3xw35xQ9qdyonifa3Fmc3A3dlDn14
	 B87C8pmmLPsyw==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 594EB17E152A;
	Sat, 14 Nov 2026 19:04:35 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:48 +0200
Subject: [PATCH 24/25] drm/tests: bridge: Add HDMI 2.0 bridge connector
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
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-24-20e8a33a2286@collabora.com>
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

The bridge connector derives the HDMI connector scrambling capability
and max TMDS character rate from the HDMI bridge, and forwards the
scrambler callbacks to it.

Let the HDMI bridge init helper take the supported HDMI version and max
TMDS character rate, and add tests to make sure that:

- an HDMI 2.0 bridge results in a scrambling capable connector, limited
  to the HDMI 2.0 max TMDS character rate, whose scrambler callbacks are
  forwarded to the bridge
- an HDMI 1.4 bridge results in a connector without scrambling support,
  even when the bridge provides scrambler callbacks
- the bridge max TMDS character rate overrides the version-inferred one
- the connector creation fails for an HDMI 2.0 bridge missing any of the
  scrambler callbacks

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 185 +++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index a445f71c31b8..51212e33a1ae 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -30,6 +30,8 @@
 struct drm_bridge_priv {
 	unsigned int enable_count;
 	unsigned int disable_count;
+	unsigned int scrambler_enable_count;
+	unsigned int scrambler_disable_count;
 	struct drm_bridge bridge;
 	void *data;
 };
@@ -542,8 +544,10 @@ drm_test_bridge_chain_init(struct kunit *test, unsigned int num_bridges,
 }
 
 static struct drm_bridge_init_priv *
-drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *funcs,
-			  unsigned int supported_formats, int max_bpc)
+__drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *funcs,
+			    unsigned int supported_formats, int max_bpc,
+			    enum hdmi_version hdmi_ver,
+			    unsigned long long max_tmds_char_rate)
 {
 	struct drm_bridge_init_priv *priv;
 	struct drm_encoder *enc;
@@ -598,7 +602,8 @@ drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *fun
 	bridge->ops |= DRM_BRIDGE_OP_HDMI;
 	bridge->vendor = "LNX";
 	bridge->product = "KUnit";
-	bridge->supported_hdmi_ver = HDMI_VERSION_1_4;
+	bridge->supported_hdmi_ver = hdmi_ver;
+	bridge->max_tmds_char_rate = max_tmds_char_rate;
 
 	ret = drm_kunit_bridge_add(test, bridge);
 	if (ret)
@@ -619,6 +624,14 @@ drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *fun
 	return priv;
 }
 
+static struct drm_bridge_init_priv *
+drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *funcs,
+			  unsigned int supported_formats, int max_bpc)
+{
+	return __drm_test_bridge_hdmi_init(test, funcs, supported_formats,
+					   max_bpc, HDMI_VERSION_1_4, 0);
+}
+
 /*
  * Test that drm_bridge_get_current_state() returns the last committed
  * state for an atomic bridge.
@@ -1373,11 +1386,177 @@ static struct kunit_suite drm_bridge_bus_fmt_test_suite = {
 	.test_cases = drm_bridge_bus_fmt_tests,
 };
 
+static int drm_test_bridge_hdmi_scrambler_enable(struct drm_bridge *bridge)
+{
+	bridge_to_priv(bridge)->scrambler_enable_count++;
+
+	return 0;
+}
+
+static int drm_test_bridge_hdmi_scrambler_disable(struct drm_bridge *bridge)
+{
+	bridge_to_priv(bridge)->scrambler_disable_count++;
+
+	return 0;
+}
+
+#define DRM_TEST_BRIDGE_HDMI_SCRAMBLER_FUNCS(_enable, _disable)				\
+	{										\
+		.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,	\
+		.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,	\
+		.atomic_create_state	= drm_atomic_helper_bridge_create_state,	\
+		.hdmi_write_avi_infoframe	= dummy_write_infoframe,		\
+		.hdmi_write_hdmi_infoframe	= dummy_write_infoframe,		\
+		.hdmi_clear_avi_infoframe	= dummy_clear_infoframe,		\
+		.hdmi_clear_hdmi_infoframe	= dummy_clear_infoframe,		\
+		.hdmi_scrambler_enable		= (_enable),				\
+		.hdmi_scrambler_disable		= (_disable),				\
+	}
+
+static const struct drm_bridge_funcs drm_test_bridge_hdmi_scrambler_funcs =
+	DRM_TEST_BRIDGE_HDMI_SCRAMBLER_FUNCS(drm_test_bridge_hdmi_scrambler_enable,
+					     drm_test_bridge_hdmi_scrambler_disable);
+
+static const struct drm_bridge_funcs drm_test_bridge_hdmi_no_scrambler_enable_funcs =
+	DRM_TEST_BRIDGE_HDMI_SCRAMBLER_FUNCS(NULL,
+					     drm_test_bridge_hdmi_scrambler_disable);
+
+static const struct drm_bridge_funcs drm_test_bridge_hdmi_no_scrambler_disable_funcs =
+	DRM_TEST_BRIDGE_HDMI_SCRAMBLER_FUNCS(drm_test_bridge_hdmi_scrambler_enable,
+					     NULL);
+
+/*
+ * Test that the connector created for an HDMI 2.0 bridge reports the
+ * scrambling capability along with the HDMI 2.0 max TMDS character rate,
+ * and forwards the scrambler callbacks to the bridge.
+ */
+static void drm_test_bridge_connector_hdmi_scrambler(struct kunit *test)
+{
+	struct drm_bridge_init_priv *priv;
+	struct drm_connector *connector;
+	int ret;
+
+	priv = __drm_test_bridge_hdmi_init(test, &drm_test_bridge_hdmi_scrambler_funcs,
+					   BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444), 8,
+					   HDMI_VERSION_2_0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	connector = priv->connector;
+	KUNIT_EXPECT_TRUE(test, drm_connector_hdmi_scrambler_supported(connector));
+	KUNIT_EXPECT_EQ(test, connector->hdmi.max_tmds_char_rate,
+			HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ);
+
+	KUNIT_ASSERT_NOT_NULL(test, connector->hdmi.funcs->scrambler_enable);
+	ret = connector->hdmi.funcs->scrambler_enable(connector);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->test_bridge->scrambler_enable_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->test_bridge->scrambler_disable_count, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, connector->hdmi.funcs->scrambler_disable);
+	ret = connector->hdmi.funcs->scrambler_disable(connector);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->test_bridge->scrambler_enable_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->test_bridge->scrambler_disable_count, 1);
+}
+
+/*
+ * Test that the connector created for an HDMI 1.4 bridge doesn't report the
+ * scrambling capability and ignores the bridge scrambler callbacks.
+ */
+static void drm_test_bridge_connector_hdmi_no_scrambler(struct kunit *test)
+{
+	struct drm_bridge_init_priv *priv;
+	struct drm_connector *connector;
+
+	priv = __drm_test_bridge_hdmi_init(test, &drm_test_bridge_hdmi_scrambler_funcs,
+					   BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444), 8,
+					   HDMI_VERSION_1_4, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	connector = priv->connector;
+	KUNIT_EXPECT_FALSE(test, drm_connector_hdmi_scrambler_supported(connector));
+	KUNIT_EXPECT_EQ(test, connector->hdmi.max_tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_NULL(test, connector->hdmi.funcs->scrambler_enable);
+	KUNIT_EXPECT_NULL(test, connector->hdmi.funcs->scrambler_disable);
+}
+
+/*
+ * Test that the max TMDS character rate of an HDMI bridge overrides the
+ * one inferred from the supported HDMI version.
+ */
+static void drm_test_bridge_connector_hdmi_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_bridge_init_priv *priv;
+
+	priv = __drm_test_bridge_hdmi_init(test, &drm_test_bridge_hdmi_scrambler_funcs,
+					   BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444), 8,
+					   HDMI_VERSION_2_0,
+					   HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	KUNIT_EXPECT_EQ(test, priv->connector->hdmi.max_tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+}
+
+struct drm_bridge_connector_hdmi_missing_scrambler_test {
+	const char *desc;
+	const struct drm_bridge_funcs *funcs;
+};
+
+static const struct drm_bridge_connector_hdmi_missing_scrambler_test
+drm_bridge_connector_hdmi_missing_scrambler_params[] = {
+	{ "hdmi_scrambler_enable", &drm_test_bridge_hdmi_no_scrambler_enable_funcs },
+	{ "hdmi_scrambler_disable", &drm_test_bridge_hdmi_no_scrambler_disable_funcs },
+};
+
+static void
+drm_bridge_connector_hdmi_missing_scrambler_desc(const struct drm_bridge_connector_hdmi_missing_scrambler_test *t,
+						 char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_bridge_connector_hdmi_missing_scrambler,
+		  drm_bridge_connector_hdmi_missing_scrambler_params,
+		  drm_bridge_connector_hdmi_missing_scrambler_desc);
+
+/*
+ * Test that creating the connector for an HDMI 2.0 bridge fails when any of
+ * the bridge scrambler callbacks is missing.
+ */
+static void drm_test_bridge_connector_hdmi_missing_scrambler(struct kunit *test)
+{
+	const struct drm_bridge_connector_hdmi_missing_scrambler_test *params =
+		test->param_value;
+	struct drm_bridge_init_priv *priv;
+
+	priv = __drm_test_bridge_hdmi_init(test, params->funcs,
+					   BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444), 8,
+					   HDMI_VERSION_2_0, 0);
+	KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(priv), -EINVAL);
+}
+
+static struct kunit_case drm_bridge_connector_hdmi_tests[] = {
+	KUNIT_CASE(drm_test_bridge_connector_hdmi_scrambler),
+	KUNIT_CASE(drm_test_bridge_connector_hdmi_no_scrambler),
+	KUNIT_CASE(drm_test_bridge_connector_hdmi_max_tmds_char_rate),
+	KUNIT_CASE_PARAM(drm_test_bridge_connector_hdmi_missing_scrambler,
+			 drm_bridge_connector_hdmi_missing_scrambler_gen_params),
+	{ }
+};
+
+static struct kunit_suite drm_bridge_connector_hdmi_test_suite = {
+	.name = "drm_bridge_connector_hdmi",
+	.test_cases = drm_bridge_connector_hdmi_tests,
+};
+
 kunit_test_suites(
 	&drm_bridge_get_current_state_test_suite,
 	&drm_bridge_helper_reset_crtc_test_suite,
 	&drm_bridge_alloc_test_suite,
 	&drm_bridge_bus_fmt_test_suite,
+	&drm_bridge_connector_hdmi_test_suite,
 );
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");

-- 
2.56.0

