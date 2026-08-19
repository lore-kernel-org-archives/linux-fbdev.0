Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0294374192
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183825; cv=pass; b=c0RAwBHvQwYtoc1YEPch6+TEU+pkd1NVvwb5Xg5CUoG4jRghv/7s6QLtEAw0io3kNTLdjZ3hel40C12O2SLIwo37CJBjxa+WdGfFgPZJeXMSHTRwLlw24hxrNzQBvlSXaisypZI/D6xsUEO3tKxi1CmjmulbG3aUHWNwzWN/lbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183825; c=relaxed/simple;
	bh=wgjj8WuiZYUMY2UUr+Q1Kyng/gQMuV8XXaYN9VqOJR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1JgRqw5WrfJzNjJawXnAQjStge7GAOhKuX0PbqXwRakPVCDo52jnbUHaS+nesgnTQztvF0H4xEOhZbiOeEj4z10HplkkKDmlgedzRI5yyNdg54IOoCC7fRrul7ecXJYhysJSaDFlrq/K59aGNMUp2OuBwNAWTHO+ERQTWYQGAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY4CfjN9; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY4CfjN9"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so2811833a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 16:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787183822; cv=none;
        d=google.com; s=arc-20260327;
        b=KY+1E4+VvUblSTebTpIOCT3ocGnLjzKFdWWEinbtdCcI/qLwzpDfqAGNr4FdVIQ2oz
         1SrTHM68de6ckRZwPFOvE4jBTUcwR1VKBrw+z06pSn9EiO4I9INI06CJDR5Ee3yQ3u4e
         8vK9ZS81XCp7x0JDgJMlmplNm4bfZRKqigHbMVMEhqJN7fsFKOww3lYLsyAgjR3dcQzq
         z18ZBgwEcJSUT9DA5YRfgFtZ2WzrdUZbVDLEkjfncqRcvWS2eJMfAlZE+w5jQQrfDLUT
         4wslw7gQiUOb6Urxy8/VCxs59+5GGcAMV99Accg24GyA6l/UMDAiNUN5FpQo33d7K4M8
         cglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wgjj8WuiZYUMY2UUr+Q1Kyng/gQMuV8XXaYN9VqOJR0=;
        fh=SNxAHAIjZbEuTp8YaplOvIFPElaW+iVVcosRjRhtBwQ=;
        b=YEB3aeP8IqCd7bvofjktjC16TkVd9+Dzmvgdy41RxEWGz1ZSZpGQ8XlWsWpepivFkQ
         if9IPwvmdFN49N7x03dngpR3+3GqLeMZiXCrcfge/ZPcPV3D9ToHG9rl0XY6DbpIGMwU
         yeTmIToN+ATQZWlh9dVVb5N2EXRbnxmpPOzhgX1AYSl4V9SMSZM1XOmtYoTAndDpSpm+
         n9sqRx2y+1Byyz7JcRbjBL+4dQpm6hLWDWMnhHizkUmGPgYHAjVt8cMff1Qi1PiD4LOO
         YjknRjzUHgOlPXsG308FZLCyWcC+uNa8npt2TGyYAAMVYaIkrXe6vtWqeGOvJXa/zDM4
         t3VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787183822; x=1787788622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wgjj8WuiZYUMY2UUr+Q1Kyng/gQMuV8XXaYN9VqOJR0=;
        b=BY4CfjN9CF5mZqYl2ZUGUcplTRwY+eN08P2B1891pxCUQgi61Htc80lVFG8qIg+Lu8
         VTpUIP0cj0EmEsY5I1XhKZZMSAmz10FBfFAi50ZLPg4Z2sAvMdVUnJIXnytSAnXpcWY/
         zh1OPntE3zXmvswUWfI4nbNfSeEm/n4YbQG6/Ca3Al6FW3rETRImMWb16Bd2mEkIJhGt
         jXb4b0q4AnFyEZZjE6+bvYqqHOioAZpedXpRXP9Lghgi1LF1WHeRmmv4+AKMRT/BM4M5
         P0Du4IyEuJyBDbnByVKsJWlQBKBKHAOrq7lfc08DQWScN5r8uqva3GXYbYqIICbasaew
         OULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787183822; x=1787788622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgjj8WuiZYUMY2UUr+Q1Kyng/gQMuV8XXaYN9VqOJR0=;
        b=DhfF0Nes3/dNeB7FTpbELFVaqpKNodf40UbHvSPM+p/z5acYnoAtg8x3+9waBUZb9v
         QWQv6jRVpuaWupUy48F2KRVBga8TNqWSWLDVple2SrigfCZC2Slp2d2Dsvq9B86Rsibg
         PgtpMlGNzMZ2nk1R3L/tykm1bBM/Ta9HqsS+wIEe2F4qC2KM4WUPU+pNqsox406XVxB6
         /6ptLtNQ3HPiYQ3OwLMVk+5qIVfAfjGm0mWJfZImXF13OPVKnHsCDI/l/m6qS+k7WRIv
         Kfn+LYYHxr8CFnBoDZA7q8HNesI6OgJIxWDxVsp48nszZBOzP4E/SWMRC6o8zp1Nuu6v
         QLnA==
