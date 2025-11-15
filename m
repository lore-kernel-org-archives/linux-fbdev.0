Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EB191F84
	for <linux-fbdev@vger.kernel.org>; Sat, 15 Nov 2025 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763191798; cv=none; b=A5oPPC1QR9hqpxBwUZPPdAWgzWnHmwa918uOgZmS1ahqTtXiT8FUS8ZNJCa5la7BrYIHchjjfGKG53W20QuiOtuPm+sBr/44cM3tThq0oUVWc0EpvC5QvvHRAmtWWN51Ggzt+vBOQ3XtaRfCXrRH7Titdf5G55G1zX1j+Sez8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763191798; c=relaxed/simple;
	bh=geYzj009jxkO4qyOwx+N+7+rqPnnqIfShACp+oeXbsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPSFCtgVXsFRH9Ge448J4fdcFqQ4UryTIvubrm8ZQiCy3g4qauCcFfBLZ+PjmsgcmZ6q68j5zMU6V6mGYHbGvm7Jcyrlrhotw8tqFqaLd+prNwr6OSYr/B4d8dPQZSSw8jOZeMUWBsNuQVhl8LjeQcLEAv27KD3RQO4Ia8clyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH+z2uE4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH+z2uE4"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so4157881a12.1
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Nov 2025 23:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763191795; x=1763796595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCPqxsFa6KDnq/UuyZpBimWkGLy2aEdXnS+xKFhpcAE=;
        b=UH+z2uE45h19ymLgNnE7eA/0NzjYNbCKixJjIFctKzMNKwiAX3k/ekU9rIJ2AD52Rg
         esB2Xt5tfC1L7GZM+5dghjQiy2u83U0SCFsOA6+sAdZ2m8U8loKJXC6DyB0yaQTP54c/
         ASA6P25ftHd5WZfkuNZOnkWLfTxegh/LhNmS0YCXRiQuNlL/LL4dzeM4Uk89pxTBKKnb
         bhpOSeB1HDFv+jYCL+PgG/78nz6mo0GKMewI9I9pJi5pSy8WlZOFfhfd1+smT30+XYUz
         19/oP0laqTsRbWyRsRwOgAE5QtAq6H/RWSv8BV5zPROOFq+9EzDwvOTZWI+WZmovODOD
         Ly/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763191795; x=1763796595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCPqxsFa6KDnq/UuyZpBimWkGLy2aEdXnS+xKFhpcAE=;
        b=AAs7jlu8nldNVvfjze8Pz2ul60P8xjzA6r5u+AfCwer3nQN0+XfmzPskjKhWuURXvH
         Ug6t5hcm4J6xUdloATrTNI/0X2e4jih8YtkS4xn2oUXinf7Mf0hoeEnUuLMdmyQib921
         C+nT0FHhvgVpdSzCmejKPVGC0uPqr/PeILbZpOr6g6o1E+wLa2iN2xFN0POSA1PU0qkc
         cXGEWksFzG3G644q0Nega0FMUoBNv1f3Ik1BLduqFJpSEgKHPn5qN+LDa3vdkorDE+bN
         rn+PdGmKJKQefbzfhYfsCrO+ptdG4OgJ1zLZgs87KSppOk5GQL271byamZH+dQzYHyWc
         kbVA==
X-Gm-Message-State: AOJu0YzuU6MQ6hxhVpdBw313Clt+6pHunrUXEEn7YZgZDTW7pCSTf+D3
	8MpJ93B6a6+Q/opg/75FQBswcfdqh4VIlMLBmPR3peUL4G0RjV1Q23MF6SjB8MLoaAvAe+lpn/U
	7WMjPvFp7OR0p10wpTfIOHwhL9iQmj9Y=
X-Gm-Gg: ASbGnct34NmlV5znN3KdtbQf9OpNRfI3PeWoUi+PDd6vAbodfnzMIHFLbJx0X1koBdq
	jyDNVu3Fb3Vgti1BkIhFrJxlrip5XtBe2+ObXdZzA1pAxauCLpiOFKsL0+ZBW087t/oMspAEAh/
	DyPIXigaHT47iGbZmtzwjUYsRoClLaoaEptPOqrBwplgt8mqNh/gSg+Q9kFQg4IoSOtDzLhDahx
	0nnJYPFPM+fPCiDF64oGoxoQQ0PFZqhDiM67k7yhIe7XbB8KlfRHG95kskR0+zKOuPSYUWDpRmq
	usnWvUSUCdXaM5Xb5KfCCOqE
