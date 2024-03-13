Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72F1B59B
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320652; cv=none; b=Y58AklG51nGFB25SGqoA90SIXuZGPp2QmTp2I56qpeq744syP0zbbuzEjGDVMM1WpYdadYu04qkQovi0Y5yi14YILycueeBcNmcwSBL4tcq1YE3WYlVOS/vL/4qIAp6FK2GcNCn0Khpc4y6RSn5+5uu+kQslI70bqV26807SrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320652; c=relaxed/simple;
	bh=cU5g9zj2K0JheMNPGBEw+qDHz/S9L3DQKQysuy9LDnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLqivEjF1j/R5h9FLuSXfqkG0z2O6DzgZDsvkzXWk0DI2F/qHFAIGflql6NagqJCKJC9Txj4pkMe0GRXJPxBHc/dB5tg/7FNTPM5hUkpZt8OQKt1v67za8Vpgkshj6iFhnGopXL472h9bKBJZsyy2KsxTHxAjRIxELy1y398TOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609eb87a847so5359437b3.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 02:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320645; x=1710925445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQj89R8jw/U+vRlJLTZpgpmmLjQKmUru9APcRiqZ1z8=;
        b=b+auHtWydge6K/BpM0a2Mp2/Awq71bl1cD8yPzY24ys+gP3RM0EvVttemIf+iI6XUA
         pSKX2ikNvQM02ZTA/NMg7qXs8KrlRwHwZtLsAsqI+8gg1+Z5xBkkyW5Bpa3YaKW4UPW3
         o5vmWIIRqQdqJsFM291NDnor6hUBD3LN8pWQv7bVUeBeZvmwZhpkB0JOFK9WviU3w6IX
         OKiDyyytsK/eemVskdyGb0OkqZJ4dRn6JlIYmvYRylRJdJdz6vJMRxVhIh2Qx2/4iDx4
         j+z9pFkcxBGeI8hpXf/s/FOuThUkdB9Es4WcmOmwYB+xR4hvoYbuywA/wG/xMr8Enyi8
         x6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWviAYCKiS2KnKUcZIcZTeX5yPNJTBCjheb+3F+yDAUAtQek9j/A3M2pBSqVEm6Js7ng6KlzgNfFudbns8vC0ce/MQoHnGbAzFC3Fg=
X-Gm-Message-State: AOJu0YzWhTVyxM99WwXrYHOZUWahkqNaggH3aQvG5/kNw8PzzOpwIr//
	g28oqK06rtttgMDskVpN9G7c+fG0Jro5uWni0rmo3B7LB+jMjEZ6LMlCajvClG4=
X-Google-Smtp-Source: AGHT+IFF+oJIuR1RNYfZtF3SpCRiQ72P3rWnTB3PSOKRBPbIVJE1nlu2h4xqhJkW33v7pSkbbr+QWw==
X-Received: by 2002:a0d:dbc2:0:b0:60a:69b3:e24e with SMTP id d185-20020a0ddbc2000000b0060a69b3e24emr964064ywe.25.1710320645084;
        Wed, 13 Mar 2024 02:04:05 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y141-20020a0dd693000000b006099041239csm2398343ywd.6.2024.03.13.02.04.04
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 02:04:04 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-609eb87a847so5359307b3.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 02:04:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMxkUYB79dtJFkTpUH0DPtEbZQXYjdeQwEQfiq1DEvpwE6AMrfAPf1wLjrirRLzFl3Q5X4nQiKxMT2K+aHn1ncu9cZknug94GL1Gc=
X-Received: by 2002:a81:4987:0:b0:609:ecdf:7c9c with SMTP id
 w129-20020a814987000000b00609ecdf7c9cmr1202609ywa.19.1710320644604; Wed, 13
 Mar 2024 02:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312154834.26178-1-tzimmermann@suse.de> <20240312154834.26178-9-tzimmermann@suse.de>
 <CAMuHMdVqWF=M=6aPRxZ0MBqPVM_wk2x+Oike6za754riHWusSA@mail.gmail.com> <ebea6554-835a-42d6-a226-f4f3480a8846@suse.de>
