Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598460;
	b=xjSR338NbC05D0a6x+9cz/PBQQYuDjiniCEyFXhwKYJ0EBUTBFTn6PZZiKnLN5gFALWS
	 dLZcLln0xum2pjZSpgIVfb5YkMUtd3OIm1Y/T7jzPx1/gpA1Rz5vn4591V8RF1YHelDt2
	 9jo0P9lMGZ9alzaxjGGphCsBWbSISmnkDb4mzOthjO43BjUUAh5Dm+0w3E6E5sHm7EntB
	 ZPqAi2Vui1XPr49duvTCXgLAdAWZvx5BOMyEJB9Ptf5G66aojxd/9wSlnSA9d+bhRtZPE
	 20nHZ8Xb9G3MIdxiQLCR2urlyS7nNo3/EAKg0ULIqt/EGvZDXe58406ivOxlt0mU45Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598460;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=yaNg0A4qZyJmLSbHE3kEHVsrAEPsGCCK5VNcyYGHU9c=;
	b=IjN1G+WiGxZ613vOHhD4TvLclWz/M+ch4GDp2fVJgHbMQiwgZvkCd7CEGbcul1wLfFw6
	 qWVyw1bUQTVfNBKgYM/xrHkfyqpAV8hKujiwsW8RNBSZE9Z/gteDiUufb3L1Bknk9MXOi
	 JfGZJSF7t0XKVjrrV+zqTTrmXqYsvP4SORsWnSGJLSfwxuTB4xLe4FesXTtcKdUgPN9sy
	 P/NnG7YoUZe0nE9bmQUnyY/2LU0zHBl7W1yK8iA1kdnvocAyJ5/ON6ZcxGgw6YUuHlqnf
	 WJWtxibJot8QmCNIrZbefZ+YWAmCyrt0zcyg+22tkWpowktYmqowYH/BxmNYrhUmp/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cC9HmsG+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9608606A32D;
	Fri, 13 Nov 2026 19:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9608606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cC9HmsG+
ARC-Seal: i=1; a=rsa-sha256; t=1794598387; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YHAIiaFipjPi82NCsEtPDvtmUSu4qoez7H+T7u+7MD7NH+PODbSCUEWk1yksDR9zfGzxtUIlW1ht8iMdxc7iaRg4kY772kEXE2JuUf+DXZxfSPUoJmTTXogBm6IVvVWeuEocbPfbRbpbYDMfr8S9SeWCG5BLLdy5EUCZ7rYw58U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794598387; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yaNg0A4qZyJmLSbHE3kEHVsrAEPsGCCK5VNcyYGHU9c=; 
	b=Vuy/PJriChFIc2JkznTBF37ZEI8/BIQd6ch2eBcB5F4NwXj9X90t4V3YMq2JUKxG/Y5tZctAoKutyRErZOjpfHVAwn7njbwakn0D2WPavAJFrpm3ArBdB+60wGJknSooQMpwtsTNegXW9R09rPM8GImAgpvWpxoz7ci559mSKJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=cC9HmsG+wxnrtwY1/kmwkPERwTZiUiNrcOpQuzsNvzX3qCDA63tPxpNDYivzALUxtwniSDPH5KT/SDPwh0jjjA6UIQ4ThFnJhcbzGFOaZZi9SPmxu6Y9zm1x3JhEVfOnDKauit/F6a8wdbqQyNmhfI/I0bH2xFOEHhweXPyUb/E=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=yaNg0A4qZyJmLSbHE3kEHVsrAEPsGCCK5VNcyYGHU9c=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794598386584198.56420054419993;
	Fri, 13 Nov 2026 11:33:06 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>,
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
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject:
 Re: [PATCH v2 17/27] drm/connector: Add "Media" VRR display mode for QMS
Date: Fri, 13 Nov 2026 20:32:57 +0100
Message-ID: <J8t71gP7QKWKTygTYwJB2Q@collabora.com>
In-Reply-To: <3e4c8552-5dc0-f189-dee8-2ca0ebe01629@nvidia.com>
References:
 <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-17-55f4215be2c2@collabora.com>
 <3e4c8552-5dc0-f189-dee8-2ca0ebe01629@nvidia.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 12 November 2026 07:18:21 Central European Standard Time Vidith Madhu wrote:
