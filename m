Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEB377EC3
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021218; cv=pass; b=THm8/oPRyLeRneYCt4I3VntcLodY2prXGO1WxAJ0skxad83biyRiRXm5G85SBrckqjQJJY31h0HyxZ/3YcRb7gUcoBd34hw+YoOuQd1p9D1PMPI2F2/pUXeS4slxNgTksLXf0KZny9RutIW8BafuTJ15m1xaqvm8GSOpsYxGLlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021218; c=relaxed/simple;
	bh=b5Fu7zRQK6EautvTkFiYuCIJyBfEfmoqNLBoHhdoHa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayrwy/Tyt7xMI8ell4kix0LA7BbPlw2s/E3K9MBru5Q6BKuCxlgFeuXpQiPYGLEpiZte47wxHu3ixPm8prbyV15c49JLQkCAlDJYbMEqyqHHi0FjQbt4eHVX+Q6q5q74RzWjPoUIsedFDWatMkbamh/dSJQuEepC9Merhc6NFHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDSppFHJ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDSppFHJ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651c366f7efso8002260d50.1
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 02:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021216; cv=none;
        d=google.com; s=arc-20240605;
        b=BGkEwLbJTxQ1mgTkhmYOjociDwPycbl9d7TBKK0zSACPwVbimWihISAuSGQ4Y8atOq
         2McUpyT370kcnbJD2dvFcGCrIC/wFOeVCj9TNitnU3HtuIvRgHSa9dLPwBsANoLjeUoV
         JNPjK5sqsDondfChAu7kQDBCX9r3bcew1J68ivTHT/oXnGEjRrOPv+hD1qHfVQs125px
         zBALFCwojpao4dW4ix9YaY1OEy0iP6nIifBPpLKgMc+h+gQZj9ArFTR0DBo9PoxL5UkX
         sH+ZFBjNm5OnT/m+ueQmxOvkMCJ3a6og+ERY3uQtp4nxIjPWIAc/tb3bQekcNtBAlien
         WKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
        fh=h+nm1H1HQVJys6FY1ylZFf0NPPeWV0oQOft4z/+31s8=;
        b=Nd9sp0WwbRR+4FWQNQ88smoOegreRvNnkZrxj5/iHOyttTBNkOiVNJwkseUtwzgQz6
         mGP1tx15d1/r+aYqHl5yDfxUgZhteDNvcH+GWnVKOdrqBMm9hmHs996FqS1P6jAXFgYM
         T2MsJOFWI+K/MCZVvZzeiXPysOwC9tPts2Mb2lk9UX4MblLjQZ/z+VwT1uVtwu8czX1X
         9cRobn0VeXOdE6kLItLrXdbEcGr+sSQtQiSNEEgCysxAX3pdC+bUEIfbrwCXxrf/Urez
         4OpCfjrYTZY/fcLAsWbvI7LesuywakgVoDKZfBp7rFMHcctOQfmMtXi9YP/+AXvhKIDP
         r5YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021216; x=1777626016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
        b=KDSppFHJJrEtlZmOEbhrxJVHGUjeky2voipfmH19o3E4M5p1vy/Py0CgkVUbfd0nE3
         pARzgBW5jAPzIspY8xcijbisoi7jhIzsjpINEayv5kW+20Lymq1NTqON3lbCzSs6ZUEc
         sjnwPrpoxiKNmzdeFCuW+dOrz9oSrsvM6dNIGFpQLsBWxgsKMjjDlMsX6NCvp8Xyehgi
         zTjZaI0uOAjGJpMnUqAbT5g8BmIncILHDTRUpSBPdnVi4wmlxwgsSuEmeOufDQffAzG4
         pmlHULZoAQGDCStXgYYTMBs9ln9bMyFNG1HQKHxVMr73Xmwx3oK7bMOsdNjif4QpS28n
         oDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021216; x=1777626016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
        b=qyi8Jp/zEONs8Jq2U10SRPYRRIIAfQdOuhXQrYXieUtzp1Orgcs+QlPlp5azJjWgzb
         7OsQZwD1v20uIQK95SuXZn7ZLdn1mz5fEXujrjYWM392iGa/xRloRy1ox+inazqIX6SQ
         1SdlEHdPdzRvivrolBgkWbeUThj6akI9RzBx/c6bz4KFVC2W07tJxhCfSn6b3+KqEYrb
         dS2xrPCGr9fJ1RXYl7Bg7cpwIlVThQ1bK6KwX3CcRCMc52qOBlLZGctRNcfuYYjRj4tT
         MHWdzZ9vYbF5IiLM6Vr0pgnSOp9oYR2jnH+7frMWTwyZcpOL53dCGbeYvqgML3/plvTR
         Yosw==
