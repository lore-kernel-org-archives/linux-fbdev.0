Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3255218A1;
	Tue, 29 Sep 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706352; cv=pass; b=bKWV4iemzLXQokh1S1YvuYwSdLLQG9ciuyjwrEomEbhISKDb2Tdz82LRXOZxRwI06wQh3njI2jDMmSJLcUeIYCo/bXKII/AJVSYf3boS46pAKkO0pxhHuPAGXdP+RLFTy8KLSDfe3Rk/XYswceyWu1FcIFzoBRg4kl9dSps9Wzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706352; c=relaxed/simple;
	bh=sBpNZ5PMZG4rZxUgKXk5XvsjcaqrX/H0Cl+khX8aGgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCgFxpz69GpRH9mYX7nn1YRmVfGhMozkNNVwbHVNz5aAiEiKg55bsxJ8Mp7bEmCA4PRP93LpmRVLsQNuBKYpU/9c1/eFHcMS8o3Bd4JRrbdYBfeCRwMAH/gCyJXQFQ0CLlv/Ke+u5yq0ZUPS7Swzclbsx3yppcNGTo57DgTWZtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=H27+me2Y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="H27+me2Y"
ARC-Seal: i=1; a=rsa-sha256; t=1790706296; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nMxPc38Cl9VS2QoZmUhA2drxBC6wmqcEChJ91L7sAXyZISXwRC6zMm24wq/SE0NLgZuVOoZPXRDd/Q51Fpsoexc1L8lqSWHIXmMEbSZFCB7KtHKS615RNpVKU0h9/toChgOD54Wya17lznelDDsOhDdLQk0YJ6BrmhlPtfTKu6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790706296; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=thGR81HMiGTJKquWx1al1feKzMrOj7hpr91FOagyffw=; 
	b=kf9KMfWRuYNJkRQ1+xtMr86HPpJsIbEGB6HiRHiao9nORMi1N0lBYVV5eulEC7EJXMt0lbFZyhC71ZVnKch1L2z7dCNljR+QxWJTZUeiAYcRMZmLt7GqaBxplCTm/vaaJdk/W6q0o+JFGdyj3OUnKmkWg2n0dmCddZFM3/F0iEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790706296;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=thGR81HMiGTJKquWx1al1feKzMrOj7hpr91FOagyffw=;
	b=H27+me2Y6bGa1EIDyLXPtpPoy6B13kvLba8Gre5goQsXgpdbIw/N/O0cOM1P57dy
	E020DeY0glJJjJRplFtYzMz7/Iz7Z10H/lvfEVo4EKbFtqmROPkFbtDMB9Awp1HLTdq
	nGIX1ONF2RV4df0tLVi9lDBroHRF2lcwa/8gL4p0=
Received: by smtp.zohomail.com with SMTPS id 1790706296001546.8130167598731;
	Tue, 29 Sep 2026 11:24:56 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 Leo Li <sunpeng.li@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
Date: Tue, 29 Sep 2026 20:24:49 +0200
Message-ID: <tvRw82ZVR2-oL-HXZ6n6bQ@collabora.com>
In-Reply-To: <SwRul6_8Tc-C-2oBT64DOg@collabora.com>
References:
 <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <164d00c2-e4cb-4962-8e4e-389ae77af943@amd.com>
 <SwRul6_8Tc-C-2oBT64DOg@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 29 September 2026 20:14:34 Central European Summer Time Nicolas=
 Frattaroli wrote:
> On Tuesday, 29 September 2026 16:34:58 Central European Summer Time Leo L=
i wrote:
> >=20
> > On 2026-09-28 04:10, Michel D=C3=A4nzer wrote:
> > >>> You can picture VRR limiting as always being active, but with a lim=
it rational
> > >>> of 0 it uses the display's limit as per the EDID, which is what unl=
imited game
> > >>> mode is. So with how it's implemented right now in hdmi_validate_vr=
r(), your
> > >>> example would set a maximum target, but leave the minimum at whatev=
er the
> > >>> display defaults to.
> > >>>
> > >>> Now that I'm thinking through this, a possible problem is that
> > >>> drm_crtc_helper_vrr_is_fixed_rate() operates on the user supplied l=
imits, but
> > >>> if the display supplied lower limit is equal to the user supplied u=
pper limit,
> > >>> then we have a fixed rate scenario without recognising it as such. =
I think I
> > >>> need to have a ponder on what the least surprising behaviour for us=
erspace
> > >>> is in that instance. The display limit stuff gets a bit complex due=
 to
