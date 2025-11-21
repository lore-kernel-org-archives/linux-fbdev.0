Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F87346E6D
	for <linux-fbdev@vger.kernel.org>; Fri, 21 Nov 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734562; cv=none; b=UNeCbpEFCtBHWwR1utmF3+BVVXgbIbMb4Ix/Zz0b1iTckklcN7Ty4rKo59C9gj33U20l8AylI3CN1RLBOZvwMmssrtvPWRKlXWIOhE15KvNsq3K7Qv+Jjwr0yxJuzgsPzdHQexoSWOv7q8hfEo+IMZtfuUIYoT/ZHksZb77rXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734562; c=relaxed/simple;
	bh=iQzaL7jLbowTcSmbzU5exSXk0PVpLYQsdVZ8usVa2ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAJMmJIBstE546TsgoQ//hIr8FSf/OsA9SC4lfoytRdp5HERgGX4uMNAVr+Y9M9djRVeB+bVfzFTf2eX8mqit9ZLhGcSW5u5XtRUmU797NBLHxQiODJ23jauoECOUm36B470NoPvsiCcablkXTwJ7w1HUeZ7tlVD7GpmPMsckAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsinUI66; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsinUI66"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b9a5f4435adso192263a12.3
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Nov 2025 06:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734559; x=1764339359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MWxC2YhPO2+lW4WlCwywZFk2iw3f1gK24sM/ejKzwM=;
        b=gsinUI66qL7cH+uif6KJCf4YVQ0PFBZ29Po/SUKlDAht9G/oO0xpM/6GEihK6CCjP3
         X5YLeaLGrRMDQobavgtIQyysDJZFwsxbv2PqsWtThq+igYIGZskFUdiWwXFKINcqGtpy
         eoz6bmUAt3tREJyDJ4yK3U9E6eZ1rfYkn17wVJjgurgOYAcNtOtR0+ajI0alK0fTQugI
         CMFEne1f1FnYcmjoYWheq6q0YIrXgWR4WRaXT340v+EQGuU8TRBQJICbQhn379313eQ1
         y2cubNkl2Ib2knE+FvVqZ9BLtsKjFDKiWLk8p4nHJZlf1j4gg99z6+jTDIWLPfT1nLPv
         20zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734559; x=1764339359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5MWxC2YhPO2+lW4WlCwywZFk2iw3f1gK24sM/ejKzwM=;
        b=GwpJGapJpj7N3uQKFjcMsTDtXEC7CeNMiFq15QVhejgYgjji2JE/PVW1At5kUVBh6w
         mUlAEfyht7HxBDPdv/fkawk9+XUnjlucAKbpYjVg1bN3/4v3AKevgCivREDv2t8nZYgY
         2nV8KDtt0Z9XDH9lge5hRdpY8RgOSnMrBbegeEjNUuMBnsZQEU5EwB6/EU/0yd7RDkit
         2YP3I9KvMsAZVaZIzZadOgQ9s4+QpnPhY+VCVdmugi2C1+E1CK9eXqP3Z5vDOADfsjvz
         4lY9GVROGUqnK52xb7ONBgW/4i6EZQlcu/gUGZ4SR0YCtzxhTZv+9PbIbIgNmfNhA+FH
         CjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT9VkCKt780+3w5xmlXLBB/jzgKl8fauifX3CC7jXqDBAE3lmdZiScUG6KV5dfiFZ3Y4R1nftZmkkQSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWCRRErPQgyO7mKI9ti5G3Kn9aIq6PufJVT1Rt27fCN6AohA4
	gUoR+v/6m2mmXRgAY+EqFm9gfCgvf7iC2LJb+C1u89Mliyvz3XudWS3+5QBICg8u7wtNjhpo8Kg
	ESaxP1Ks7pFBS/38y7QiBVm+wpgb2zxM=
X-Gm-Gg: ASbGncuIDqZKTcFIHQLfhy2swyo72uzxXfj0g7kNhc4FMUGE7AiXiWSGbm7tzdNSsYB
	QLXddtTvCdKe00LK+37OVo+ySdx7FE8qHM6Bt8Si3hMJsXJ8bo3uYyKUfb4wh4rJlnVzTroMSrK
	kNJzIsCoxCG5B37tCIZDEbzM2i7I2PmgPFvXuoftVV1qVpfwTLr0o8IcIEQO3FKlDyfY2gH+/vF
	vJP2qtTOyTs1ybZdGeCBLgpihJhbfhkV05sECDHGjRHwbBtZxuVl6qKxUHz37qKMVHMJvQ=
X-Google-Smtp-Source: AGHT+IENNBsMiPMhPy3lT/U29kCAz8EhETos7u4tDbMZpsFNaH7g8mAAzjnWnak60cGVE1du7ZLcOXG2yYUr36WWFOI=
X-Received: by 2002:a05:7022:ea46:10b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11c9d8678famr562401c88.3.1763734558436; Fri, 21 Nov 2025
 06:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105161549.98836-1-tzimmermann@suse.de>
