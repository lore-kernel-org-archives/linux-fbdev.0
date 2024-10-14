Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12659136353
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Oct 2024 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889626; cv=none; b=IubIrv5xUVZZiO2WWwXOJ3yKpgrx8hvQISFBcl/u1l0QHj487IL0mVMBYlXlZsK1u8ESQOtlwryOU/a66iw2yO6ZuETyfqhKfxTf9hKLX+DPHrJEoQYCfS6gQNghuGbMmtwfzvMHMMITsPRvAOaqMh2kwPLW1/aQOzKSmHSi7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889626; c=relaxed/simple;
	bh=KWGyRtOe+d5eWEKkR8JItBQOun6IJ0kjNk0vi5LqyGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9gPh3jZ+gN+EV3oSAg4DzZTgzAoMSHIYlQdfsVUEs9xL29XTobjAkBNeSujnh2O9MK8gW6ElKQ+Jv0CgY5zRTvvnvqIpOgir49zmKoDpWfZDMEntVQt9upPamwyy7GjuZlL/ywnxbNxQu4xLPSo5rkO+VmYXwqBBDsZpudRROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uyWkLWnQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uyWkLWnQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e63c8678so1408991e87.0
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Oct 2024 00:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728889622; x=1729494422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGAZdY+3mMlegbLBhotjKigA3jsyDM7lCK6IChu1+M4=;
        b=uyWkLWnQEKH6H2Pclv+rIyxkP7HdI4eWKKYd7DpLqcLbwK9D3xIT3ka+oUPJANuvRH
         XSsStcHYZsiKnBmhLp1TxbgdVhwIQi3k1w+NbZnOqBg8VjMGJpHxBn9a4E/Q+swKWg5a
         IZW1eGzC8YHjI2W3egxSayO/sHUl46SPwg2gB+8VjFEap+7+lKoLoN39zE2B5ArHeW+B
         RivuqZEavjkeHYnOvJBu8zckGeFIQXi/alY4MoggaB3BJ4vg7g9PsCbnMh0gYyoFweE6
         INfKuBoprd/GsLc2GwD7rODuaOK3d2JLSnfyMbgC0calOj9t64/XVap1ARPR0ZBWbU92
         7xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889622; x=1729494422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGAZdY+3mMlegbLBhotjKigA3jsyDM7lCK6IChu1+M4=;
        b=s5K72mfQYCgdJwAVWd9AE9BwnYFmVhCu8dOTNtaHqC8xc+p3cRPiwbUZPtktsuoxqb
         fD7MsSjPOK2tgYv8fppwRlAjGs0ZGUNvUSQWOugxUnFfIoZwpkE6Mw8711qxI/kQlzUI
         gTMKfjFbd1djuB91MmvxQN8a1esf7L/HnQzkntq7XrsBEiX6jdvY8W9X0SeMV7dHNm17
         /hEzmvGLH2iNBH5V4EkMZOnmgcZL+suTee6Qv2sq7gvgxVRybf4VCtTGlBZQn1flRKZv
         wKNrwIzw9/vIjWPiCErn93i2LYxMyXqouN/6X/KXOVuUXrhVgyHs9tQwWLsVmMX/UTkJ
         Wazw==
X-Forwarded-Encrypted: i=1; AJvYcCXVfCakl1QbQiTGUOJhGK16By2/oNAgreqd95kak0fdh5Us1A3EJqX6HPIChp5J+eswU4wcnDgQ6JM5Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3JIBcbGBMVnKN/vGar6IV0Aru7nM1GUARoR7yMUo5YXnIsCx
	gRHCH8WYKRlggjokBIcBW4Q3kPG+ZIeQR6cxsRGDSojFSurtyIm/k64BsciTi3yZVd4Zh6KoESu
	6dUBK6kJxj/LNYjTtCwK0MDs72zByGELK44ynWw==
X-Google-Smtp-Source: AGHT+IFnO48aGUpKmxvFD0o04bcR91QUkt1ZB3Pcb8GYRBZzTTyMcBni5r8seoxZT9HDgGHzFz8b7Seuy1zcTHncsSc=
X-Received: by 2002:a05:6512:3ba5:b0:539:dca9:19cc with SMTP id
 2adb3069b0e04-539e54d77e1mr2760395e87.4.1728889622082; Mon, 14 Oct 2024
 00:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37842441-e372-40e9-b0f5-cf69defc2db5@stanley.mountain>
In-Reply-To: <37842441-e372-40e9-b0f5-cf69defc2db5@stanley.mountain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 09:06:50 +0200
Message-ID: <CAMRc=MdFYTtosq53tDFaPSBn11V3P36DOX8xsxRqFhu5iPwUcw@mail.gmail.com>
Subject: Re: [PATCH] fbdev/da8xx-fb: unlock on error paths in suspend/resume
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sekhar Nori <nsekhar@ti.com>, 
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:42=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Add a missing console_unlock() in the suspend and resume functions on
> the error paths.
>
> Fixes: 611097d5daea ("fbdev: da8xx: add support for a regulator")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/video/fbdev/da8xx-fb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-f=
b.c
> index fad1e13c6332..66ff8456b231 100644
> --- a/drivers/video/fbdev/da8xx-fb.c
> +++ b/drivers/video/fbdev/da8xx-fb.c
> @@ -1610,8 +1610,10 @@ static int fb_suspend(struct device *dev)
>         console_lock();
>         if (par->lcd_supply) {
>                 ret =3D regulator_disable(par->lcd_supply);
> -               if (ret)
> +               if (ret) {
> +                       console_unlock();
>                         return ret;
> +               }
>         }
>
>         fb_set_suspend(info, 1);
> @@ -1636,8 +1638,10 @@ static int fb_resume(struct device *dev)
>
>                 if (par->lcd_supply) {
>                         ret =3D regulator_enable(par->lcd_supply);
> -                       if (ret)
> +                       if (ret) {
> +                               console_unlock();
>                                 return ret;
> +                       }
>                 }
>         }
>
> --
> 2.45.2
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