X-Forwarded-Encrypted: i=1; AFNElJ8HFdV+z2dlhBgYUixaADf0/C0HVnheLvjNLh3StkGz4pvzkoY4bAkGb8ZeXjRGxPQYznEIx6h0bhBeXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoy2Kwgj50aprBNHP7lzlS/FpFyNWeBcejcDRo3upj/g9TUk9/
	PDtuTLLa+prKbXC2Elz+yv7UOc/+KuWPINvVVGw2mci2OzCihJdWBqiDzE8suT+og3T6YAq+i0M
	MpaEPWT+5BWgjQWJ7FqRyurmAWOP7bTQ=
X-Gm-Gg: AeBDievbKoQT9lO4SYArdT5G+pW3+zA9AomSQTcuvP4tdFnLZDAOU/4K4Xfaji3i5Oq
	1SsjzF5Qjgo5Vl0vShBAEsjIpcpjolzrxMF5Jfb0kf5tNw6YldjAeyvVuhtzi1ZHSJsf2fS+lkL
	Xk225TEPfIcjRY2JZX7aP8494EuisIN5/Zpqbx9lbMUikenCjOO/vQZD+kZzx/3d5vRJ+Z/JnpI
	4he9TTFthIDRddKpazHxOXS1YbKuNC+d8piqYVOVNPdLx8Fi5AqoszyH8g/i1pr37/01jlD8uB3
	z5vgCvy+5VvsFH0eN4e6
X-Received: by 2002:a05:690e:d0a:b0:653:1945:8fab with SMTP id
 956f58d0204a3-65319459b3cmr27855758d50.43.1777021216403; Fri, 24 Apr 2026
 02:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415191003.3829558-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415191003.3829558-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 17:00:01 +0800
X-Gm-Features: AQROBzDRuc7ifOf5Jk1J9tOCgnKOvndIrCp42i0bqZ5GOvl-P0LF9lO5bb2Mf9k
Message-ID: <CANUHTR_2RuqR95v3zRzqBsy2txTq2nBghi9PhMj_ek4VEBCHdQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: hitfb: fix reference leak on failed device registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
	Andriy Skulysh <askulysh@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 03:10, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in hitfb_init(), the embedded
> struct device in hitfb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   hitfb_init()
>     -> platform_device_register(&hitfb_device)
>        -> device_initialize(&hitfb_device.dev)
>        -> setup_pdev_dma_masks(&hitfb_device)
>        -> platform_device_add(&hitfb_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before unregistering the
> platform driver.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 048839dc548a5 ("video: hitfb suspend/resume and updates.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/video/fbdev/hitfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
> index 97db325df2b4..29708c2d506d 100644
> --- a/drivers/video/fbdev/hitfb.c
> +++ b/drivers/video/fbdev/hitfb.c
> @@ -495,8 +495,10 @@ static int __init hitfb_init(void)
>         ret = platform_driver_register(&hitfb_driver);
>         if (!ret) {
>                 ret = platform_device_register(&hitfb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&hitfb_device);
>                         platform_driver_unregister(&hitfb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, hitfb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
