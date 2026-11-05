Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894040;
	b=R2oAV+J0DL3pVBIf2JPcXBWw/53f+ZxkQXYAg83S1kep8OPWyUU2boa6FXinuqbU5YsF
	 DVO3z6q8HYvJS/UT9l72WVKnZiLdoyrZc1X5nYXuYkDZ9R4tytMuG5BE5IGrzpjcHleF/
	 sXp6MYqcHwQHxyouo5sS9cDkhn80ijcsJLiHpMgXhBjc3SgFvLkV+O5legDg1SuFT+yik
	 y8Y7wG6lI42amyjQFOktz5J2zyWzJLfPKAnIp/WegfoKL0vxxZ7uV3gQoR4c/Rt45yF+N
	 8ut+hrqCkpOwwrtUmHXccvUimjapH+nGgzczgG7G+pOA54Y5QVuTG55n0xpP77qyPDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894040;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=fTzNDSolmw7K2SsCbbZU91nxSTB00KcD9PPh6CHzKVg=;
	b=A+zi03DJaEbHEYHp3Hw1h2KufE4566EiMIgv6k7CPck2wUHqf0XlawVVGAPPCklzYid/
	 hgt9x/x/5/G+6mnB+axefp23Yu+b0lVG1qlMUi4cEr+U4iddAeTE+YEooEXTcwLWZonwx
	 vVpNvbPG9/Gpo5sNX6nPMfrIynlVnIgfYPINcmaGVCHXDorbHiPljlu3SvZU/3hGK4PvT
	 1QiuEDkrRu43i1TIW8cWYpnSNnDBpNJb1JVb7dODp2F7Q7cwsp0BzJ+xIEpE/AcFiNOau
	 F8c1sPYSCTEXMCaSfir+sVZ6KRXCXOcs3MbHn1pC58q7rYdBZ75+HS3HQCZpGNtnu/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ki0h6WUl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409D606A609;
	Thu,  5 Nov 2026 15:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7409D606A609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ki0h6WUl
ARC-Seal: i=1; a=rsa-sha256; t=1793893984; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JlB8hVPPPDNcmszLLkIBvBwSag5xhD7SiapW3xecJ7C5W05AWfhRhnN/rRpzwhVVCakGdMNL9mDpTI0dH8NVErgqIeeydWHLkgQ2mtHkOr1kjzAh0p/zLiHKmxnBMUavcgUaroitAhy7icZOfObiJ/j3Q8Szh+KZhTzOS1eftto=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793893984; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fTzNDSolmw7K2SsCbbZU91nxSTB00KcD9PPh6CHzKVg=; 
	b=AYE3sbP2IplCW1BDlq6pjMXAlYtgXCiRV6i3jszZ/L54iL0l3YB+J4lZNS0AQZ0vyRHJBPArbgUws1KJN+PbGC34AoEo7XbFuGTJuH7SwlKGy5WaveL5RHtUB93dKsAzYZXVBBGHinRAoLsdHJQkWVUzAtQyNm13L2TD+uz/R/Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Ki0h6WUlKLThrkF3KvCnaUd93eXjEjo+StMaGQ/y4aU5zjWNlImVOU+lBV0DDWrpZsy/eUlxAQ/hZX9Pf8aq5CiUS1uW0ZaS8Tai+mkkMXa/rI/6Ar37nMHwxIRw1evj09RZf0iFwtzv9yuv8VQh//vi39UnH6DmTuD3dRhz95I=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=fTzNDSolmw7K2SsCbbZU91nxSTB00KcD9PPh6CHzKVg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793893983774815.9743865612031;
	Thu, 5 Nov 2026 07:53:03 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:51:56 +0100
Subject: [PATCH v2 05/27] drm/connector: hdmi: Add VTEM EMP generation
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
Message-Id: <20261105-vrr-limiter-uapi-v2-5-55f4215be2c2@collabora.com>
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

From: Derek Foreman <derek.foreman@collabora.com>

Add VTEM EMP generation to enable variable refresh rate signalling over
HDMI.

These infoframes are only generated if the sink supports VRR.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 63 +++++++++++++++++++++++++
 include/drm/drm_connector.h                     |  5 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index eb6abfd1350d..ce680eaa5047 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -853,6 +853,61 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
 	return 0;
 }
 
+static int hdmi_generate_emp_infoframe_vtem(const struct drm_connector *connector,
+					    struct drm_connector_state *conn_state)
+{
+	const struct drm_display_info *info = &connector->display_info;
+	const struct drm_crtc_state *crtc_state =
+		drm_atomic_get_crtc_state(conn_state->state, conn_state->crtc);
+	struct drm_connector_hdmi_infoframe *infoframe =
+		&conn_state->hdmi.infoframes.vtem;
+	struct hdmi_emp_infoframe_vtem *vtem =
+		&infoframe->data.vtem;
+	const struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
+	int vfront;
+	u8 avi_vic;
+
+	infoframe->set = false;
+
+	if (!connector->hdmi.funcs->vtem.write_infoframe)
+		return 0;
+
+	if (!info->hdmi.vrr_cap.supported)
+		return 0;
+
+	if (conn_state->hdmi.infoframes.avi.set)
+		avi_vic = conn_state->hdmi.infoframes.avi.data.avi.video_code;
+	else
+		avi_vic = 0;
+
+	hdmi_emp_infoframe_vtem_init(vtem);
+
+	switch (conn_state->vrr_display_mode) {
+	case VRR_DISPLAY_MODE_GAME:
+		vtem->game_vrr_en = true;
+		vtem->m_const = !vrr->dynamic;
+		break;
+	case VRR_DISPLAY_MODE_OFF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (vtem->game_vrr_en && !avi_vic) {
+		vtem->base_refresh_rate = drm_mode_vrefresh(&crtc_state->mode);
+		vfront = crtc_state->adjusted_mode.crtc_vsync_start -
+			 crtc_state->adjusted_mode.crtc_vdisplay;
+		if (vfront > U8_MAX || vfront < 0)
+			return -EINVAL;
+
+		vtem->base_vfront = vfront;
+	}
+
+	infoframe->set = true;
+
+	return 0;
+}
+
 static int
 hdmi_generate_infoframes(const struct drm_connector *connector,
 			 struct drm_connector_state *conn_state)
@@ -884,6 +939,10 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
 	if (ret)
 		return ret;
 
+	ret = hdmi_generate_emp_infoframe_vtem(connector, conn_state);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1475,6 +1534,10 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
 			goto out;
 	}
 
+	ret = write_or_clear_infoframe(connector, &funcs->vtem, "VTEM",
+				       &old_conn_state->hdmi.infoframes.vtem,
+				       &new_conn_state->hdmi.infoframes.vtem);
+
 out:
 	mutex_unlock(&connector->hdmi.infoframes.lock);
 	return ret;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 184b10c89508..9df745ecff92 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1186,6 +1186,11 @@ struct drm_connector_hdmi_state {
 		 * matching our state.
 		 */
 		struct drm_connector_hdmi_infoframe hdmi;
+
+		/**
+		 * @vtem: VTEM EMP infoframes structure matching our state.
+		 */
+		struct drm_connector_hdmi_infoframe vtem;
 	} infoframes;
 
 	/**

-- 
2.56.0

