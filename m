Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660301DFF0
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269913; cv=none; b=dSt3yKrggpV4yTpyyfINir/NWgFufRd/Y6rKl533Cjs0rScH+h/tJk5WC/2KvNgjkd5bzW0OXlPfdZUodNCf/BZFgL4nVB1KtOQIAnmIN/qgW1BydNHnXDPUB5/uO/4zMOvAsU7MtwssJt/wsq+wHsr5D+6WZM4G+uo4lhTkmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269913; c=relaxed/simple;
	bh=S8q4ds0W4SlZXhh1muvXEK33H2zgrS4y6YKbE4UpQOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EEe62lun8YvCJkbmDGIZcn+5brrVHyq2yTjWwqWQ/eT9sQJQ6wEQ6zBQJFV1B5aGHfksDtlq1sxeI9Gb9+EIpdkbxCppj+WSJDIO+BxLjEbGOSBgTo+1Ue+9I8m0gyMlz8GGCGTl+LGwStcxn2XjeKxzvWtxqD6zhD2l5oLtl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biSSFnj4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biSSFnj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713269910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JExSW1bgx6Guvm51zO+5lwyoRpmXnChQqd095oH6F3E=;
	b=biSSFnj4Ep+k1CHf6Vyl6szhb3udJGZa8aLI+oEtbtOx9VslZphSNcWnp+QBiG5gSHpUGF
	CiA+WzJuPzvVZlwu15MMfQfAIN8ZHycOfiD2mARYaxEWtN5VW2fhcXvCkQyip9tfQZy7vE
	CEKvMwgvaQC69+8eWgIs8XVLcuzrE0M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-IzPMIhjzPpWo7p4OGD0XUA-1; Tue, 16 Apr 2024 08:18:28 -0400
X-MC-Unique: IzPMIhjzPpWo7p4OGD0XUA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343da0a889dso3337102f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269908; x=1713874708;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JExSW1bgx6Guvm51zO+5lwyoRpmXnChQqd095oH6F3E=;
        b=bk1tufVRjp3aPUnLdAHO2Gah8SHGlHGawlRG3C3PRn0xuZjj9/ZJMjFGzD0AdA25OL
         DGJ46eqS7hlrjsgxEqEjLvfjWtE7yNIEdq83Uqd9Fy+5voyOOA2mi3T8d68I10T0C92l
         EAmvfapJuhwquuiIbk7tCa6W4j4Jl5ENOZJaq0y/805ILee8pz3xNa8EpU1AnK0HnKP5
         EqHW6J0UJFx0luKY51/Lg2N2Xd+mCmcVUvVOIey2gJl3n0j8Rv72JXVRk9/hUlgbsDOz
         vJbXDtuLs6p5uyjA7LHSh2EifgpNgR6yJfeQXfOe78YuSfldDOHl6y5wlOpJ/8WmeAil
         b1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWYDpu/L1cYx2xZXWpq6JMAQBR2AWXhRkE09eqYuaBdH+4XSqkjOnKi6oE4O8Y1lZH0j8RA30VY2z5z/jKJ4WSzDbtZoXXBkBv6Kc=
X-Gm-Message-State: AOJu0YwAHGoMqKLjWWPUu3n+fc5NjI2OzZlQBTtqMyGADRRhoEzFtCWK
	gqhr2dIG5XiWgJr5krTWJ1Bf5kQkhLvxUlOrMJnN0c0wR1kHWTdPoj9bpfsBsbQniG3RiHJy4ne
	2pgR3o7nDQdVaAB0ND+5FWF0m0FV38SZWW3wvgT21w0EIn6OI1vOP06cCX9iY
X-Received: by 2002:a5d:4647:0:b0:347:5354:887d with SMTP id j7-20020a5d4647000000b003475354887dmr6696528wrs.29.1713269907705;
        Tue, 16 Apr 2024 05:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkRrL2ulGispYQmJGW59tbmsI+WOXUHqw3GeE49fNHEQvJ6OWcSSkCiy/0rKbUjewdpOtz2A==
X-Received: by 2002:a5d:4647:0:b0:347:5354:887d with SMTP id j7-20020a5d4647000000b003475354887dmr6696511wrs.29.1713269907261;
        Tue, 16 Apr 2024 05:18:27 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b003437799a373sm14633199wrb.83.2024.04.16.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:18:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 21/43] drm/fbdev-dma: Implement damage handling and
 deferred I/O
In-Reply-To: <20240410130557.31572-22-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-22-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:18:24 +0200
Message-ID: <871q757b73.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Add support for damage handling and deferred I/O to fbdev-dma. This
> enables fbdev-dma to support all DMA-memory-based DRM drivers, even
> such with a dirty callback in their framebuffers.
>
> The patch adds the code for deferred I/O and also sets a dedicated
> helper for struct fb_ops.fb_mmap that support coherent mappings.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbdev_dma.c | 65 ++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
> index 6c9427bb4053b..8ffd072368bca 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> @@ -4,6 +4,7 @@
>  
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_fb_dma_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_dma_helper.h>
> @@ -35,6 +36,22 @@ static int drm_fbdev_dma_fb_release(struct fb_info *info, int user)
>  	return 0;
>  }
>  
> +FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(drm_fbdev_dma,
> +				   drm_fb_helper_damage_range,
> +				   drm_fb_helper_damage_area);
> +

Shouldn't this be FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS() instead ?

I know that right now the macros are the same but I believe that it was
added it for a reason ?

> +static int drm_fbdev_dma_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +{
> +	struct drm_fb_helper *fb_helper = info->par;
> +	struct drm_framebuffer *fb = fb_helper->fb;
> +	struct drm_gem_dma_object *dma = drm_fb_dma_get_gem_obj(fb, 0);
> +
> +	if (!dma->map_noncoherent)
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);

I noticed that some drivers do:

                 vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));

I see that vm_get_page_prot() is a per-architecture function, but I don't
know about the implications of getting the pgprot_t from the vma->vm_flags
set or just using the current vma->vm_page_prot value...

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

