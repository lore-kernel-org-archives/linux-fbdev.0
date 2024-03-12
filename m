Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741F7C6DE
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260101; cv=none; b=KJ4mo+NlVAKn7tbIQvLTJXl/a6WL2W7Z9nzDwKkXsV9bDzR0r+RdLfMAq6N6sZZVtvptJW4854FtMb3/8jDDS35e+iFaXdPWgLQzQuRO6THgXi8jTZh2aQT9PfMgd/LQe4f83DGwpm5ocUaMBHcM3UE81PqLKP67ZVlnIMlGGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260101; c=relaxed/simple;
	bh=Qi6ZI87pVhUK8ITtTtHmaudIUkUt6jZD6kJnW5j8jFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx7vW9nVHGWHlktCVSuonvsXJz9hsFOjRMWMwSbD04Gul/kYcTn1Zu44da4OkRBySbT0cbsI7AnD/K3J8uFpN76iO4nwNPXtdAxzv5eXPViJelGwZYSn6hK4sIws6CsChtpx1TFR5hMCppQIwFejNHWIBc8WjjVOTs8vLbx++WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609f1f97864so56857477b3.0
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 09:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260098; x=1710864898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zhIqrp+JPMaViw5gjMSbfJFkQ4tb5ZNwsMB/45s1rM=;
        b=WeLF7kNlI74AnT7ZH1X6+/RoohqWhPVYBq/x/623ZAnVKA9cvy8XxY9WdhrWISWKXM
         GvThdaa6+3DtKrJVzSI1H5VffCijaVCGTGvsroWcYA3jIGws4FFWZ+bFyDbKHH/XdDAF
         SgPHBVHs/ymr1RXHRNa/9AAHgfoEmO0KeVJGhnUHlzYeBuE35m2uwTYLFk91qmOKySiE
         ApzkDff6X1b6g3bpRWIkHgmdayBu4d2ALAXuTY8cxtaYaYHDsbSFZwyDT+YTLBdHUl6c
         yQdbJlMcFxBcMTcAoIYHCNKnZIhSHKhIi12DXVKZ9qjmaE97ztQimAifeRAnh8s1Lvhy
         RtVg==
X-Forwarded-Encrypted: i=1; AJvYcCVyRVnNUuMzCDK0/KeEDRqrTRoctGMaBtzxc/v/7CgRr+Yd33Ash/qZu3j1/f8qD3nCpjVFxiqhM3Yj/XQNXQuzHO09BQoDSDV6n3I=
X-Gm-Message-State: AOJu0YwYg3xKFOjlXXVUTGmtFzcvxy2NNJguMr4a1yXvsPSZJCE/sLfr
	kUOEjxDitvidgJjfh5Ho1aMu9YxD5X4lrLUtq3iQeorjbVtE7fxbMc0muoJoais=
X-Google-Smtp-Source: AGHT+IGLhAXlUo1JvwF/aCe1ZltEyb0n4N6cnNi6qdgqo2dkg3jd4wugrzsQwee5kUchqwrkjwjmUQ==
X-Received: by 2002:a25:1f41:0:b0:dcf:309d:cc2b with SMTP id f62-20020a251f41000000b00dcf309dcc2bmr7387950ybf.18.1710260098031;
        Tue, 12 Mar 2024 09:14:58 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id w130-20020a25df88000000b00dcd307dc310sm1820382ybg.56.2024.03.12.09.14.57
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:14:57 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60a0579a955so45697257b3.3
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 09:14:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyNWO8p9MBwf/en64HC/A1BfLhE2BsJlDEyFmAz0Z3RJMVN0rmaMMzHeUy3luI/eNpMoKgBz33dZ+ZneAydkExIZpfwAAjbhGRLkA=
X-Received: by 2002:a25:2b01:0:b0:dcf:fc74:358a with SMTP id
 r1-20020a252b01000000b00dcffc74358amr6857356ybr.10.1710260097591; Tue, 12 Mar
 2024 09:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312154834.26178-1-tzimmermann@suse.de> <20240312154834.26178-9-tzimmermann@suse.de>