X-Google-Smtp-Source: AGHT+IGFFlGriMdbkcAdxD5aaCkp09loEuvc59rIUdShi5eQS0NgZzUUo2H3BlPjMa7UMiDXEWxdnGVvOoc2N0htRpw=
X-Received: by 2002:a17:907:1b02:b0:b6d:552f:e400 with SMTP id
 a640c23a62f3a-b7367869cb4mr576169166b.3.1763191795022; Fri, 14 Nov 2025
 23:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110090446.2910998-1-rampxxxx@gmail.com>
In-Reply-To: <20251110090446.2910998-1-rampxxxx@gmail.com>
From: Javier Garcia <rampxxxx@gmail.com>
Date: Sat, 15 Nov 2025 08:29:43 +0100
X-Gm-Features: AWmQ_bnALRQasujF1SCDe3eociVFBy6ZIjVZttvGy2QuDowEndVcbLwZYJTKm2Y
Message-ID: <CABPJ0vj9+qWo54X6Rg19kCgdQSpKoP_69Byfj0bjGNXys9LoCQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev/vga16fb: Use dev_* fn's instead printk.
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Helge Deller, any comment on this patch?

---

Javier Garcia

On Mon, 10 Nov 2025 at 10:04, Javier Garcia <rampxxxx@gmail.com> wrote:
>
> - Family dev_* fn's will show device name, giving extra info to logs.
> - Delete the prefix `vga16fb:` from msg strings, not needed now.
>
> [    1.037947] vga16fb vga-framebuffer.0: initializing
>
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
>  drivers/video/fbdev/vga16fb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index 3b4c50d98ba6..432ba7c8164b 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -1324,7 +1324,7 @@ static int vga16fb_probe(struct platform_device *dev)
>                 dev_err(&dev->dev, "vga16b: cannot reserve video memory at 0x%lx\n",
>                        vga16fb_fix.smem_start);
>         }
> -       printk(KERN_DEBUG "vga16fb: initializing\n");
> +       dev_dbg(&dev->dev, "initializing\n");
>         info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
>
>         if (!info) {
> @@ -1336,12 +1336,12 @@ static int vga16fb_probe(struct platform_device *dev)
>         info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS_BASE, 0);
>
>         if (!info->screen_base) {
> -               printk(KERN_ERR "vga16fb: unable to map device\n");
> +               dev_err(&dev->dev, "unable to map device\n");
>                 ret = -ENOMEM;
>                 goto err_ioremap;
>         }
>
> -       printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
> +       dev_info(&dev->dev, "mapped to 0x%p\n", info->screen_base);
>         par = info->par;
>
>         par->isVGA = screen_info_video_type(si) == VIDEO_TYPE_VGAC;
> @@ -1369,13 +1369,13 @@ static int vga16fb_probe(struct platform_device *dev)
>         i = (info->var.bits_per_pixel == 8) ? 256 : 16;
>         ret = fb_alloc_cmap(&info->cmap, i, 0);
>         if (ret) {
> -               printk(KERN_ERR "vga16fb: unable to allocate colormap\n");
> +               dev_err(&dev->dev, "unable to allocate colormap\n");
>                 ret = -ENOMEM;
>                 goto err_alloc_cmap;
>         }
>
>         if (vga16fb_check_var(&info->var, info)) {
> -               printk(KERN_ERR "vga16fb: unable to validate variable\n");
> +               dev_err(&dev->dev, "unable to validate variable\n");
>                 ret = -EINVAL;
>                 goto err_check_var;
>         }
> @@ -1386,7 +1386,7 @@ static int vga16fb_probe(struct platform_device *dev)
>         if (ret)
>                 goto err_check_var;
>         if (register_framebuffer(info) < 0) {
> -               printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
> +               dev_err(&dev->dev, "unable to register framebuffer\n");
>                 ret = -EINVAL;
>                 goto err_check_var;
>         }
> --
> 2.50.1
>
