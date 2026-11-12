Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794497723;
	b=iyVCQJgo2FL0xXh6Rhsccws5xcRZd/40OA55XeuK/V11qqEnkAUWlo0b83YPy2fTWqLu
	 /3n/bmFmZTGhqiAL8/MsDvULrvxxC0NIYjSCQaRdlAM1oGgYh2KapRPB6VgO+SfnEGDi1
	 qfgrhsxl5iH4LaOWVSLy5xZROFYqj7lclbZvssntfZkdl2Uo/GRHbSSBSkRv+0MX+pcyh
	 mTOnUO/vCGV9s5EtorjsfPfqh+6FPiykYplQ4IZEzIolQgw6PW2w9wIl3rWTs7bEw6Vtr
	 3HdelA5+LABkzSFNNwHrponKaWjGSh2B+xQ3WqTpxC6otd8uIiAafloKM8POJuW9Q1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497723;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=WjpgXx6NEvfU1QpeJ8K6NIoACTTNQ40ei6HG54E25G4=;
	b=l4VzCf0G4Go2o41nxKrRqyQJF6UH1WMHg/P3bjppSUxXNh4XJRxx/mFy0booYG3ML9sc
	 IMJt0CfmSxCBdOrLBAJqGWM4L3q1rC1oFh9aOHJHI7HU04BMR+3N+l8P1Hsq1mFxRvpls
	 +jT1aAMQ1+v3SkuvA4x708qynDQ5xNkd9tdYMnPvejfEOL1vB4r2rWMLo+yLuNT42BCXH
	 dF5+iSrfZipb5tcEgRAmVsmcgCXPjvswdjXCinRvI/xFyqnHnMn6HVFR4eTlE7OsyNM4y
	 rfaXWJYS4Crc7R9uJamtxk9pV4O+Buja95L4qBG0guXdffYFMKhF9NB1ERZuH0mSgwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dXXu9RMD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D6606A880;
	Thu, 12 Nov 2026 15:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 718D6606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dXXu9RMD
ARC-Seal: i=1; a=rsa-sha256; t=1794497650; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Kq9864SPyKvjjMeRkdipd1E35RQlhbP0ilf6aRZxwioSOZqJRi4hUgIpli49TkACpJs+Y+kjV6OsGiZxnOZqzJermko4nVXap6/lqVSYHa2aNJw6g0Y3tpGksvDE4DkMYnrAfxunpoEEzUVTaolJTZO8gQJBTUMKJoi57CBjCzw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794497650; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WjpgXx6NEvfU1QpeJ8K6NIoACTTNQ40ei6HG54E25G4=; 
	b=jL5Z6j3nO2eolGSsRFZwEnO/838+wTgReS9TqAHhUAFdXOgBTW7XKnEbORC6W1mUieN9qv06Pt5BNh7oW24fhayZSLAz6BGrt7LWsS2M6thyaMb9UjUhFZjVOa2fynYf6xhhtGDtD9Bz/wduku52/5YHoX1lJDB+kQ5uqvbN8og=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=dXXu9RMDE0xezo6kZ18H2VSiccbq6FlBnZmCo/DcR2ZMbbhHVHrljwAtBAOFm859uXeyyFX/pUyOZhP/wCxZjlKTahs83Fb6HxhROSkyXKsfHvpVpiRwl+92SWmr9RTRScyeK+9IbHmEctP9m3I0//4XQtkGXz38uRPAqK1914E=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=WjpgXx6NEvfU1QpeJ8K6NIoACTTNQ40ei6HG54E25G4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794497647702543.2304470024969;
	Thu, 12 Nov 2026 07:34:07 -0800 (PST)
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
Subject: Re: [PATCH v2 09/27] drm: Add VRR target frame rate properties
Date: Thu, 12 Nov 2026 16:33:58 +0100
Message-ID: <6MnpleYQQheiUMA8VObDVg@collabora.com>
In-Reply-To: <812a813c-05cf-190d-6006-b8f63764beb7@nvidia.com>
References:
 <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-9-55f4215be2c2@collabora.com>
 <812a813c-05cf-190d-6006-b8f63764beb7@nvidia.com>
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

