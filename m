Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7087368276;
	Tue, 18 Aug 2026 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083302; cv=pass; b=PlLbDoWGmXIc1OKeNj4/wdQXkMU7Nh1uo3Ft4s/ZFn565Tj+LMh9rAE6hX3H+r0RR4bSGuHWXNFgleWDhwC8vw0MJy3aNF9f4CO56U1G89nmQsOAERdig/B4KvYknjFoePdZ6C6EGPUujtojuYerP5p2CbLL+c+hBPD4JO5Lhso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083302; c=relaxed/simple;
	bh=wHP5KBg/oNB+Ay6wTp7lvz/U/sVkCZYQHiydgCUUv2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPmyXdxWK1JZWMDCilxtoaqKpci38+2y9T1d6MnP7JYTKsikVPCkHqU5Bl6vFqPtStuZ05psI/OaKpqim/DHwBra/Ofd5P+YqK/XXcVlrmUNvWjA126q4ab+iPrFvdisU/hsxW7aUj3Br3e8LwVFGvwSjjpKCiP+JNbDXjyrk04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=NUIP4/OQ; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=E60QJm7E; arc=pass smtp.client-ip=185.56.87.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="NUIP4/OQ";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="E60QJm7E"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-v4rr.prod.antispam.mailspamprotection.com; s=arckey; t=1787083299;
	 b=Orq5ZrgKs8jBUQJ3TsYfjWtjBWWvJeFN0JYWLFa8X9Y52h2B3A2DnP1bkZYmtTeNLgMCp27Rk4
	  Eactn9SMiVNSFw+P2RBtL3Ahtl6m+vt5xz0njAb2xGXKtbtGY726vVzYWCvZNeofFF0qnxK3nS
	  ZfftriuDr47mvK9+CWiSaRwmdt3o29onxqa9DhnhwBegs+i3tpjcgAvgYcCI7tPnSiU5Hfos7f
	  Dvk2AznnIRiQbL94qQuyJOA5QuJngmFJFYlfDz1SzeTcHFQW7/qY4uMkdwFpyAmh4Or1f5VIey
	  OByanXZaAS9pTeiPs4CSBXyXZDbXvqRivO3GkJ6o8u+GsA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-v4rr.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-v4rr.prod.antispam.mailspamprotection.com; s=arckey; t=1787083299;
	bh=wHP5KBg/oNB+Ay6wTp7lvz/U/sVkCZYQHiydgCUUv2U=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=X1eILoCTbCZWKJmv2RBnZ/xNnCEMCtfblO39y7319D6fxEC+Gqx1kiRfGf/8rEtL5Qqb4/0QYs
	  amQSxWa9mXdf0USEpcUC8tqVAhaZfOQe6oq1FIQlnRT0lqg1enfMP9mc5fUokc6SKBJB4ZuBwV
	  8hK8NU9rzR989efpVRZYocPnbUqvNNtZ+Wa3amuEdPe+dr9kx5T2HHyFcM0M9FZj+katwAeki9
	  W2QiI3okJeDRt+qDIifVMCi7AOOI8Nep1O5M8/TlYY4vUiiwtm6TELc4r+Xkwclb5JT83fM3nb
	  ER5SfgByn3gYTyRg+UZ9isop5T33HkfmSsEieP9nMlBVmA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=3pmtWH4eFsI2qfj6Txsmu/hKvSWq+vceDLJCUvd8CW0=; b=NUIP4/OQniaL9BK8RoISIFrBE5
	mJZnz0p9lf5n/AY7Bsv7zI1kzAMlWj6JcJToIQs7I05VGhC8uVFltMNgj5aqNe00blZCRWXz5VJR1
	oMZrbbZnvAXDMzG0EyhnU8apAuhZgf383z1cedYEtqpgOL/wlqNJL0W5qrmfdksiyLqo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-v4rr.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1wwPek-000000037SS-2oxs;
	Tue, 18 Aug 2026 19:39:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=3pmtWH4eFsI2qfj6Txsmu/hKvSWq+vceDLJCUvd8CW0=; b=E60QJm7ENkgKZRD25VMjMR5TCA
	BMleotmG9NUp+WMpOPuG5hWFGzU1LzEzMVpbJbCSeDa1EYhxUTyib9fNgyFW+pbxbzVY+t0H/nh7T
	Z72DDAU7DLcZfH3vTwgWH7OXMa3SMTy0+lbww/2s/NYLslfbAkqDDuLhR0sWfqpkxbRw=;
Received: from [87.5.139.196] (port=60131 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1wwPeV-00000000Fh4-2goh;
	Tue, 18 Aug 2026 19:39:15 +0000
Date: Tue, 18 Aug 2026 21:39:13 +0200
From: Francesco Valla <francesco@valla.it>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>, 
	Helge Deller <deller@gmx.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <aoSygH8JSXFrivOA@bywater>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260814155325.GB516994@ravnborg.org>
 <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: a9886efba043501a04ef82f403f845d6
X-AntiAbuse: ID - a9886efba043501a04ef82f403f845d6
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wwPek-000000037SS-2oxs-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-v4rr.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Màxim,

On Tue, Aug 18, 2026 at 12:48:21AM +0200, Màxim Pedraza Padilla wrote:
> Hi Sam,
> 
> Thank you -- that's a useful pointer, and it settles the question of how
> a splash should be drawn without fbcon: a DRM client at
> drm_client_setup(), next to drm_log, not a drm_fb_helper hook.
> 
> Francesco's series is genuinely inspiring work, and it would be very
> useful to me if it could take a CLUT224 image -- unfortunately it can't.
> It only accepts an uncompressed 24-bit RGB888 BMP, whereas our logo is
> paletted, which is what keeps it small: 17 KiB for 800x480 rather than
> around a megabyte. So as it stands the format doesn't line up with what
> we carry.

Format concerns are - in addition to lack of time to work on it - what
is keeping me from sending a new revision. Any kind of compression would
need to be unwinded - probably on a per-pixel basis - making the
required CPU time unreasonable for large images (at least if boot time
optimization is the ultimate goal - linke in my case).

Of course, on "low-resolution" displays the size-vs-time tradeoff might
be the sweet spot - but the target here was to being as much generic as
possible.

> 
> Reading it did make the distinction clearer to me, though. drm_splash
> *draws* an image into a fresh buffer, which means a first modeset and the
> blanking that comes with it. What our hardware leaves us with is a
> framebuffer U-Boot has already drawn and a CRTC still scanning it out, so
> for our case the natural thing is to *adopt* that state rather than
> redraw it -- which is what hardware state readout does, with no redraw
> and no flicker.
> 
> Where drm_splash is the right tool is the case with no state to adopt --
> Falcon boot, where U-Boot proper never runs, or a handover where the
> buffer doesn't survive. I'll follow Francesco's series for that.

My typical embedded setup is exactly that one - Falcon boot, a simple
boot logic inside the SPL, and possibly no initramfs. I find this to be
the most portable solution, as it does not require complex drivers and
handover logic in the bootloader.

In case you decide to take my series for a re-spin, feel free to ask if
something is unclear.

> Thanks again -- it helped me draw the line between the two.
> 
> Max

Reagrds,

Francesco