> > >>> CinemaVRR and QMS TFRmin/TFRmax.
> > >>>
> > >>> I'll improve the documentation on the next revision to make the mea=
nings more
> > >>> explicit.
> > >> Perhaps a simple way is to require simultaneous setting MIN and MAX =
pairs?
> > >> IOW, require userspace to set MIN and MAX simultaneously to >0, or =
=3D0. For example:
> > >>
> > >> if ((vrr_min_n =3D=3D 0 || vrr_min_d =3D=3D 0 ||
> > >>      vrr_max_n =3D=3D 0 || vrr_max_d =3D=3D 0) &&
> > >>     (vrr_min_n > 0 || vrr_max_n > 0))
> > >> 	return -EINVAL;
> > >> That way, it's never ambiguous what userspace has requested for the =
range.
> > >> They can copy the EDID supported range if they don't care about limi=
ting one side, rather than leaving it at 0.
> > > Determining the actual limits can be non-trivial (though I guess that=
 might be fine as long as libdisplay-info can work them out), if user space=
 gets them wrong, it might accidentally apply a narrower limit than intende=
d.
> > >=20
> > >=20
> > >> It's then also clear if they requested a static Hz.
> > > I do see the benefit of your suggestion for this though.
> >=20
> > Xaver and I were chatting about this at XDC, and yeah it'll be difficult
> > to match KMD's monitor range, especially if KMD decides to patch it with
> > quirks and whatnot.
> >=20
> > Since we are handing compositors control over vrr range, does it sound
> > sensible to expose KMD's monitor range as a read-only property pair on
> > the drm connector? We probably don't need a num/den pair for it, it's
> > not like panels advertise fractional VRR ranges (right?).
>=20
> Sounds good to me.
>=20
> And yeah, we don't really need num/denom for it; the safe assumption is t=
hat the
> minimum range is expressed with a denominator of 1.001 whereas the maximu=
m range
> is expressed with a numerator of 1. That's sort of non-obvious for usersp=
ace

err, *denominator of 1 here. It's late.

While I'm already sending this correction, I'm now thinking that we could a=
lso
either use special values (like 0/n again, but with reworked logic to get t=
he
default frame rate?) or maybe really do have a numerator/denominator display
pair.

Entirely possible I'll keep the 0/n behaviour but refactor the "get range f=
rom
connector" part into its own thing. I think the hdmi_validate_vrr function
right now is trying to do too much and suffers in clarity and reusability as
a result.

> though, so I'll need to do some thinking around the specified behaviour.
>=20
> This sounds like a mainly theoretical concern but it's a real one, the mo=
st
> common 1.001 rates we'll run into are likely 24/1.001 or 30/1.001 and tho=
se
> are also very reasonable for a monitor to have as a lower limit. And when
> they specify that lower limit, they'll do it as just the integer rounded
> value, but seemingly expect them to be understood as the 1.001 value for
> the lower limit.
>=20
> > Fun fact: vrr_range is exposed today over debugfs for IGT testing
> > https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/gpu/drm/drm_de=
bugfs.c#L586
>=20
> Speaking of that, v2 will deduplicate my accidentally rebased-over
> mostly duplicated EDID parsing and fix this function to report the
> newly added vrr_min/vrr_max fields of the display_info. (Since
> apparently monitor_range is populated by VESA and messing with it
> may not be okay?)
>=20
> Kind regards,
> Nicolas Frattaroli
>=20
> >=20
> > Thanks,
> > Leo
> >=20
> > >=20
> > >=20
> > > -- Earthling Michel D=C3=A4nzer \ GNOME / Xwayland / Mesa developer h=
ttps://redhat.com \ Libre software enthusiast
> >=20
> >=20
>=20
>=20