On Thursday, 12 November 2026 06:24:50 Central European Standard Time Vidith Madhu wrote:
> 
> On Thu, 5 Nov 2026, Nicolas Frattaroli wrote:
> 
> > Userspace may wish to set a target frame rate for the Variable Refresh
> > Rate mechanism. There are multiple possible ways such a target could be
> > communicated.
> > 
> > It's desirable for userspace to not only set a fixed target, but a
> > target range within which VRR may operate. This is because even if a
> > sink advertises a certain range as supported, said range may not be the
> > ideal range to use, as numbers on the extreme end of the range may
> > induce flickering or other glitches.
> > 
> > There's four choices to how one bracketing value for the target range
> > could be communicated:
> > 1. Target frame rate in something like millihertz
> > 2. Target frame period in something like usecs
> > 3. Target vtotal value
> > 4. Target frame rate as a fraction expressed by two integers
> > 
> > Choice 1 is unpleasant as it would introduce some amount of rounding to
> > common broadcast framerates like 24/1.001, which seems minor except that
> > exact matches to standard framerates would rely on making all userspace
> > and kernel agree on a specific method of rounding. This is sure to go
> > wrong, so is disqualified.
> > 
> > Choice 2 has the same problem as 1, with the added complication that
> > the EDID's VRR range is expressed in frames per second, and other HDMI
> > features express things in frames per second as well, which would
> > require possibly imprecise computations.
> > 
> > Choice 3 is disqualified as mechanisms other than VRR, such as FVA, may
> > also modify the vtotal value. Additionally, it has the same drawbacks of
> > choice 2 and 1.
> > 
> > Choice 4 is therefore what's implemented. The frame rate 24/1.001Hz, for
> > example, is expressed as nominator=24000 and denominator=1001. As there
> > is both a minimum and a maximum, there are 4 properties in total: two
> > numerators, and two denominators. A fixed rate with no variability is
> > expressed by setting the minimum fractional and the maximum fractional
> > properties to the same value.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_atomic.c      | 14 ++++++++++++
> >  drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++
> >  drivers/gpu/drm/drm_connector.c   | 48 +++++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/drm_crtc.c        | 34 +++++++++++++++++++++++++++
> >  drivers/gpu/drm/drm_mode_config.c | 20 ++++++++++++++++
> >  include/drm/drm_crtc.h            |  6 +++++
> >  include/drm/drm_mode_config.h     | 45 ++++++++++++++++++++++++++++++++++++
> >  7 files changed, 191 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index 9bb761eda59f..da5c6925c349 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -489,6 +489,7 @@ EXPORT_SYMBOL(drm_atomic_get_crtc_state);
> >  static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
> >  				 const struct drm_crtc_state *new_crtc_state)
> >  {
> > +	const struct drm_crtc_vrr_state *vrr = &new_crtc_state->vrr_state;
> >  	struct drm_crtc *crtc = new_crtc_state->crtc;
> >  
> >  	/* NOTE: we explicitly don't enforce constraints such as primary
> > @@ -544,6 +545,19 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
> >  		return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * Reject VRR limiter ranges that only specify one end of the limit, or
> I think specifying just one end of the limit should still be a valid case, 
> the client may want to use the default bound on one side implied by the 
> base timings/min. refresh rate and constrain the other.

That is what the RFC did, but unfortunately this leads to problems for
the kernel and non-obvious behaviour for userspace. Specifically, userspace
may set what is a fixed rate without intending to do so, and the kernel needs
to do a chicken-and-egg dance to determine whether something could be a fixed
rate to see if CinemaVRR lowering the minimum rate applies at which point it
may no longer be a fixed rate.

The new display-min/max properties are so that userspace knows what limits the
kernel is using (so that it factors in quirks applied outside of what's in the
EDID) and get to essentially specify one end that way.

> 
> > +	 * specify a numerator > 0 with a denominator that is 0.
> > +	 */
> > +	if ((!vrr->vrr_min_n || !vrr->vrr_min_d ||
> > +	     !vrr->vrr_max_n || !vrr->vrr_max_d) &&
> > +	    (vrr->vrr_min_n > 0 || vrr->vrr_max_n > 0)) {
> > +		drm_dbg_atomic(crtc->dev,
> > +			       "[CRTC:%d:%s] incomplete VRR limiter range\n",
> > +			       crtc->base.id, crtc->name);
> > +		return -EINVAL;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
>> [snip]




