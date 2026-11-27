Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810621;
	b=BHpb9T/mD8rsgAz/U24qxURimPjRUFQXmLv2zl9i592NqBxtnAcYY/iH1LCXOvMdef14
	 y3hW2J0r3roZuvHn9eIWGs0TuVGzLI1oXyVQFkAr6PrOH2sSieq8vwKQlGsRISxaZ0xl6
	 YYUHvKrXyYfZGTBzYgikTyInrwlrayHSAdzb8Fb7QWZ0gQf9GFxelS1nGZLU3lSua5eLv
	 SyGKEavr/jPEZiS6GXo/Mw4N22cOXHWfqJ17bXPcZtUjnyebg+K3XVmQYyvsFuBeG+9+f
	 7MwghuVmXEQV6H14sFMHnoB4+tTVklFLxv/oN1YERDplM1hrZtJtA9PGwsTBSFWFfMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=EO5k6n/37i6TdunZgGiZGXGdx4jOGbhNEYDu4cn2rWw=;
	b=3D2cDTlZvxBcyPSAAIUuAnHxkZ2Bcz2g6tIKm4E7y7MB6yVtTkK6JSW0+AF0pvOhy3Qm
	 a9S8YocCLKioJT6PvsGRZfW7+7wE/H4U27cjHW3Qbu5thkbxmOVfIxrRDNxPwha/oJWXJ
	 lhM+py0iSlvuSZb9aHviiAsE4Ay+qj6naKSASz2wI9ts5S7gIz2v2JXBiqix6+9OzY+zX
	 hp0m3L2YHfLYX5a3pJsBDAAPHVPA9mg+8awWb7u1UwoS6NZeFYYZEpvOyqpdxa+J7P4D0
	 +ho+CuLGpOma9dbrkKYWF+qEBTBkMZGCxox8hSJIKmwFzINWG8HpYKdtfxQt2I+LY3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDtyxHbU;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D712606A32D
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 20:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D712606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDtyxHbU
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso60976185e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795810619; x=1796415419; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EO5k6n/37i6TdunZgGiZGXGdx4jOGbhNEYDu4cn2rWw=;
        b=RDtyxHbUna2CLhsAKbFg7qydec3+Fk84/8mG1l1EmvUQSBTO4yKXF/vBXD8MCHm06i
         /Srz/vEExGpmWHawDRnZxqMRs4BCbJsZUumDr6MZ56bDZRrz4VOFhaKyg7TH7zLpowcc
         1teeYl3mlvGvrExsvf1a9uVIiwoUaRmh2xPXzM2wVuWym8Demv/UJFJD+VTTB1mKPaHb
         7vts5II6MM7MqWuF/LapYzPcm9xcZ5a5R2b80wqSin3CJRehUA7m3Lfp0UuiMiWlHkct
         XwHdvKcskjHcd2WOCJQKHa9IuZzOln38lOG9ZYJw18IWUAv6dq3SZXwZZ2PmHxSClYff
         d9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795810619; x=1796415419;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EO5k6n/37i6TdunZgGiZGXGdx4jOGbhNEYDu4cn2rWw=;
        b=2VTy55OJiJt/vRTabqDfU3gkTndkTFKkeYiBy5jKN3m3P7v+dxwrE/LNAz3rxnAcAf
         NRiqs7nPMlcIVbN5e55M4+JTv0bvMoXxGFUP6uKjcgXXV+fSr5R0+x8lPGoAZS74465T
         JHLg1oxbFrVopW7Mx15H3qKLVOxVssWCHZueluR/Ueit+9j9Vu+l2dcevV4UWPQ7o268
         kclWmcLVyjqX/RZO7ORtuXzL6aFD/M8CAVDdP7I/Dls8O3HXH8DR+Eq0FAhp7exPRMF6
         UWl0FMEUeA4p+3Sjqc/iwsEmzjj8j7UdL+xRffDg5gPJF1gPTpYk3fKzAVrtA4zeFp7T
         PMjg==
X-Gm-Message-State: APuU4Z+sYV/mmOQNGDle5vYT5uoVo6+xNfF65mWGbn57ZT2A5M6iJe37
	2hogha0gtVHwXn5zM4sCr3cbPymQnfVo1ab4WN5jLabD8Yl5B0Vc4Lpw