In-Reply-To: <20240312154834.26178-9-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 17:14:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqWF=M=6aPRxZ0MBqPVM_wk2x+Oike6za754riHWusSA@mail.gmail.com>
Message-ID: <CAMuHMdVqWF=M=6aPRxZ0MBqPVM_wk2x+Oike6za754riHWusSA@mail.gmail.com>
Subject: Re: [PATCH 08/43] drm/fbdev: Add fbdev-shmem
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de, javierm@redhat.com, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, Mar 12, 2024 at 4:48=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Add an fbdev emulation for SHMEM-based memory managers. The code is
> similar to fbdev-generic, but does not require an addition shadow
> buffer for mmap(). Fbdev-shmem operates directly on the buffer object's
> SHMEM pages. Fbdev's deferred-I/O mechanism updates the hardware state
> on write operations.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/gpu/drm/drm_fbdev_shmem.c

> +static int drm_fbdev_shmem_helper_fb_probe(struct drm_fb_helper *fb_help=
er,
> +                                          struct drm_fb_helper_surface_s=
ize *sizes)
> +{
> +       struct drm_client_dev *client =3D &fb_helper->client;
> +       struct drm_device *dev =3D fb_helper->dev;
> +       struct drm_client_buffer *buffer;
> +       struct drm_gem_shmem_object *shmem;
> +       struct drm_framebuffer *fb;
> +       struct fb_info *info;
> +       u32 format;
> +       struct iosys_map map;
> +       int ret;
> +
> +       drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
> +                   sizes->surface_width, sizes->surface_height,
> +                   sizes->surface_bpp);
> +
> +       format =3D drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->s=
urface_depth);

Oops, one more caller of the imprecise
let's-guess-the-format-from-bpp-and-depth machinery to get rid of...

> +       buffer =3D drm_client_framebuffer_create(client, sizes->surface_w=
idth,
> +                                              sizes->surface_height, for=
mat);

[...]

> +}

> +/**
> + * drm_fbdev_shmem_setup() - Setup fbdev emulation for GEM SHMEM helpers
> + * @dev: DRM device
> + * @preferred_bpp: Preferred bits per pixel for the device.
> + *                 32 is used if this is zero.
> + *
> + * This function sets up fbdev emulation for GEM DMA drivers that suppor=
t
> + * dumb buffers with a virtual address and that can be mmap'ed.
> + * drm_fbdev_shmem_setup() shall be called after the DRM driver register=
ed
> + * the new DRM device with drm_dev_register().
> + *
> + * Restore, hotplug events and teardown are all taken care of. Drivers t=
hat do
> + * suspend/resume need to call drm_fb_helper_set_suspend_unlocked() them=
selves.
> + * Simple drivers might use drm_mode_config_helper_suspend().
> + *
> + * This function is safe to call even when there are no connectors prese=
nt.
> + * Setup will be retried on the next hotplug event.
> + *
> + * The fbdev is destroyed by drm_dev_unregister().
> + */
> +void drm_fbdev_shmem_setup(struct drm_device *dev, unsigned int preferre=
d_bpp)

As this is a completely new function, can we please get a
preferred_format parameter instead?

> +{
> +       struct drm_fb_helper *fb_helper;
> +       int ret;
> +
> +       drm_WARN(dev, !dev->registered, "Device has not been registered.\=
n");
> +       drm_WARN(dev, dev->fb_helper, "fb_helper is already set!\n");
> +
> +       fb_helper =3D kzalloc(sizeof(*fb_helper), GFP_KERNEL);
> +       if (!fb_helper)
> +               return;
> +       drm_fb_helper_prepare(dev, fb_helper, preferred_bpp, &drm_fbdev_s=
hmem_helper_funcs);
> +
> +       ret =3D drm_client_init(dev, &fb_helper->client, "fbdev", &drm_fb=
dev_shmem_client_funcs);
> +       if (ret) {
> +               drm_err(dev, "Failed to register client: %d\n", ret);
> +               goto err_drm_client_init;
> +       }
> +
> +       drm_client_register(&fb_helper->client);
> +
> +       return;
> +
> +err_drm_client_init:
> +       drm_fb_helper_unprepare(fb_helper);
> +       kfree(fb_helper);
> +}
> +EXPORT_SYMBOL(drm_fbdev_shmem_setup);


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
