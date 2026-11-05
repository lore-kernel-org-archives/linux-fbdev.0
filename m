Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894200;
	b=FF2kTIz41trLfdqCs0piumBioDTXsyxwS4ZscKXBJeZ61C5IXCqk/tPmXPK8Kuxm2BFB
	 sVhKmwC+rFYvGyrhFS+2RfMFl1Kxh6+420wz4R1h4RtX6zBrwH5HTTed8Hm/SjYIFcFJn
	 /IXJ4a5nTUxSdwt2EGyH7gLem5WTQ15UReuks94RVb7dOPI450OcJoUxm7FC3RK6PVw4W
	 /NJv/NF2yUMx5yd9ZwCqCzaKiwyqvf3/YaC88Nm9CMh0n833ertWZ9XzyTcYfQY0Uq8Cl
	 mD1NRL5Fjv5dc3aajhWnERwf8FU/vixg08BPqXzlMwcw2ogUZdxd7YRcqME45uq2RMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894200;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=k7aC2DLgVXmwj4L3M+AhqzHnHGRutw5CQW3KARyJJWU=;
	b=ywb9UvNfqW5/CHXqcFPvfG+uZ/Cr5ZOgE3Ux0nw2yBpJLu0vyxKiquSXM6dNiu3I6wQH
	 iM1Wx/MxppHt5OpylBnvY57a6usN6o5Ld+G/nTFyqR9JfXxVSUBEnc1U3e7lUhgyARcsO
	 ZA6cwKZyd1HC3qxOU10K7sCRLaWX2/1oucEGFOP+aRJfouvvtm4GeGKOG9tb9w/CSadYY
	 rkA7ls2TzbrTCn9+E5wuc4wgG4aQGPadWt0Qbtu89AfqrXfyfC3ZoyDp2NyZvOrjqTr6u
	 EySHfprGR5ygVJa2zTYCC475Le7jQWmYPS2F005zb0nzrTfH9vZ0BSqVkb2L7+s/w0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ineubcq6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E1606A32F;
	Thu,  5 Nov 2026 15:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 535E1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ineubcq6
ARC-Seal: i=1; a=rsa-sha256; t=1793894123; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kf31MRyW7L2Pc0Iz8CugK41cjnyU0E89zIQ+WlO9Oa1C7EZRse5PbPQ88k+Cy/JPKnbqXmQg4j5a/LjK8uefsxvC7aJTKdJWe/Pi/ajPOvqxnA0L9TprHWqETXCl1ySAHbsmYhQ6+obzS92Nhfy3GPxzsa2lVrO7X+v/Oy9dgx0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894123; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k7aC2DLgVXmwj4L3M+AhqzHnHGRutw5CQW3KARyJJWU=; 
	b=G3PzGlG9ZPmGF5eBq1ebh0BfE4fZYnLUKtOpHbSlAUotV4Mqi6BNjvwx3SY5/TrP4xXO60+TEjlLn7uD4uLRQJx9vyfKI3QAZFhs8FrcXjABegXzadAAEKU/MzdBSknvDk7ahS40rvxfNDZAJcip//9QE3RFxALcqK+645VoPCk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Ineubcq6VUldGDdkiT/4zgSGvl8XJCNmxs9BP2ovDs9ZJdfwpK0/K7zdS2oZxb+zXednXJXkwL7+0dwA5guXeT1cjrLSRnL2fO5Z//bjhsFNlLqmUaTzkP4beR/oKrfAXIAB8SSwSm+jMnlKP7PU1LijaQRjw5Mq/h6gkG724nw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=k7aC2DLgVXmwj4L3M+AhqzHnHGRutw5CQW3KARyJJWU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17938941227261011.6961433029587;
	Thu, 5 Nov 2026 07:55:22 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:18 +0100
Subject: [PATCH v2 27/27] drm/tests: hdmi: Add tests for
 vrr_display_{min,max} properties
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
Message-Id: <20261105-vrr-limiter-uapi-v2-27-55f4215be2c2@collabora.com>
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

Attach the vrr_display_min and vrr_display_max properties to the KUnit
HDMI state helper test connector, and add two simple tests to verify the
introduced drm_connector_hdmi_update_vrr_limits() helper sets the
properties right depending on EDID.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 4c7e563ca51d..7bd06b65d241 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -308,6 +308,9 @@ __connector_hdmi_init(struct kunit *test,
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	conn->hdmi.qms_supported = true;
 
+	ret = drm_connector_attach_vrr_display_limits_properties(conn);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	drm_mode_config_reset(drm);
 
 	if (edid_data && edid_len) {
@@ -3676,6 +3679,88 @@ static void drm_test_check_hdmi_vrr_flush_vsync(struct kunit *test)
 			crtc_state->vrr_state.max_vtotal);
 }
 
+/*
+ * Check that on a VRR-capable sink, the HDMI VRR limits helper sets the
+ * display_min/display_max connector properties to the right values.
+ */
+static void drm_test_check_hdmi_vrr_display_limits(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	u64 disp_min, disp_max;
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
+	ret = drm_connector_hdmi_update_vrr_limits(conn, preferred);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_min_property,
+					    &disp_min);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_max_property,
+					    &disp_max);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, disp_min, 30);
+	KUNIT_EXPECT_EQ(test, disp_max, 120);
+}
+
+/*
+ * Check that on a non-VRR-capable sink, the HDMI VRR limits helper sets the
+ * display_min/display_max connector properties to 0.
+ */
+static void drm_test_check_hdmi_vrr_display_limits_zero(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	u64 disp_min, disp_max;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_FALSE(test, conn->display_info.hdmi.vrr_cap.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	ret = drm_connector_hdmi_update_vrr_limits(conn, preferred);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_min_property,
+					    &disp_min);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_max_property,
+					    &disp_max);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, disp_min, 0);
+	KUNIT_EXPECT_EQ(test, disp_max, 0);
+}
+
 /*
  * Check that on a VRR-capable sink with VRR enabled and a fixed target rate
  * set, an atomic commit works, and the derived vtotals are as expected.
@@ -4622,6 +4707,8 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_vrr_tests[] = {
 	KUNIT_CASE(drm_test_check_hdmi_vrr),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_sink_fail),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_flush_vsync),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_display_limits),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_display_limits_zero),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate_flush_vsync),
 	KUNIT_CASE_PARAM(drm_test_check_hdmi_vrr_target_rate_fail,

-- 
2.56.0

