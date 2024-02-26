Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A21CD08
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Feb 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946777; cv=none; b=PEX41LOnGFv5knmFS7MjVmuQwfZrMbrzy2dOA+Czb8T2ccr2mCYhhlI1XNcKG0DiKGLSHtafp2fprGt6EnJC7VoGQOuKdrsHIPz75FWd2NnsRJ6fnE6z1iml2PHcCe+pz/3RbzI4YsygcRbzQOnLJOWckMFCYbgF1fX1eAAUY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946777; c=relaxed/simple;
	bh=BsWoozpMNbEWYb7vRh+DT11XY9AOmootzk2UX1PtNfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVBBnUANy55r0On2iRsBUlfOEymLoeJwp+VjsYbU+jENz6TBQ68gxDIBTRdh3pkMLmIs4ysQ/T1uqxwVH/M5+Fmb+Vzyq9+5cpt+9cbXOcCRR2AmJou5jwFQEcshlPtMGvRBC47Acwc9IA8H/M/kJz/8NL76tTTQ4KT7qpG/BMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=f+7WAYdx; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="f+7WAYdx"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id C7593604E8;
	Mon, 26 Feb 2024 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708946774;
	bh=BsWoozpMNbEWYb7vRh+DT11XY9AOmootzk2UX1PtNfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+7WAYdxVzD5tI/crTSu2B3NTaAdrUDRqBlvda/8MyKMNPorUglfaj63cp4bfXDSN
	 D09Wfi4kJCj4jsvYbHX0lvL74iVzbQzhyM6Kqxcma6vBBVx1Swcm5zzDQTOWV/XSaJ
	 HPACncr4tTTFqsgIhg0e823wD5vvk8gbtxGYlpuyvB74J1kd60qHMXLLcGDcWJDGI1
	 2g6GAVrlUPZ9gCwC/SaYsxOfs1JxBMtPAKgKYrnK/JMG92NJ/DBVf4yc6RPei6BW/m
	 VSNUqR8z34YWNZMi/BqlB81popmlx/CuSBNHDqbHAn6IcMiLojbqwzoRMSsHp3dYk4
	 8hw44/309ofHg==
Date: Mon, 26 Feb 2024 13:25:49 +0200
From: Tony Lindgren <tony@atomide.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 0/2] Fixes for omapdrm console
Message-ID: <20240226112549.GU5299@atomide.com>
References: <20240225064700.48035-1-tony@atomide.com>
 <43fc93f1-d602-47ae-98e5-ee6be4ea5192@ideasonboard.com>
 <42255362-4720-414e-b442-f98355e92968@ideasonboard.com>
 <ab0b8471-97a6-479a-88aa-9bb25e91fb8a@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0b8471-97a6-479a-88aa-9bb25e91fb8a@suse.de>

* Thomas Zimmermann <tzimmermann@suse.de> [240226 09:10]:
> Hi
> 
> Am 26.02.24 um 10:01 schrieb Tomi Valkeinen:
> > On 26/02/2024 10:26, Tomi Valkeinen wrote:
> > > Hi Tony,
> > > 
> > > On 25/02/2024 08:46, Tony Lindgren wrote:
> > > > Here are two fixes for omapdrm console.
> > > 
> > > How is it broken? I don't usually use the console (or fbdev) but
> > > enabling it now, it seems to work fine for me, on DRA76 EVM with
> > > HDMI output.
> 
> Omapdrm implements drm_framebuffer_funcs.dirty withomap_framebuffer_dirty().
> AFAIK DRM semantics requires to run the dirty helper after writing to the
> framebuffer's memory. Userspace does this via the DIRTYFB ioctl. [1] But (at
> least) for correctness the console needs to do the same.
> 
> [1] https://elixir.bootlin.com/linux/v6.7.6/source/drivers/gpu/drm/drm_ioctl.c#L679

Yes I noticed console not updating and bisected it down to the two
commits listed. I did the bisect on a droid4 though with command mode
LCD. I did not test with HDMI, will give that a try too.

> > After applying your patches, I see a lot of cache-related artifacts on
> > the screen when updating the fb.
> 
> I guess we might need a dma-specific mmap helper to make this work
> correctly.

I can easily test this if you have some suggested patch to try.

Hmm so I wonder if we now have double updates happening on HDMI?

Regards,

Tony