X-Gm-Gg: AZFdTZfPcIeBUEPhGjT+7+e0jaBwTi7kQkmzvMHb7z2HaNNRl5loY+SUi2QXFKlcDI6
	BbH10tZLvlYASunALF2N5yhePArUK33MLB6o5sj6dDE5dSy4D5YE+wHrtcyRxKXfKlhrolT0meG
	yzcj3O59ae+ilimw05RZvanM82r7zc+hP76TGXHMuYKGbj+h6DP0RhiS/84XpV9hZdN4KXBM8o7
	U/hF4nody2IimMzvoy5AbJAwTAF2peSNYVQjanKhWNuqtA4UkJnLjppVRGA5jwUrR9G8fxQdH9k
	YuI3V3tBG6zlvRPbaJK1bnbOKre74NAVS/CK201EZHYGvVQQDVke0jLi4ZdDsDQgvSA34+iz/F8
	TNd0Ni617X+QaWcOX8p5ofAjVzjJ1EfEST3h6o6Q91dGfUWWWlBslccGa4t5l9w+741POqnFIzU
	Bacam8x86CXDKvn6littyhqeJOOaWUFOpRzN/1B0HBTUJpBeXOBtQgW6LI6Ab5tKu33TMofSUby
	uYAZ0oS84RsTrU759lS/2e3965rK/GwuDXvwhuoT4obi/7W92jCQ9ELja66gKMeZv3lKIk1Cm8M
	4C+r4f34ZzsU0ORfiosdpFEW3mZXYS7IsEzeh7ntHRyiDldJRXGv3sdn0mi8Q8ENsNvnvRxmnxw
	uUB2iCeGl6AhqvamfhZboNR+MDrDyJp/5OX8qaxO2kJXxlAlaPanaGqp5WutPsQdYOFtV0VTGzS
	FHwm6Q7YzPn4x8zF3mVxmitKFyRjbto5BvP/F53SAPj3aW1HhKVKWIhIQgdd/Tp2tfB3M0Lb+ob
	jxp1zXNBHdk4DTgAMpFbl8G/w==
X-Received: by 2002:a05:600c:1d09:b0:4bb:73d5:ab33 with SMTP id 5b1f17b1804b1-4bb88816acemr564296155e9.22.1795810619117;
        Fri, 27 Nov 2026 12:16:59 -0800 (PST)
Received: from jernej-laptop.localnet ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1298123635e9.4.2026.11.27.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:16:58 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hansg@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject:
 Re: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI support
Date: Fri, 27 Nov 2026 21:16:57 +0100
Message-ID: <QITIdKDQRWGwlU1DQqnbAg@gmail.com>
In-Reply-To: <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
References:
 <20261127080649.1982883-1-alastair@d-silva.org>
 <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
 <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 27. november 2026 ob 11:20:02 Srednjeevropski standardni =C4=8Da=
s je Alastair D'Silva napisal(a):
>=20
> On Fri, 2026-11-27 at 10:03 +0000, Andre Przywara wrote:
> > Hi,
> >=20
> > On 11/27/26 09:06, Alastair D'Silva wrote:
> > > This series adds boot-time simplefb HDMI support for Allwinner A733
> > > (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
> >=20
> > Where does it do that and which U-Boot version does?
> > I don't think we really want simplefb in the mainline DTs any more,=20
> > unless there is a big blocker or delay for proper Linux DE support (lik=
e=20
> > there was back in the A64 days).
> > In Jernej's HDMI series he hints about A733 support being pretty=20
> > straight-forward with the reworked H616 DE code, so chances are we see=
=20
> > proper DE3.5 support in DRM rather sooner than later.
> >=20
> > Cheers,
> > Andre
> >=20
>=20
> I think the blocker was firmware for DE for this SoC - it can be ripped o=
ut
> of the Orange Pi OS blobs, but that won't be acceptable for linux-firmwar=
e.
>=20
> I'm currently reverse engineering the GPU firmware blob, it's not very la=
rge,
> and is a well understood instruction set (MIPs) so that may be a path for=
ward
> without the vendor contributing the blob to linux-firmware themselves.

What is this GPU firmware blob? If you mean for Imagination GPU, that
blob is already in linux-firmware. But then, this has nothing to do with
actual display output. Display Engine 3.5 doesn't need any firmware...

I'm with Andre here. simplefb isn't needed. For anything more fancy,
Maxime is working on DRM readout series, which should allow seamless
takeover of display devices from bootloaders, like U-Boot.

Best regards,
Jernej


