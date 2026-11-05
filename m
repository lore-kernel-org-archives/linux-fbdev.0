Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894172;
	b=ZhtEKfCVnVtSAoqyBDd4Xs4b5AuwPkzZCSSsaozhX2EHvXx0rGZErN7R0XU7BWjxpLOz
	 0NT4u2a278LwYkEk6OZacXh2xL5TiitN+dARmMy8dplZhrexp8FWXvOg1R3Uw2v1z2iBb
	 maiEKQeL1C3X6j9svMsNqD+tSslmuz849QtZuMUrsMD+BxF/IjJsqo+djlJsEb0vceorT
	 fMaXLD6cPAhnQ+tjokcNj9AB1GkNjrhr8x8DrMA8/iTLISk/oUu10SFYk7F9NKJAmvJTj
	 CcXO/aNirH3NNTqAx0ponVZ45uQicgtPWxpQE6G696O/HsHgA/xlHQEGKMnQw5rq2OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894172;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=ALE444eKJZ+NX+Ip1B2o36NSUHXVU+Yd9yBPLWJk7WU=;
	b=kJ3XpPrHZmzieWhVMspgv2pgb2g1i5oZcAEPzXAP0KKjW/vGl9EfmpkZlQ9BkiAgystj
	 VM4nCqvS6bM56XHQ+IDCcl1tvrDW++OolF5CK8g1UW6rscMVhPMVWVtxVMd1cFOmBAMjA
	 BptkBiXPY7+K6Myv8LxAtqakKrbp250+H7i2YZ120+E2GpsO9yo+u378rwc4Pa50ff3rV
	 ZeQzkytKcB3oigBp3pDdslG4YqCNW2sGGNZfFCBjDa4J+Ln9DgLT0FPfjfyStzZkUF3X4
	 Zx0N43q4LH7pdOvSbUuySOVmuUa1JHIOR9n9pYjaixHt66yLpNpF5nSJJ5/Ujps1OUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=jL3Toeob;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A50606E570;
	Thu,  5 Nov 2026 15:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A50606E570
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=jL3Toeob
ARC-Seal: i=1; a=rsa-sha256; t=1793894073; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UBHvNICVd78MZ6AQL7EaAQSAk4/QV+rrP+NDDw5BFBZGjugMyhHF8bIAVEjbxaRJa8MypfDeZ+9Qt6+Ea20kmnpOHLTyRVtEziuM3o/AmrcRpQ1vkAL1dEjinsaM99Mm+3i5GvItASR+Wryf3AKMrP+GmZAU4ilCRvmMa1Dmo0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894073; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ALE444eKJZ+NX+Ip1B2o36NSUHXVU+Yd9yBPLWJk7WU=; 
	b=m8LtUlS68e9J4UbfJaDI8uofn+9lj5qCfKVnFbqvQuIO9X6+8b1/S+BvK1ErG9WOwdqJGhL/HTTMk0YA899SalmTBZcGDBSzVDFDKbZEKK+Zhm/DpAaQ6p9bF9UHgDKEKz+G7Jhj2SkXF0pLoi9JvJrzcJUMtNtQTT1g23ITeBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=jL3ToeobaRmx6PiWKWksYL9GAG8+dc/g18VBNaDTzeHB3fKNgI03n+V6dTy+A/TrUGM87yI+kfK4msGryNel9z6M03imJmWGdGi8NW6lBJ+qDXqmUfIV6i8sI+19tfrekWI6oiD8ZiCUBAkWp5MGwRZAvU0FXcGoQisQluRH47Y=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ALE444eKJZ+NX+Ip1B2o36NSUHXVU+Yd9yBPLWJk7WU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894072590379.33672551637096;
	Thu, 5 Nov 2026 07:54:32 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:10 +0100
Subject: [PATCH v2 19/27] drm/connector: hdmi: Add QMS to VTEM EMP
 generation
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
Message-Id: <20261105-vrr-limiter-uapi-v2-19-55f4215be2c2@collabora.com>
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

If userspace indicates that VRR mode "Media" is desired and the
connector supports QMS, set the QMS related fields in the VTEM EMP
struct based on the connector state.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 846f7a72fddc..407ad28c649f 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -890,11 +890,18 @@ static int hdmi_generate_emp_infoframe_vtem(const struct drm_connector *connecto
 		break;
 	case VRR_DISPLAY_MODE_OFF:
 		break;
+	case VRR_DISPLAY_MODE_MEDIA:
+		if (!connector->hdmi.qms_supported)
+			return -EOPNOTSUPP;
+		vtem->qms_en = true;
+		vtem->next_tfr = conn_state->hdmi.qms_tfr_byte;
+		vtem->m_const = !vrr->dynamic;
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (vtem->game_vrr_en && !avi_vic) {
+	if ((vtem->game_vrr_en || vtem->qms_en) && !avi_vic) {
 		vtem->base_refresh_rate = drm_mode_vrefresh(&crtc_state->mode);
 		vfront = crtc_state->adjusted_mode.crtc_vsync_start -
 			 crtc_state->adjusted_mode.crtc_vdisplay;

-- 
2.56.0

