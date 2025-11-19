Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C502DCF6C
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536634; cv=none; b=hLtopCN0l5DbjRMiBtQFpGcLwFjhjt3X1O0U4G2Oo/tWeYXyX+CykAxSNUTidydrKHLiG717DVoh7nmrYe7rA0IwBmPEn9uqiqdeK+p+d/hTauHGGAh+6QSbSkDHgReGjCQa0UHoOBaWkvl7aS+y8O3O71tBl6NCmmmff7YUrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536634; c=relaxed/simple;
	bh=yf3rj7kjgFeuw8WqVV00rLykAQcjoD6ee92L2NroJdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGKrfcTc2jomQo8gZfrB5peulHLWDluIjpS/mg4kks02YbyzHRz4Wx6cUuL0pwkqVY2nXC4cv+yFRxbgBZe4qAjEoH0fc3wcQ3BJcnZBxkeJ1kCBJXJQ5SKXdniNicYmMeOK2H9gwAibokQrUP6toHGiUGHxNdXyI7aJAsybIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf/aH3ZY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/aH3ZY"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso11868047a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Nov 2025 23:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763536631; x=1764141431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EJ+O+/tQ6vW+24H3RZKmxUGOMkY2b8gAhqMukrgBCU=;
        b=Bf/aH3ZYkEn/BVBkAWVQnfS05dKP4Lb6cj7gPniBoPLaQg//I76nxGskbv/Evo/fj4
         DThJIBpQlBJFa9ij84xmrQCcTMEY5t6tGjtH9sw98rV6FDiEJ7FGYBYgiJJp8tlK1tmf
         cNeTdMj3XvyVZ/A8UTJPlGSI3FDYCqP5sCNO0iN5x84H6nrphPfdx1PnPBscM2vpvqBq
         w3WJt+5K+ba0pPM7EzKuUcrataEebL9diC0P+uJYKLjecdAP2cad2NQZjbG26fWPibfD
         8Fqmib6WQAmQSl00sdTWl6t0n5k6DmMQKi99hGW0Liy/7UBpPWjOl16lMndS+BizE3cT
         N75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763536631; x=1764141431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EJ+O+/tQ6vW+24H3RZKmxUGOMkY2b8gAhqMukrgBCU=;
        b=k4ZLrZLmT4B4J1iVOCVlO5kGhkvHYoLpY6y2HCUHjVJO1JjnSYEqIzRkinFqvb5nRW
         0tQfgnV4smplSVqs8/XPjpBFOK+urjC5sDxV+sMUoZrOTQkwRoVg0XR5+Ijzqw0mRVCN
         MPUAAIyMganysm6YMehb+LR2Tqyk9QendxaK/5OkL4E7EWW7zbE8r1BcW9hoT+ruNOe2
         8lGlcp44+kzvxsUKuSoo91MOK36JBYzHT4MhJGAkNjQxyMV16WuO459DX028OUUXmcSk
         6h3lYZUgT6i8Ywuz+Xyl6rbH8NDXXDVLwyMIgTLVwN33sPTfe5uAaPsr71FcT/ErBSOM
         tekA==
X-Gm-Message-State: AOJu0Yw2zjH8MgOZGE9uQmW/UVUReEq5VRPtcx+0LvkoPNWjDQxdmTjS
	MELiJFoOyPtyQ8ay8EJgPxFbJuTZP2IljNWu1B3/XDYeQoxmyOLULqDaapGKHiYMcRD2QVxrXmd
	1f2WgGmZY8fHSjvQTuQ4c57vxG0UoMs4=
X-Gm-Gg: ASbGnctPK5xN6gh4hMYEvURDnjiNQT4GSPQn2zfSlnGlqdB6xHocXIgEXkFp0uVcv5v
	i3BtVvdM+kyRwHRy4YK/0tesfFQsNfx74I7eeFpzbfXQLFsjvwieIDUYf+69stIaN1HTj3nr1cW
	W8515zM7UEK3Uguwhgf6TDILp376pYBS3V48F+ZPKHTw3P2uOPVvz67m3ktQffWoACu1AZWOnWX
	dWlogz+Y332ajR0DkD4GDwSX8mO14w7oa6rV9aGfAAq1XkLCXRebKc3zHBrg1KAKVusfPtH7wv1
	Mwt7TrT385moSSM3n+miEsGr
X-Google-Smtp-Source: AGHT+IE9uQZLBFdQDPsVLkSPNjmAX4yph6y8DZKHX9lDmrbOkhEeQZJx2xhnAtV5cyCcH5NeKJmBDDc5Ze+fOVNVM3M=
X-Received: by 2002:a05:6402:4310:b0:640:3210:6e48 with SMTP id
 4fb4d7f45d1cf-64350e046fcmr17282325a12.4.1763536630884; Tue, 18 Nov 2025
 23:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115125701.3228804-1-rampxxxx@gmail.com>
In-Reply-To: <20251115125701.3228804-1-rampxxxx@gmail.com>
From: Javier Garcia <rampxxxx@gmail.com>
Date: Wed, 19 Nov 2025 08:16:58 +0100
X-Gm-Features: AWmQ_bmzv8l-KX59QSz0MNOTxclz8UMiBbVuiOxbVwWiFfQ6NOwXKoAwcySw9Pg
Message-ID: <CABPJ0vjy1ccb4DCd5Q1B=LQPMdpAQN+hhWd39tk9y6TbepZoSw@mail.gmail.com>
Subject: Re: [PATCH] fbdev/tridentfb: replace printk() with dev_*() in probe
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Deller,

Any comments on this patch?,

Thanks!

---
Javier Garcia

On Sat, 15 Nov 2025 at 13:57, Javier Garcia <rampxxxx@gmail.com> wrote:
>
> - Replace in `trident_pc_probe()` printk by dev_* fn's
> - Delete the prefix `tridentfb:` from msg strings, not needed now.
>
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
>  drivers/video/fbdev/tridentfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
> index 516cf2a18757..17b7253b8fbe 100644
> --- a/drivers/video/fbdev/tridentfb.c
> +++ b/drivers/video/fbdev/tridentfb.c
> @@ -1631,7 +1631,7 @@ static int trident_pci_probe(struct pci_dev *dev,
>         }
>
>         if (noaccel) {
> -               printk(KERN_DEBUG "disabling acceleration\n");
> +               dev_dbg(&dev->dev, "disabling acceleration\n");
>                 info->flags |= FBINFO_HWACCEL_DISABLED;
>                 info->pixmap.scan_align = 1;
>         }
> @@ -1693,7 +1693,7 @@ static int trident_pci_probe(struct pci_dev *dev,
>         info->var.activate |= FB_ACTIVATE_NOW;
>         info->device = &dev->dev;
>         if (register_framebuffer(info) < 0) {
> -               printk(KERN_ERR "tridentfb: could not register framebuffer\n");
> +               dev_err(&dev->dev, "could not register framebuffer\n");
>                 fb_dealloc_cmap(&info->cmap);
>                 err = -EINVAL;
>                 goto out_unmap2;
> --
> 2.50.1
>
