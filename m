Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116ED1E866
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729370; cv=none; b=nW5kgE4AEYZBfu4jr3nQkOuNSgK62n+e0BmDYEaKbO23UAnPpam6zH2IeEmEdKsgMmMNk828ib1XaDj9RjFnnmUGrwBQX5eQdAmHDoN+ue3sf4/7wIBZjEl/KI4jt1frhQaqzSR4hNET3ekehtbOnFxdNIbjdcYbA+H4zD+Ex2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729370; c=relaxed/simple;
	bh=aE7cMjzEli5RA10NMhV+qAuRtVdMkyVO37/DBmmyLVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvcD1i0XU3b9T7KfPYoUG4lXHBNbYJc9xC3vEg2+WBFrySWuHRDcg5jlo7oZ/4b5jqAjMMKDD3LG/eDeB5CmOI5ELyuw13T7kNVOjXoHmoZRca7jABgSKfG5RzBGKO/GIKnz8RErOFQDO/5fFqMRqScXXdEpqw8/om5Hr0qu8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B8M+Ppsf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B8M+Ppsf"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609408d4b31so37484417b3.0
        for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 19:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1710729368; x=1711334168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onywNPKbW4SZgpTt9qm8DWaaYeZm4QLeQe7ttJakLWY=;
        b=B8M+Ppsf45gDfdzdV23G14eHOdWpL+2UyeKvMxcaPBWi9F0Edki3qZ2UvKP4+UDwoT
         L7unpb2Zje552Av+F2fRuFHFSSi3FzPnOlPp0/8p+QnbyD1/CudGxfYc668mQNfZkKdP
         T9m90anWMgfRlkRdQLhrzq1WmVHVPp0iFdCPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710729368; x=1711334168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onywNPKbW4SZgpTt9qm8DWaaYeZm4QLeQe7ttJakLWY=;
        b=OBmQcV/0fveiHbO3Nf5Y/z9mWk1jhFXiW5Ye3uYNwuqUVX2qDIB2ZDVg8sNmshqn6L
         t0d5WIMEcvujsvR5Fvc3IfTu6MK/NRRzeoOJKRaMeZrUF1Ff6JL8glUSCFR0X6/HrdCr
         fgkyZhosRgkRS8czlerbpVGpIV//2iYmUt8j6ftdW96sJBVBTnDtrbDhUflhYSXkQr/d
         cqcxNtAMlxBoYowR97OZyoI4kRsGkHUYzLW9l/pWOU8PRYtrrxVbUxt6cnbUPEkuPXb7
         3CCZxla0LvzLpLEEXkb8vgRyP5++Rhst4DKvEbD0Qwn+5hTSi+A+W4+KZwlSjJx3xF0Q
         bYog==
X-Forwarded-Encrypted: i=1; AJvYcCW6GJLOz+/sp6loXA1GOlXkAUUFF759q6LvAbNU1QBP1IFQ++DnvVozPcrKhqwH8siZ67G/rM2eZu3WaCYuxoT8Xw/rQdmF6ewu+uc=
X-Gm-Message-State: AOJu0YxDaSSVmssdyEVbm3GEByfH20YVUTAzYU9RRatPT2oxvTCwfGJ2
	02Yh9HPKoTux6JxenCMAjFNPVQnmqfwJR0CL3OUjDMnQj+uAXMrAZfS+J/z5eDiUbRTWjCYbW+g
	iPy9DUEUBtJfc1D8TEpKDf2J+YtN9wvRjkCKVu1BdNlIOruuUVQ==
X-Google-Smtp-Source: AGHT+IF8Ma8x3gNXeQfamz040zfqaKcyTg7HlRt8R3vClPLYzuMu0ectkxpFm+mVy3jO+dqSXQ9+jI2cike4if/mGQo=
X-Received: by 2002:a81:8410:0:b0:60a:7cc:24ab with SMTP id
 u16-20020a818410000000b0060a07cc24abmr9714623ywf.37.1710729368080; Sun, 17
 Mar 2024 19:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312154834.26178-1-tzimmermann@suse.de> <20240312154834.26178-2-tzimmermann@suse.de>
In-Reply-To: <20240312154834.26178-2-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sun, 17 Mar 2024 22:35:57 -0400
Message-ID: <CABQX2QPJJFrARdteFFZ8f33hvDx-HSyOQJQ7AMFK4C8C=BquTQ@mail.gmail.com>
Subject: Re: [PATCH 01/43] drm/fbdev-generic: Do not set physical framebuffer address
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de, javierm@redhat.com, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Zack Rusin <zackr@vmware.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:48=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Framebuffer memory is allocated via vmalloc() from non-contiguous
> physical pages. The physical framebuffer start address is therefore
> meaningless. Do not set it.
>
> The value is not used within the kernel and only exported to userspace
> on dedicated ARM configs. No functional change is expected.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Zack Rusin <zackr@vmware.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: <stable@vger.kernel.org> # v6.4+
> ---
>  drivers/gpu/drm/drm_fbdev_generic.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fb=
dev_generic.c
> index d647d89764cb9..b4659cd6285ab 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -113,7 +113,6 @@ static int drm_fbdev_generic_helper_fb_probe(struct d=
rm_fb_helper *fb_helper,
>         /* screen */
>         info->flags |=3D FBINFO_VIRTFB | FBINFO_READS_FAST;
>         info->screen_buffer =3D screen_buffer;
> -       info->fix.smem_start =3D page_to_phys(vmalloc_to_page(info->scree=
n_buffer));
>         info->fix.smem_len =3D screen_size;
>
>         /* deferred I/O */
> --
> 2.44.0
>

Good idea. I think given that drm_leak_fbdev_smem is off by default we
could remove the setting of smem_start by all of the in-tree drm
drivers (they all have open source userspace that won't mess around
with fbdev fb) - it will be reset to 0 anyway. Actually, I wonder if
we still need drm_leak_fbdev_smem at all...

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z
