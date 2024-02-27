Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4554BC8
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Feb 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020934; cv=none; b=iK9iL44h1W3yuwKteGUsEfuWd+Rruyp9iMvBzSd79NZKzwK8aYIu3ej5NIOdljRWj/zaqp/3wxfiR30cAIm5A/Zh+Wk5/t+WBwkyO5H1TZdKA5UFkUmnsrM1WYhbpYNKm/HJBpts5aWbWtoC1sFOAK7/xD95FDHb9Rtu9VQ07IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020934; c=relaxed/simple;
	bh=0Bij44+uXC6paw4FrGk75nstQqsSob0L/4XNtjVMDis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ1Lr3pFLftnlPqLSq4+cdjPavXN5PJP3xMrv08r4iEx+l4BWo9Or/sr9WeUhxUGXv+GWxLAKKAEdlxUjgYfOmvey4di37a0r8TQS+Zp5Uxz0W2Ratp9bnnLfr9WlLl3HqI2j9QIxyaI/01c4zA7aWaS3Wm/6ZRba5mwKDY2Xxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=L/+bvmZb; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="L/+bvmZb"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A857260462;
	Tue, 27 Feb 2024 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709020931;
	bh=0Bij44+uXC6paw4FrGk75nstQqsSob0L/4XNtjVMDis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/+bvmZbfXEskrNRk5cBjBMgpvJfvFUxWLQyAVYIzLE8mSUcFxTLsFYh+ZFFnc8nU
	 BjZIX5iKMOzLmj9zQsue5MdgrX2iY8r43TS/PpwjlbJROspk9u5n/KXfm7+TRAvcSM
	 NEaO6rv+2QKFdC7g6YTccoBbfkFFtB4Z3hzrHzqyXYUh4+LeFpG8X6SlnwX3qK5AUt
	 4RZFJ3tl258S9bAudgs5tdkApssfP1liMDhyfmz9KBBhLdQf5xK7nmmblfXe066ic4
	 0LHptSJKJlntD2iBYJHlWNdVUokoYwvViNkvIenAAZ0U/t1KjAmUNn0sEaD10Ta4L1
	 uZOR6w1DdMSNA==
Date: Tue, 27 Feb 2024 10:01:46 +0200
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
Message-ID: <20240227080146.GW5299@atomide.com>
References: <20240225064700.48035-1-tony@atomide.com>
 <43fc93f1-d602-47ae-98e5-ee6be4ea5192@ideasonboard.com>
 <42255362-4720-414e-b442-f98355e92968@ideasonboard.com>
 <ab0b8471-97a6-479a-88aa-9bb25e91fb8a@suse.de>
 <20240226112549.GU5299@atomide.com>
 <20240227070624.GB52537@atomide.com>
 <7d98a0cd-e6d5-460d-8b91-35fa340736dd@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d98a0cd-e6d5-460d-8b91-35fa340736dd@suse.de>

* Thomas Zimmermann <tzimmermann@suse.de> [240227 07:56]:
> Am 27.02.24 um 08:06 schrieb Tony Lindgren:
> > * Tony Lindgren <tony@atomide.com> [240226 13:26]:
> > > * Thomas Zimmermann <tzimmermann@suse.de> [240226 09:10]:
> > > > Am 26.02.24 um 10:01 schrieb Tomi Valkeinen:
> > > > > On 26/02/2024 10:26, Tomi Valkeinen wrote:
> > > > > > How is it broken? I don't usually use the console (or fbdev) but
> > > > > > enabling it now, it seems to work fine for me, on DRA76 EVM with
> > > > > > HDMI output.
> > > > Omapdrm implements drm_framebuffer_funcs.dirty withomap_framebuffer_dirty().
> > > > AFAIK DRM semantics requires to run the dirty helper after writing to the
> > > > framebuffer's memory. Userspace does this via the DIRTYFB ioctl. [1] But (at
> > > > least) for correctness the console needs to do the same.
> > > > 
> > > > [1] https://elixir.bootlin.com/linux/v6.7.6/source/drivers/gpu/drm/drm_ioctl.c#L679
> > > Yes I noticed console not updating and bisected it down to the two
> > > commits listed. I did the bisect on a droid4 though with command mode
> > > LCD. I did not test with HDMI, will give that a try too.
> > I can reproduce the cache issue with Tomi's omapfb-tests [2] below:
> > 
> > while true;
> >        do dd if=/dev/urandom of=/dev/fb0
> >        ~/src/omapfb-tests/test
> >        sleep 1
> > done
> > 
> > That produces short random data stripes on the test image.
> > 
> > > > > After applying your patches, I see a lot of cache-related artifacts on
> > > > > the screen when updating the fb.
> > > > I guess we might need a dma-specific mmap helper to make this work
> > > > correctly.
> > Comparing the difference between drm_gem_mmap_obj() and
> > fb_deferred_io_mmap(), the following test patch makes the cache issue
> > go away for me. Not sure if this can be set based on some flag, or if
> > we need a separate fb_deferred_io_wc_mmap() or something like that?
> > 
> > [2] https://github.com/tomba/omapfb-tests
> > 
> > 8< --------------------
> > diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> > --- a/drivers/video/fbdev/core/fb_defio.c
> > +++ b/drivers/video/fbdev/core/fb_defio.c
> > @@ -224,6 +224,7 @@ static const struct address_space_operations fb_deferred_io_aops = {
> >   int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
> >   {
> >   	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> > +	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> 
> Great, that's exactly what I had in mind!

OK :)

> My proposal is to add this mmap function directly to omapdrm. I'll later
> take care of integrating this into the overall framework. I have a few other
> ideas in mind that are related to this issue. Ok?

OK that sounds good to me, I'll post v3 set of patches.

Regards,

Tony