In-Reply-To: <ebea6554-835a-42d6-a226-f4f3480a8846@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Mar 2024 10:03:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU1wXhhhfaz9ew5xx2AVoKDdjUxqOGVVXwp4FSDmYFUYw@mail.gmail.com>
Message-ID: <CAMuHMdU1wXhhhfaz9ew5xx2AVoKDdjUxqOGVVXwp4FSDmYFUYw@mail.gmail.com>
Subject: Re: [PATCH 08/43] drm/fbdev: Add fbdev-shmem
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de, javierm@redhat.com, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, Mar 13, 2024 at 9:19=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Am 12.03.24 um 17:14 schrieb Geert Uytterhoeven:
> > On Tue, Mar 12, 2024 at 4:48=E2=80=AFPM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> Add an fbdev emulation for SHMEM-based memory managers. The code is
> >> similar to fbdev-generic, but does not require an addition shadow
> >> buffer for mmap(). Fbdev-shmem operates directly on the buffer object'=
s
> >> SHMEM pages. Fbdev's deferred-I/O mechanism updates the hardware state
> >> on write operations.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/drm_fbdev_shmem.c
> >> +static int drm_fbdev_shmem_helper_fb_probe(struct drm_fb_helper *fb_h=
elper,
> >> +                                          struct drm_fb_helper_surfac=
e_size *sizes)
> >> +{
> >> +       struct drm_client_dev *client =3D &fb_helper->client;
> >> +       struct drm_device *dev =3D fb_helper->dev;
> >> +       struct drm_client_buffer *buffer;
> >> +       struct drm_gem_shmem_object *shmem;
> >> +       struct drm_framebuffer *fb;
> >> +       struct fb_info *info;
> >> +       u32 format;
> >> +       struct iosys_map map;
> >> +       int ret;
> >> +
> >> +       drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n"=
,
> >> +                   sizes->surface_width, sizes->surface_height,
> >> +                   sizes->surface_bpp);
> >> +
> >> +       format =3D drm_mode_legacy_fb_format(sizes->surface_bpp, sizes=
->surface_depth);
> > Oops, one more caller of the imprecise
> > let's-guess-the-format-from-bpp-and-depth machinery to get rid of...
>
> Right, that has been discussed in another thread. I'll change this call
> to the drm_driver_() function.

You mean drm_driver_legacy_fb_format()? That has the same issues.

> >> +       buffer =3D drm_client_framebuffer_create(client, sizes->surfac=
e_width,
> >> +                                              sizes->surface_height, =
format);
> > [...]
> >
> >> +}
> >> +/**
> >> + * drm_fbdev_shmem_setup() - Setup fbdev emulation for GEM SHMEM help=
ers
> >> + * @dev: DRM device
> >> + * @preferred_bpp: Preferred bits per pixel for the device.
> >> + *                 32 is used if this is zero.
> >> + *
> >> + * This function sets up fbdev emulation for GEM DMA drivers that sup=
port
> >> + * dumb buffers with a virtual address and that can be mmap'ed.
> >> + * drm_fbdev_shmem_setup() shall be called after the DRM driver regis=
tered
> >> + * the new DRM device with drm_dev_register().
> >> + *
> >> + * Restore, hotplug events and teardown are all taken care of. Driver=
s that do
> >> + * suspend/resume need to call drm_fb_helper_set_suspend_unlocked() t=
hemselves.
> >> + * Simple drivers might use drm_mode_config_helper_suspend().
> >> + *
> >> + * This function is safe to call even when there are no connectors pr=
esent.
> >> + * Setup will be retried on the next hotplug event.
> >> + *
> >> + * The fbdev is destroyed by drm_dev_unregister().
> >> + */
> >> +void drm_fbdev_shmem_setup(struct drm_device *dev, unsigned int prefe=
rred_bpp)
> > As this is a completely new function, can we please get a
> > preferred_format parameter instead?
>
> An understandable question. But as it is, the patchset has a trivial
> change in each driver. And the preferred_bpp parameter has the same
> meaning as the bpp value in the video=3D parameter. So it's ok-ish for no=
w.

OK.

> Using a format parameter here is really a much larger update and touches
> the internals of the fbdev emulation. I'm not even sure that we should
> have a parameter at all. Since in-kernel clients should behave like
> userspace clients, we could try to figure out the format from the
> driver's primary planes. That's a patchset of its own.

How do you figure out "the" format from the driver's primary plane?
Isn't that a list of formats (always including XR24) , so the driver
still needs to specify a preferred format?

A while ago, I had a look into replacing preferred_{depth,bpp} by
preferred_format, but I was held back by the inconsistencies in some
drivers (e.g. depth 24 vs. 32).  Perhaps an incremental approach
(use preferred_format if available, else fall back to legacy
preferred_{depth,bpp} handling) would be more suitable?

FTR, my main use-case is letting fbdev emulation distinguish between
DRM_FORMAT_Rx and DRM_FORMAT_Cx, which share the values of depth
and bpp.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