X-Forwarded-Encrypted: i=1; AHgh+RqQ4C/+XXpoH5NV2+ZOhSEzlpk5fdt3wmZ3mvjLon/oYYMZkYuBxbfZT/NMK6NXQHIXNSehL/Hxyk0Dqg==@vger.kernel.org
X-Gm-Message-State: AFuF++lVsgjCD+RpY/f6kESIXGOJFXX0Aif/jbiaJEuRmhbMrL1QECKy
	Br2NPM4plIiqCWbzXjw+uSPcnOHpTQ4lil4FAqaud4ut90KU/zKY9j+hm6TflAGqdb1yjzolZoo
	9khthwGxhoMuFcgA6uDuWA7aBtzszCyg=
X-Gm-Gg: AR+sD13PQ05PNphENowLFqvBhc7fC5IJnHYGZ+TJ24yVeOH5YnAqkibPMjnx7ihODj1
	XH1maY4jUib6Z8k+GmchnnWYy9wfLUIWwS37LR+30My75xCRMltWMj79bMfR7w87ArWNtDzigWA
	JyNOH+1JGGK28pm8dLiST4LN5+ofUdPNrmtxEVFgWTdaTUNNAyvMZagomA0XFeHu3FpHcowq2yG
	Hph2eJY8arQJ9OTj0vFH+nUaR1d2tg8QCMv78vyS2gE/soxgeMO6NHnH5gpjEW0htXZSZzx9jCq
	3W0AzOfIIwJGeNMBbpa+QMn/UF+DfiKxjs5UDFa4Xg==
X-Received: by 2002:a05:6402:44d3:b0:69a:928:9405 with SMTP id
 4fb4d7f45d1cf-6a4032961bemr4544062a12.1.1787183821720; Wed, 19 Aug 2026
 16:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat> <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat> <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260814155325.GB516994@ravnborg.org> <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
 <aoSygH8JSXFrivOA@bywater>
In-Reply-To: <aoSygH8JSXFrivOA@bywater>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 20 Aug 2026 01:56:48 +0200
X-Gm-Features: AcwNN1VNx4GsAKqd8z0hu2r6Vk3bBmJ_vBla6bGBHBSguaKITunj7iojs8USPhQ
Message-ID: <CAEUXW=HHJve+NDwkzhC5sWwqWbBwAAyxLUdp0e1tK4NP2=1Dqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Francesco Valla <francesco@valla.it>
Cc: Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam, Francesco,

