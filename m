Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295373DB64A;
	Tue, 29 Sep 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705768; cv=pass; b=mssUAwRO5UeQ3IpQ0d3aVBx5LapRuc00XCXP8i1mztFFZn1RBqxZvr+5IVEQpqqvt3h6iWzbVNloXyC6y1l14D9Sc6wLePz616d9gkXUwEHlp/l/N6ZYie9YLOb5CTgNo8j98Jy7Qh6B+1dZIcgMjzqtlnlVCYmgB749ZZW6zZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705768; c=relaxed/simple;
	bh=4Xvcreb8gWeCOjqTYtkcjLmzTv2wC3DMnQ9bawf5YQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb8YBAa8hD3KOjTLi2oeU2mRUkD8agzFuqQzV3Q8hoRmeYWdiIxXrjQ8EwAPsqzkRP7PA30RscKxr64RIb7GMy7gnnZvaYHOhLdJDTOyDZoR7KQ8KUPNq5y5Cf0O1zdMqQ8wdcuV9ShvfK/QFP0sXj8iuZ9b8xumCmjQl7XV5H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=M0M4pbef; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="M0M4pbef"
ARC-Seal: i=1; a=rsa-sha256; t=1790705684; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CbSTsuEIzMi8NQDvjEYx3+qKzuZPiaGg6yjSl2wL7fKDcqnU40Hcxv2p5UJCWQ4OCmyxQqaf8MbrkESheURSaQhiYlT3xscOMelbSvSc9ZjRmRVUYr7xqb5Aq/H5PT6xuy/8W3ld0XhktiDcm4YWdHPgw3k4CEb1V6E3xxBVFec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790705684; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VqA5KD7T6CUdh/gnvAhmHBiLWsN4nMCl68qkHoiN4+I=; 
	b=H2yH23gEGGnPlLCTD+lmgXvD7FHqDagxEI69FkiR0OTKG76iq+p39A61mo5QC7OJI55fHjr1TBHdPgBokdMaHC+WVIkbtnYvSSB6m0RXkXYEUKdU+JTDlxa9tyels62rBo7KtKq5uhna2WMIta6faHwLbfPTNLY8iU/lAodzQXI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790705684;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=VqA5KD7T6CUdh/gnvAhmHBiLWsN4nMCl68qkHoiN4+I=;
	b=M0M4pbef6ULbnfyRVPCBj57Llpuo6uG+9wRTfbaPJMvQiWVNzn0NEWgafMR24rfK
	qF6VmlEKQYOkC4ZfNio0OTumKLYG5uSb1AX18AZqP5mTSoLgPvUIjM3qajdmSVv/CRw
	Yxk5gk5CjN68cRDlwHYgXj3hNHBwxyeb7qQqPIFM=
Received: by smtp.zohomail.com with SMTPS id 17907056822681009.9156419401866;
	Tue, 29 Sep 2026 11:14:42 -0700 (PDT)
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
Date: Tue, 29 Sep 2026 20:14:34 +0200
Message-ID: <SwRul6_8Tc-C-2oBT64DOg@collabora.com>
In-Reply-To: <164d00c2-e4cb-4962-8e4e-389ae77af943@amd.com>
References:
 <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <3cf7143d-7013-4a3b-a831-96c3f125c2f6@mailbox.org>
 <164d00c2-e4cb-4962-8e4e-389ae77af943@amd.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 29 September 2026 16:34:58 Central European Summer Time Leo Li =
wrote:
>=20
> On 2026-09-28 04:10, Michel D=C3=A4nzer wrote:
> >>> You can picture VRR limiting as always being active, but with a limit=
 rational
> >>> of 0 it uses the display's limit as per the EDID, which is what unlim=
ited game
> >>> mode is. So with how it's implemented right now in hdmi_validate_vrr(=
), your
> >>> example would set a maximum target, but leave the minimum at whatever=
 the
> >>> display defaults to.
> >>>
> >>> Now that I'm thinking through this, a possible problem is that
> >>> drm_crtc_helper_vrr_is_fixed_rate() operates on the user supplied lim=
its, but
> >>> if the display supplied lower limit is equal to the user supplied upp=
er limit,
> >>> then we have a fixed rate scenario without recognising it as such. I =
think I
> >>> need to have a ponder on what the least surprising behaviour for user=
space
> >>> is in that instance. The display limit stuff gets a bit complex due to
> >>> CinemaVRR and QMS TFRmin/TFRmax.
> >>>
> >>> I'll improve the documentation on the next revision to make the meani=
ngs more
> >>> explicit.
> >> Perhaps a simple way is to require simultaneous setting MIN and MAX pa=
irs?
> >> IOW, require userspace to set MIN and MAX simultaneously to >0, or =3D=
0. For example:
> >>
> >> if ((vrr_min_n =3D=3D 0 || vrr_min_d =3D=3D 0 ||
> >>      vrr_max_n =3D=3D 0 || vrr_max_d =3D=3D 0) &&
> >>     (vrr_min_n > 0 || vrr_max_n > 0))
> >> 	return -EINVAL;
> >> That way, it's never ambiguous what userspace has requested for the ra=
nge.
> >> They can copy the EDID supported range if they don't care about limiti=
ng one side, rather than leaving it at 0.
> > Determining the actual limits can be non-trivial (though I guess that m=
ight be fine as long as libdisplay-info can work them out), if user space g=
ets them wrong, it might accidentally apply a narrower limit than intended.
> >=20
> >=20
> >> It's then also clear if they requested a static Hz.
> > I do see the benefit of your suggestion for this though.
>=20
> Xaver and I were chatting about this at XDC, and yeah it'll be difficult
> to match KMD's monitor range, especially if KMD decides to patch it with
> quirks and whatnot.
>=20
> Since we are handing compositors control over vrr range, does it sound
> sensible to expose KMD's monitor range as a read-only property pair on
> the drm connector? We probably don't need a num/den pair for it, it's
> not like panels advertise fractional VRR ranges (right?).

Sounds good to me.

And yeah, we don't really need num/denom for it; the safe assumption is tha=
t the
minimum range is expressed with a denominator of 1.001 whereas the maximum =
range
is expressed with a numerator of 1. That's sort of non-obvious for userspace
though, so I'll need to do some thinking around the specified behaviour.

This sounds like a mainly theoretical concern but it's a real one, the most
common 1.001 rates we'll run into are likely 24/1.001 or 30/1.001 and those
are also very reasonable for a monitor to have as a lower limit. And when
they specify that lower limit, they'll do it as just the integer rounded
value, but seemingly expect them to be understood as the 1.001 value for
the lower limit.

> Fun fact: vrr_range is exposed today over debugfs for IGT testing
> https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/gpu/drm/drm_debu=
gfs.c#L586

Speaking of that, v2 will deduplicate my accidentally rebased-over
mostly duplicated EDID parsing and fix this function to report the
newly added vrr_min/vrr_max fields of the display_info. (Since
apparently monitor_range is populated by VESA and messing with it
may not be okay?)

Kind regards,
Nicolas Frattaroli

>=20
> Thanks,
> Leo
>=20
> >=20
> >=20
> > -- Earthling Michel D=C3=A4nzer \ GNOME / Xwayland / Mesa developer htt=
ps://redhat.com \ Libre software enthusiast
>=20
>=20




