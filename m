Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658E3749F7;
	Wed, 23 Sep 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174524; cv=pass; b=uwPeHAqparnxsBDXf4WykQkFHcZeZlbpWFLIUZWp4lUmA3si0AQTIjQzmXK0jfuhFXBQ9zApSrnAvnFFBh6XYi4ufZHE9FCM56Bn3e8lNGaj/v1iVAvJrD6VfYEwzAJHScxKwRiByEp6BtQ1yS8j/54kGx+MqK7/b+sXVupwGEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174524; c=relaxed/simple;
	bh=F2aXbujIxoCyt7cj9H0Rb9VCuMUSDgRr3VpYMtadM1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsnPKiOuyy777N0JsEzWReOTS0HxnoU7p42OKVu5wzr/4MVKrYdxo520Z5qIqOQi3IRASpuoyXCy7WXdhU0FrdyFsvPOHXBCbSXvQpdU94wjh2OK88ww8vhReifeiXNms+6Gt3tdB2PLUnzcBFU4utcI/SmJNZeMnkQ9MdDr/os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Gv6B+QMS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Gv6B+QMS"
ARC-Seal: i=1; a=rsa-sha256; t=1790174432; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e5OkvZYukIt5GiTQhW6G+Kt1c269AMGHFXpP3r7i+CLvslhzze3rX4ILzx5pTKxgBRIk4eGy2F5HaUWIQuzEmjWHV2bh0li4VAw5VV3vgx58YZezIfbSNX3mvz04KJRvYDlIcdq25Kp7+aL0OkmwqjFMeVYFhQKb9NXxvlicAf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790174432; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pAuvWDVYVwhz9FttWiM1t3wAMo1yh0IBF3GPtqoFkZA=; 
	b=ddYCwNc0m34CAPczGPwkeH3AcvGPgdXzFqRZh6b8tu6HRgdBLSyoKd1k+BgSfZT8VhNkaMponBaq8nwYgKFU9o35+0FOliOdAf/BzJJOcTlQuvzxhRBhmW2NjqGnHQLHbf/tQYiFxSkyMRQDGxMi0/J9VrrjnYY0aleWunJAIL4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790174432;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=pAuvWDVYVwhz9FttWiM1t3wAMo1yh0IBF3GPtqoFkZA=;
	b=Gv6B+QMS10z3axRJLGhhpi3sf27EvZHXCdFXjbFmfzCs9qJg3pQk9aS/Yk9UJaPi
	SLUfnU66bwh4D4qSZKNaxfUGEmDj5eTCix712HE5alCc2nZV+3gwqhIU/a8i6VS0FLY
	nyguwDqV8p9OR2I5z9STawWqE/wrdi7EY/f1vV+s=
Received: by smtp.zohomail.com with SMTPS id 1790174426791143.0815861883815;
	Wed, 23 Sep 2026 07:40:26 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
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
 Andy Yan <andy.yan@rock-chips.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
Date: Wed, 23 Sep 2026 16:39:57 +0200
Message-ID: <YozwdeJLQh-0GBcK9P3QvQ@collabora.com>
In-Reply-To: <588442c7-2589-4026-a8f8-e03f944318c3@mailbox.org>
References:
 <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <588442c7-2589-4026-a8f8-e03f944318c3@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 23 September 2026 11:51:45 Central European Summer Time Miche=
l D=C3=A4nzer wrote:
> On 9/21/26 17:51, Nicolas Frattaroli wrote:
> >=20
> > + * .. _VRR-MIN-NUMERATOR:
> > + *
> > + * "VRR_MIN_NUMERATOR":
> > + *	Default &drm_crtc integer property forming the numerator of a
> > + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> > + *	target rate. Set to 0 to disable.
> > + *
> > + * "VRR_MIN_DENOMINATOR":
> > + *	Default &drm_crtc integer property forming the denominator of a
> > + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> > + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
> > + *	zero, it must be non-zero.
> > + *	Otherwise, must also be zero.
> > + *
> > + * .. _VRR-MAX-NUMERATOR:
> > + *
> > + * "VRR_MAX_NUMERATOR":
> > + *	Default &drm_crtc integer property forming the numerator of a
> > + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> > + *	target rate. Set to 0 to disable.
> > + *
> > + * "VRR_MAX_DENOMINATOR":
> > + *	Default &drm_crtc integer property forming the denominator of a
> > + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> > + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
> > + *	zero, it must be non-zero. Otherwise, must also be zero.
> >   */
>=20
> Is there a reason that DENOMINATOR must be 0 when the corresponding NUMER=
ATOR is? 0 divided by any number is still 0.

No, I think that's an arbitrary convention I settled on and don't enforce. I
guess it should be "Otherwise, may also be zero", because the only situation
I'm making userspace avoid is x/0 where x !=3D 0.

> > Either way, should these rules be enforced in drm_atomic_crtc_set_prope=
rty?
>=20
> Or rather in atomic_check.

Due to complicating factors like EDID, CinemaVRR, and QMS TFRmin/TFRmax, ch=
ecking
the properties for sensible values is done in the HDMI state helpers at the=
 moment.

If/when there is a similar mechanism for DP, we can probably factor the com=
mon
parts out. I really do hope all drivers (including those that don't use the=
 HDMI
state helpers) can at least share the hdmi_validate_vrr() logic, but I have=
n't
factored this out into an exported function yet because I don't know how si=
milar
the DisplayPort-equivalent mechanisms requirements are, or how much of the =
state
derivation non-state-helper drivers (i.e. i915 and amdgpu) need.

Kind regards,
Nicolas Frattaroli