Sam -- thanks, and you're right that it's doable. One honest nuance on
where it would live: CLUT224 isn't a DRM fourcc, it's the kernel logo's
own container -- a palette plus one index byte per pixel. drm_format_helper
converts between pixel formats, which is a symmetric operation; turning
CLUT224 into RGB is a palette decode, not a reformat. It can certainly sit
there, but it's worth calling it what it is: a decompression step in front
of the scanout, not a format conversion next to the xrgb8888->rgb565 helper=
s.

Francesco -- that's exactly the crux, and I think we agree completely. The
palette expansion is cheap for me only because the image is small and
low-resolution: one lookup per pixel at 800x480 costs nothing, so I get the
17 KiB on flash for free at boot. But that's the "low-resolution sweet spot=
"
you describe, not the general case -- at a generic resolution the per-pixel
decode stops being free, and boot time is the whole point. So I don't think
paletted input belongs in a client whose goal is to stay generic; it's a
trade that only pays off when the image is deliberately small.

For the case where nothing lights the panel before Linux -- Falcon boot,
or a handover where the buffer doesn't survive -- I do have to draw, and
there I'd rather build on your series than start from scratch. I can't use
it unchanged, since my logo isn't a BMP: it's a small CLUT224 (paletted)
blob carried in the device tree, so I'd add a source alongside your BGRT
and firmware-BMP ones that recognises it by a magic and decodes the palette=
.
But the client structure, the drm_client_setup() hook, the scanout path --
that's all your groundwork, and I'd be leaning on it. Thanks for the offer
to help on a respin, and for the series, which is what made the distinction
clear to me.

Max

El mar, 18 ago 2026 a las 21:39, Francesco Valla
(<francesco@valla.it>) escribi=C3=B3:
>
> Hi M=C3=A0xim,
>
> On Tue, Aug 18, 2026 at 12:48:21AM +0200, M=C3=A0xim Pedraza Padilla wrot=
e:
> > Hi Sam,
> >
> > Thank you -- that's a useful pointer, and it settles the question of ho=
w
> > a splash should be drawn without fbcon: a DRM client at
> > drm_client_setup(), next to drm_log, not a drm_fb_helper hook.
> >
> > Francesco's series is genuinely inspiring work, and it would be very
> > useful to me if it could take a CLUT224 image -- unfortunately it can't=
.
> > It only accepts an uncompressed 24-bit RGB888 BMP, whereas our logo is
> > paletted, which is what keeps it small: 17 KiB for 800x480 rather than
> > around a megabyte. So as it stands the format doesn't line up with what
> > we carry.
>
> Format concerns are - in addition to lack of time to work on it - what
> is keeping me from sending a new revision. Any kind of compression would
> need to be unwinded - probably on a per-pixel basis - making the
> required CPU time unreasonable for large images (at least if boot time
> optimization is the ultimate goal - linke in my case).
>
> Of course, on "low-resolution" displays the size-vs-time tradeoff might
> be the sweet spot - but the target here was to being as much generic as
> possible.
>
> >
> > Reading it did make the distinction clearer to me, though. drm_splash
> > *draws* an image into a fresh buffer, which means a first modeset and t=
he
> > blanking that comes with it. What our hardware leaves us with is a
> > framebuffer U-Boot has already drawn and a CRTC still scanning it out, =
so
> > for our case the natural thing is to *adopt* that state rather than
> > redraw it -- which is what hardware state readout does, with no redraw
> > and no flicker.
> >
> > Where drm_splash is the right tool is the case with no state to adopt -=
-
> > Falcon boot, where U-Boot proper never runs, or a handover where the
> > buffer doesn't survive. I'll follow Francesco's series for that.
>
> My typical embedded setup is exactly that one - Falcon boot, a simple
> boot logic inside the SPL, and possibly no initramfs. I find this to be
> the most portable solution, as it does not require complex drivers and
> handover logic in the bootloader.
>
> In case you decide to take my series for a re-spin, feel free to ask if
> something is unclear.
>
> > Thanks again -- it helped me draw the line between the two.
> >
> > Max
>
> Reagrds,
>
> Francesco
>