In-Reply-To: <20251105161549.98836-1-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Nov 2025 09:15:46 -0500
X-Gm-Features: AWmQ_bkmPcz6UOA5gnGN71prOwzhOn3ELTZMpuodtRV8RF55H-zW-7y7h8dHDxI
Message-ID: <CADnq5_OUBpnwM09QrRae=4SoJZuoVE=rfJZwpGrg1XDq84uRxw@mail.gmail.com>
Subject: Re: [PATCH] drm, fbcon, vga_switcheroo: Avoid race condition in fbcon setup
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, deller@gmx.de, lukas@wunner.de, 
	ville.syrjala@linux.intel.com, sam@ravnborg.org, javierm@redhat.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:11=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Protect vga_switcheroo_client_fb_set() with console lock. Avoids OOB
> access in fbcon_remap_all(). Without holding the console lock the call
> races with switching outputs.
>
> VGA switcheroo calls fbcon_remap_all() when switching clients. The fbcon
> function uses struct fb_info.node, which is set by register_framebuffer()=
.
> As the fb-helper code currently sets up VGA switcheroo before registering
> the framebuffer, the value of node is -1 and therefore not a legal value.
> For example, fbcon uses the value within set_con2fb_map() [1] as an index
> into an array.
>
> Moving vga_switcheroo_client_fb_set() after register_framebuffer() can
> result in VGA switching that does not switch fbcon correctly.
>
> Therefore move vga_switcheroo_client_fb_set() under fbcon_fb_registered()=
,
> which already holds the console lock. Fbdev calls fbcon_fb_registered()
> from within register_framebuffer(). Serializes the helper with VGA
> switcheroo's call to fbcon_remap_all().
>
> Although vga_switcheroo_client_fb_set() takes an instance of struct fb_in=
fo
> as parameter, it really only needs the contained fbcon state. Moving the
> call to fbcon initialization is therefore cleaner than before. Only amdgp=
u,
> i915, nouveau and radeon support vga_switcheroo. For all other drivers,
> this change does nothing.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://elixir.bootlin.com/linux/v6.17/source/drivers/video/fbdev/c=
ore/fbcon.c#L2942 # [1]

I haven't paged switcheroo into my head in a while, but this seems to
make sense so:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/drm_fb_helper.c  | 14 --------------
>  drivers/video/fbdev/core/fbcon.c |  9 +++++++++
>  2 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 53e9dc0543de..c0343ec16a57 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -31,9 +31,7 @@
>
>  #include <linux/console.h>
>  #include <linux/export.h>
> -#include <linux/pci.h>
>  #include <linux/sysrq.h>
> -#include <linux/vga_switcheroo.h>
>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_drv.h>
> @@ -570,11 +568,6 @@ EXPORT_SYMBOL(drm_fb_helper_release_info);
>   */
>  void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
>  {
> -       struct fb_info *info =3D fb_helper->info;
> -       struct device *dev =3D info->device;
> -
> -       if (dev_is_pci(dev))
> -               vga_switcheroo_client_fb_set(to_pci_dev(dev), NULL);
>         unregister_framebuffer(fb_helper->info);
>  }
>  EXPORT_SYMBOL(drm_fb_helper_unregister_info);
> @@ -1614,7 +1607,6 @@ static int drm_fb_helper_single_fb_probe(struct drm=
_fb_helper *fb_helper)
>         struct drm_client_dev *client =3D &fb_helper->client;
>         struct drm_device *dev =3D fb_helper->dev;
>         struct drm_fb_helper_surface_size sizes;
> -       struct fb_info *info;
>         int ret;
>
>         if (drm_WARN_ON(dev, !dev->driver->fbdev_probe))
> @@ -1635,12 +1627,6 @@ static int drm_fb_helper_single_fb_probe(struct dr=
m_fb_helper *fb_helper)
>
>         strcpy(fb_helper->fb->comm, "[fbcon]");
>
> -       info =3D fb_helper->info;
> -
> -       /* Set the fb info for vgaswitcheroo clients. Does nothing otherw=
ise. */
> -       if (dev_is_pci(info->device))
> -               vga_switcheroo_client_fb_set(to_pci_dev(info->device), in=
fo);
> -
>         return 0;
>  }
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 7f35ad66b462..863944530c8e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -66,6 +66,7 @@
>  #include <linux/string.h>
>  #include <linux/kd.h>
>  #include <linux/panic.h>
> +#include <linux/pci.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/fb.h>
> @@ -78,6 +79,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/crc32.h> /* For counting font checksums */
>  #include <linux/uaccess.h>
> +#include <linux/vga_switcheroo.h>
>  #include <asm/irq.h>
>
>  #include "fbcon.h"
> @@ -2894,6 +2896,9 @@ void fbcon_fb_unregistered(struct fb_info *info)
>
>         console_lock();
>
> +       if (info->device && dev_is_pci(info->device))
> +               vga_switcheroo_client_fb_set(to_pci_dev(info->device), NU=
LL);
> +
>         fbcon_registered_fb[info->node] =3D NULL;
>         fbcon_num_registered_fb--;
>
> @@ -3027,6 +3032,10 @@ static int do_fb_registered(struct fb_info *info)
>                 }
>         }
>
> +       /* Set the fb info for vga_switcheroo clients. Does nothing other=
wise. */
> +       if (info->device && dev_is_pci(info->device))
> +               vga_switcheroo_client_fb_set(to_pci_dev(info->device), in=
fo);
> +
>         return ret;
>  }
>
> --
> 2.51.1
>