> 
> On Thu, 5 Nov 2026, Nicolas Frattaroli wrote:
> 
> > HDMI includes a feature called "Quick Media Switching", or QMS for
> > short, which builds upon the existing VRR to allow for quick switching
> > between a select few common frame rates.
> > 
> > Add a new VRR display mode, "VRR_DISPLAY_MODE_MEDIA", to the
> > vrr_display_mode connector property, in order to expose support for
> > this.
> > 
> > Additionally, add a boolean flag to the connector's HDMI sub-struct with
> > which source-side support for QMS can be indicated, as well as the QMS
> > tfr byte to the HDMI state sub-struct.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_connector.c |  6 ++++++
> >  include/drm/drm_connector.h     | 14 ++++++++++++++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index 21222214a843..f7d619926e2d 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -1456,6 +1456,7 @@ DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
> >  static const struct drm_prop_enum_list drm_vrr_mode_enum_list[] = {
> >  	{ VRR_DISPLAY_MODE_GAME,   "Game" },
> >  	{ VRR_DISPLAY_MODE_OFF,    "Off" },
> > +	{ VRR_DISPLAY_MODE_MEDIA,  "Media" },
> >  };
> >  DRM_ENUM_NAME_FN(drm_get_vrr_mode_name, drm_vrr_mode_enum_list)
> >  
> > @@ -2593,6 +2594,11 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
> >   *	    - Game - set display to game mode if display supports it,
> >   *	      regardless of CRTC state
> >   *	    - Off - set display to VRR disabled mode, regardless of CRTC state
> > + *	    - Media - a "media" VRR mode that only supports a select number of
> > + *	      common media refresh rates as fixed targets, but does so with
> > + *	      possibly better display-side processing. In the HDMI display
> > + *	      protocol, this is QMS (Quick Media Switching), though the mode
> > + *	      enum itself is vendor-agnostic
> >   *
> >   * VRR Limiter/Target Properties
> >   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index 4801bb2769e1..41f272afbb1e 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -829,6 +829,8 @@ enum vrr_display_mode {
> >  	VRR_DISPLAY_MODE_GAME = 0,
> >  	/** @VRR_DISPLAY_MODE_OFF: Turn off VRR on the display */
> >  	VRR_DISPLAY_MODE_OFF,
> > +	/** @VRR_DISPLAY_MODE_MEDIA: Protocol-agnostic fixed rate media mode */
> > +	VRR_DISPLAY_MODE_MEDIA,
> >  	/** @VRR_DISPLAY_MODE_COUNT: Sentinel, not a valid mode, keep last */
> >  	VRR_DISPLAY_MODE_COUNT
> >  };
> > @@ -1241,6 +1243,12 @@ struct drm_connector_hdmi_state {
> >  	 * deliberately not requested by the helper.
> >  	 */
> >  	bool scrambler_needed;
> > +
> > +	/**
> > +	 * @qms_tfr_byte: Target frame rate byte for HDMI QMS, or 0 if QMS is
> > +	 * not in use.
> > +	 */
> > +	u8 qms_tfr_byte;
> >  };
> >  
> >  /**
> > @@ -2270,6 +2278,12 @@ struct drm_connector_hdmi {
> >  	 */
> >  	bool scrambler_enabled;
> >  
> > +	/**
> > +	 * @qms_supported: Whether the connector supports HDMI Quick Media
> > +	 * Switching (QMS) on the source side, irrespective of display support.
> > +	 */
> > +	bool qms_supported;
> I'm not really understanding why a source-side capability is being 
> captured at the connector level. The way I envisioned this is that
> source-side Media-VRR support can be determined by whether the driver
> attaches the CRTC frame limit properties. The ability to maintain an
> arbitrary fixed refresh rate (implied by attaching the properties) should
> be the only QMS-specific requirement the source needs to support.

Is this the case? I have little information about the QMS specification
or the hardware implementations, so I was basically hedging for an odd
case where an HDMI implementation is abstracted enough to where we can
get it to send VTEM EMP packets through some interface, but not with
QMS TFR bytes.

If that's something so far out there it probably won't ever exist, I'm
happy to remove this and make QMS checks just a check for the limiter
properties.

Kind regards,
Nicolas Frattaroli

> 
> Thanks,
> Vidith 
> > +
> >  	/**
> >  	 * @scdc_work: Work item currently used to monitor sink-side scrambling
> >  	 * status and retry setup if the sink resets it.
> > 
> 




