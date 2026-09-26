Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71902EC0A4;
	Sat, 26 Sep 2026 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790420683; cv=pass; b=AToINDLeNBBPO+GTCZPZM3Kk9emYonccKjiV0D6iknhhBCKqXOEiyqt68OWQexYNXlOfvcGYTSPhkT1fDP00/VEj2cYpKTPzWocwZcP6FpchH7f4d9PtKxAAH6RIPvqcDH+1FFXb+KmETyooJ3n7pzhwL4HjHf4Q3Sp/7YHO0mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790420683; c=relaxed/simple;
	bh=FVTLEGLnSPHYozQMXZgufN+EgBxhrrYGVesl1fqJjOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQJBbtBp3/1I+g1EQwyg11fdXCdZp+N3omTqxqevrwbd3zZPDHXVQ3aIPxsZP8uQxp8SiU04yZBmP7RFS03WvYjABYwqFjK/KvIykVGOubRH2UiX1Ign2WrF/SLH2Bp0vyys7z7u0XUQRZ9EEPTPMLCoYENAABysRMxc57QazgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=de3Qat5D; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="de3Qat5D"
ARC-Seal: i=1; a=rsa-sha256; t=1790420616; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J+d73KLeGearmnB+EsTVJtGDCcSURFACrgEwh5Gb7M21chj2jV1Iiit5g2XuHpnZOgApomGnOFshy2+ZE30TYmi6nLvX7XWaX3ZQ0NJbncOpDrpapmGFi2JDH4aar3UCF6ltRb51TYA3VIhMcspdRiaMrqpDZxado9d02/xh/JI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790420616; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rjuEah86VS9smQcbw1BPf2x1MuqJ0in2mIL+HloaBaM=; 
	b=OsZKRAMkF8q9LsPcTuoqp84kacZgiIo6b+GtRP0r9W02fJtB+IdlVaEptr8d2jnOGWX4MJlaY71EqZAPEL5e3kGCysQa8cnPXjb7P0ohs7tXOGQlJrSM9eVbm+ROS9y06UMDSypBdEj6EGQtP5fotEzox+qOcsnX7OlEIregMpY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790420616;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=rjuEah86VS9smQcbw1BPf2x1MuqJ0in2mIL+HloaBaM=;
	b=de3Qat5DuIdjZb7RKGMxcOSJibnNV+AOyda+7rjD/9kRdWeCv7eaCxRumnTNw0yg
	2GK8KFKG72pJhpMyjbDG6PYCUF7AxmkDaBzBmMxAdLJMCyTH44V0un6ZpbVSV3AYipJ
	+U6jHbOPfKhZYVu42mAeHC4//ujgMDLEI+MuFvhk=
Received: by smtp.zohomail.com with SMTPS id 1790420615376767.1283057968208;
	Sat, 26 Sep 2026 04:03:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
Date: Sat, 26 Sep 2026 13:03:27 +0200
Message-ID: <FJ8OpdCORV2b1oivG9-G9Q@collabora.com>
In-Reply-To: <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
References:
 <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
 <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 25 September 2026 05:48:54 Central European Summer Time Vidith Madhu wrote:
> 
> On Mon, 21 Sep 2026, Nicolas Frattaroli wrote:
> 
> > From: Derek Foreman <derek.foreman@collabora.com>
> > 
> > Add VTEM EMP generation to enable variable refresh rate signalling over
> > HDMI.
> > 
> > These infoframes are only generated if the sink supports VRR.
> > 
> > Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 60 +++++++++++++++++++++++++
> >  include/drm/drm_connector.h                     |  5 +++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > index d55548399687..33d0c9491643 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > @@ -853,6 +853,56 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
> >  	return 0;
> >  }
> >  
> > +static int hdmi_generate_emp_infoframe_vtem(const struct drm_connector *connector,
> > +					    struct drm_connector_state *conn_state)
> > +{
> > +	const struct drm_display_info *info = &connector->display_info;
> > +	const struct drm_crtc_state *crtc_state =
> > +		drm_atomic_get_crtc_state(conn_state->state, conn_state->crtc);
> > +	struct drm_connector_hdmi_infoframe *infoframe =
> > +		&conn_state->hdmi.infoframes.vtem;
> > +	struct hdmi_emp_infoframe_vtem *vtem =
> > +		&infoframe->data.vtem;
> > +	const struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
> > +	int vfront;
> > +
> > +	infoframe->set = false;
> > +
> > +	if (!connector->hdmi.funcs->vtem.write_infoframe)
> > +		return 0;
> > +
> > +	if (!info->hdmi.vrr_capable)
> > +		return 0;
> > +
> > +	hdmi_emp_infoframe_vtem_init(vtem);
> > +	if (!crtc_state->vrr_enabled || vrr->vic) {
> > +		vtem->base_refresh_rate = 0;
> > +		vtem->base_vfront = 0;
> It shouldn't hurt to always populate base_refresh_rate and base_vfront, 
> might be cleaner to skip this check.

Hm, I thought they had to be blank when the vic was non-zero. If that's more
of a "they can be blank" then yeah I'm fine with skipping it. But that makes
me question the purpose of vrr->vic, which is then no longer needed as it's
not used anywhere else.

> > +	} else {
> > +		vtem->base_refresh_rate = drm_mode_vrefresh(&crtc_state->mode);
> > +		vfront = crtc_state->adjusted_mode.crtc_vsync_start -
> > +			 crtc_state->adjusted_mode.crtc_vdisplay;
> > +		if (vfront > U8_MAX || vfront < 0)
> > +			return -EINVAL;
> > +
> > +		vtem->base_vfront = vfront;
> > +	}
> > +	vtem->fva_factor_m1 = 0;
> > +	infoframe->set = true;
> > +
> > +	if (!crtc_state->vrr_enabled) {
> I don't think we should use the vrr_enabled CRTC property to determine 
> VRR_EN in the VTEM EMP. Transitioning the VRR mode sink-side typically causes
> blanking, and it was discussed in patch [03/25] that drivers should be 
> free to handle vrr_enabled changes as a seamless switch since it only 
> concerns source-side VRR state (this is how the NVIDIA driver handles it).

I'll be honest, this is the first time I've thought about the VRR state
communicated from userspace to kernel to be different to the VRR state
communicated from kernel to display.

> Maybe it would make sense to extend the qms_enabled connector property 
> introduced in this patchset to an enum of {Off, Gaming, QMS}? This would allow
> a standard path to control the VRR state on the sink, separately from
> vrr_enabled.

An earlier version of the patch series I was working on internally had a
VRR limiter property that would either be Off (i.e. Game), Game-Limited,
QMS-Limited, and it self-inflicted some amount of confusion because of
the way things were named, so I refactored it to the limiter values being
what determines whether a limiter is used, and the QMS enable to determine
whether QMS is used to apply said limit. So my initial reaction is to be
hesitant about expanding the collection of possible states exposed through
the uAPI.

To help my understanding: what does

 vrr_enabled=true
 $new_property=Off

mean for presentation? Another state I'm curious about is

 vrr_enabled=false
 $new_property=Game

which I assume is the case you're interested in, where the compositor does
not want VRR presentation but we're keeping the sink in Game mode to avoid
having the display go blank.

is that correct, and something that does need an expanded property? I feel
like userspace could be smart enough to do that by keeping vrr_enabled=true
and then setting a fixed target, if the goal is to have non-VRR but with the
display still in VRR mode.

Kind regards,
Nicolas Frattaroli

> > +		vtem->m_const = false;
> > +		vtem->game_vrr_en = false;
> > +		return 0;
> > +	}
> > +
> > +	vtem->game_vrr_en = true;
> > +
> > +	vtem->m_const = !vrr->dynamic;
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  hdmi_generate_infoframes(const struct drm_connector *connector,
> >  			 struct drm_connector_state *conn_state)
> > @@ -884,6 +934,10 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = hdmi_generate_emp_infoframe_vtem(connector, conn_state);
> > +	if (ret)
> > +		return ret;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1494,6 +1548,12 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
> >  			goto out;
> >  	}
> >  
> > +	if (info->hdmi.vrr_capable)
> > +		ret = write_or_clear_infoframe(connector,
> > +					&funcs->vtem, "VTEM",
> > +					&old_conn_state->hdmi.infoframes.vtem,
> > +					&new_conn_state->hdmi.infoframes.vtem);
> > +
> >  out:
> >  	mutex_unlock(&connector->hdmi.infoframes.lock);
> >  	return ret;
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index e561a444515f..6e431eb81705 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -1180,6 +1180,11 @@ struct drm_connector_hdmi_state {
> >  		 * matching our state.
> >  		 */
> >  		struct drm_connector_hdmi_infoframe hdmi;
> > +
> > +		/**
> > +		 * @vtem: VTEM EMP infoframes structure matching our state.
> > +		 */
> > +		struct drm_connector_hdmi_infoframe vtem;
> >  	} infoframes;
> >  
> >  	/**
> > 
> 




