Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FE6D1BC
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266723; cv=none; b=qi1dVfMGFIR1arWzEPQdMvEhl71hG5BxXnhTARJ4LcVNgBQqwt9XPWCaifxtPP56wl75elbv7bmCJ7B+n2tma2YTaBat1k37yPBXNV+o3xWKDCSJ0OdvVztbImdEMu6sNk2++BgmQUrJ1CZ3c9EvfWtjwF+ttlcBLBg5jh1SRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266723; c=relaxed/simple;
	bh=I6SA7ZOPfLQq34QohgMHb1n4SDAKKoTsRsbV7KWatyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJGhH548mlZnSFPr+qbNecpXvevBmaHGUJBkA7tnczpI8MdCGAma1gnfUIUTXZqv79ahvJdU4zeLbjhApbEUMlDhQ46YhPLgnzVpx0vQdIJJ/9QR9tBVMgng5/FIBVloAaRyQXtDpo0OFckI7PLFWF8lqVvdE1v2koDi6nHwD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRNBxvPK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRNBxvPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713266721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ex8M2eUSrqol5mdKpIM6VBOTBreND3Uj020NiVxFyYY=;
	b=aRNBxvPKhQ2+pqHI08Vc898hepP/Ol1ZwtvcwODoiR9daHxLmJ4rjqgnaFLAODfryRqjUE
	gctTr6158i1hVRGCzuIOgfXrUFtUbKGjX9yR506eOAuL2qWRkTTW1Z3vLincpPGLih4Aau
	i27kihDwpDrJORXcI1+0RvRdP147axE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-Ua5EC5dMO56zKOkSFmQtqA-1; Tue, 16 Apr 2024 07:25:19 -0400
X-MC-Unique: Ua5EC5dMO56zKOkSFmQtqA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-347ddb973dcso1192573f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 04:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713266718; x=1713871518;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex8M2eUSrqol5mdKpIM6VBOTBreND3Uj020NiVxFyYY=;
        b=SEFT4xEkTW71QEondg2kwJpzVjoXJ/gxK64WQlr+DSC8SUFyleZ5VONZg/KFgNLKbv
         FZWSM4W19uqVhUFZCQdejO5SoSWvgXsdcvhIYT9onIrpTOaJu79UHPj+9Avgz74n7WQz
         qIu8baWd6x4iS2SrEtjx8l93iRPNIlKE6RTtiSJNh8Jzu4enOJd6ziACZ1YP0FsW2Cqc
         JJuJFNNTBecdg3A2Y1MrV5C9T70bQCvbBBgvIbnVXcwCO/ugpDMBsCXqKVXRAplBUcIE
         ijPYWOEPwk1zyLfYtDVG+rcOYiSQyaX3WYwE4efMNege0yDfcp7JakgEvkl2QrgMK/32
         nd9w==
X-Forwarded-Encrypted: i=1; AJvYcCUDifQ3CPRTYIgDR3SIVRUY2udj7e7PQDHyCBVh2Y39i4v/tfbpzV65BnZz3nw9Q8uMDhh6kFJCp+LA1mU+nEOYDxbZnEyrTjlyceY=
X-Gm-Message-State: AOJu0Yxx8U3ErhJQP6CgDcbZswuL0+VFU5HApMTZvZV39eCZL94z1/90
	+afJcflZHBB25nVgYMsNJq4ghDCHRmbiPlrb9jPVCxTjeggheWfgYNUfM+sXSl5UvcuDO2J0ycs
	G9+5DrT9VimeyKNXDvGVCtRubrMDNJUExkji7U6X2eSf7ulBeaQJamEK0JBPL
X-Received: by 2002:a05:6000:2a5:b0:344:4bcc:ed1f with SMTP id l5-20020a05600002a500b003444bcced1fmr10733583wry.48.1713266718463;
        Tue, 16 Apr 2024 04:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELh1gKQ5KIugCykRbfLLKHDM0Vqca/5AttN7+4ay1nW5utMb8nudTZjhnvKQ3OxjAJA2GeSg==
X-Received: by 2002:a05:6000:2a5:b0:344:4bcc:ed1f with SMTP id l5-20020a05600002a500b003444bcced1fmr10733566wry.48.1713266717981;
        Tue, 16 Apr 2024 04:25:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d6245000000b0034334af2957sm14613490wrv.37.2024.04.16.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:25:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 08/43] drm/fbdev: Add fbdev-shmem
In-Reply-To: <20240410130557.31572-9-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-9-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 13:25:16 +0200
Message-ID: <87r0f54kir.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Add an fbdev emulation for SHMEM-based memory managers. The code is
> similar to fbdev-generic, but does not require an addition shadow

"additional" I think ?

> buffer for mmap(). Fbdev-shmem operates directly on the buffer object's
> SHMEM pages. Fbdev's deferred-I/O mechanism updates the hardware state
> on write operations.
>
> v2:
> - use drm_driver_legacy_fb_format() (Geert)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Just a couple of questions below:

>  drivers/gpu/drm/Makefile          |   1 +
>  drivers/gpu/drm/drm_fbdev_shmem.c | 316 ++++++++++++++++++++++++++++++

Should fbdev-generic then be renamed to fbdev_shmem_shadow or something
like that ?

[...]

> +
> +	/* screen */
> +	info->flags |= FBINFO_VIRTFB; /* system memory */
> +	if (!shmem->map_wc)
> +		info->flags |= FBINFO_READS_FAST; /* signal caching */
> +	info->screen_size = sizes->surface_height * fb->pitches[0];
> +	info->screen_buffer = map.vaddr;
> +	info->fix.smem_len = info->screen_size;
> +

Do I understand correctly that info->fix.smem_start doesn't have to be set
because that's only used for I/O memory? 

Since drm_fbdev_shmem_fb_mmap() calls fb_deferred_io_mmap() which in turn
sets vma->vm_ops = &fb_deferred_io_vm_ops and struct vm_operations_struct
fb_deferred_io_vm_ops .fault function handler is fb_deferred_io_fault()
that calls fb_deferred_io_page() which uses info->fix.smem_start value.

I guess is OK because is_vmalloc_addr() is always true for this case ?

This also made me think why info->fix.smem_len is really needed. Can't we
make the fbdev core to only look at that if info->screen_size is not set ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

