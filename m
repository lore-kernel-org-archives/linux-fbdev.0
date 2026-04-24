Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9635C193
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021070; cv=pass; b=gORB/2V3Z+beSb4skDku80nZF/jB892X98KQjVvtmTbhBufJ6c1C1EhBh+4ukLGcoAMNb0oXfTvi0AAvOVBABGBKobtnhDAyCvKo2SAqEaBjrT5VOOC7D752krQa3AklCHIMpJklUpriU2K5Nt90STcdv8Sn7vhL+OVtSIL7jIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021070; c=relaxed/simple;
	bh=mJycpKriTio44XHdChcIwU/V772ZEJHE3GawlsKrjHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a828i9hzYWoswU1Dv3F5WakY3Gmwn1+CTPbUJMt0RNruvaI9GuF2NyP3jia1QjhopAD+hXFfbGsryGJQvUXqz/TX/nLS+U7MCKEEK9QD6GQct314/RrFuH1enbNLKSACmtQETGvuAOSoemXblnYwZXThcXbyp8CwRiYFAdH1kZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6+/tIhu; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6+/tIhu"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65075c2ba66so5853198d50.1
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 01:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021068; cv=none;
        d=google.com; s=arc-20240605;
        b=P0LQjPvGO2G6kVaWmVBuC6rjbGJ1Hc0hTuhdk5fQ7T8sz/YJcrfs+4KP3ZOCAkWin4
         ZIep2FHEi0/SAdAvjvINNHfzwJ1uriuG74b6mHvIAh22DpEO/NVI/fq4kON0YvM9D4Eq
         atreSXLECNHdk8iBnhE7NdFbcZRdQj8mvno5mtZP2XmALU47TFkPNzLjHF35uL9RavwO
         npHMegcw3tGNPuGl1vhxCww7oMr6YltG0lPdv1fB4Rx/a9hUAeL/gaSyAZDN0koNcHNI
         WHe1j7i2THkFcnt137n9lWuQguPMzVRt6F3CljCJwLDjiQT5a1ZDrpYvBVT5sprCgqw/
         jMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
        fh=4dVIkcNSyIQ6LY+wTWC0yDz6z2UnEbn/V2+tZZEf52Q=;
        b=M3Vvzg9NaTr7A9oOOTh5dOLquZ2e4r3Lpo+VrlWuOB6XXaJbdrfK6bCAEg7WPUQePg
         IVjwDe8mQ9oaj16xkv56mVS/aqHx0I11GMzb0JpRYd7WUJttd0M6C39mvsOHMsE38a85
         yDl6FE4vqGKLRmVCrdjj0ZfiXNSnhc3ohuT70bXlK2CkqZjdZ0mrYUAOGIPcbBd7ysml
         CHn3dFBq8wJoiTHcyo62k/+wnfhG0YZRFyNsW/cxh6pelXHovIAc9X3CBIjWGtlCkydk
         QmK8gLkNFXEPWD9cu0UR/AmITVBNSyvfZkN1kHqBBJJpaq4QoUW6BUupMmAk5kOqJLAe
         ixGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021068; x=1777625868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
        b=j6+/tIhukzxZmK0pAb/20Lt3g+pUgsXuFs/Kr5fwM+/79i6oDwTP8KIS8F0k+DzGPW
         2O4baIxPIB53jQBYi+gmWyN6dSZ40Kw5+2UZT6YREUFo6lsAqQZRMAFIFiZSMT8L0UjD
         wqAQf7l3mrt8xbyvMB1aZlyWXd8yNtjijI8byjXZI71/o1rdSJxa8YHv4fy4z06n/vmo
         msSjantIQMKPaDfufNGsBlEcw67OXC4uVnbFEUZWzC68x1amTAg11vLnZ/iwiMoHCEi7
         s7v2w3+E+wlEqqqE27eNmzRCOjw4eoMDEE8j1LMZrrgYTmI6JDM7tZnbdjDRH3S0QMlY
         aa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021068; x=1777625868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
        b=G1zrhpx9QwCD2r+IHQzULFTvKyC4wTVfldHoipTELzOXWRlvPyNQKtz5e8k448d3vB
         7VgD2G6r2c77y9GIQYXuAsRV6TNxwUDET9QB81VnSoHcLy395wfzeucQKyhYyEXjPWYK
         DFJtLI38CnmWkw/qz5v8LdZYElXyjgoHdUx/teDjDztxX04jvzT1GuVOa0iDt9I5bIVq
         AOU1ZIDTy5R4cayi0M/Gg1e9/ftffUFs0IsuS4PhWeQXbysWMSxu88Hp+oPMqPgIitBV
         xiMMuy4cmIQWsSg7e5aPye2ep5gruBhmoDwp9OTlT1ad5c9WzWdj1QbRElj/AWhxwDyM
         UbAw==
X-Forwarded-Encrypted: i=1; AFNElJ/RPiyCYJa36zln0bxawTo6ublFoLE7PC4IWciuZ6Bege3Ve6UKCGY0LOK5RrQPkEgCtJSWuwxCcprDPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyudA+A2xaIVbqdqY0qxwKrnAIRdDwoSADC7HS3aXyPfUAIQrzG
	w+tL9HpSJ7g8jFMxLWRhD1Ct+Onra9RRxObX9i5boDhzsWHjRjvAAVAZy+KJmnErz5jfWTazwu0
	wGzzx8RY7dSgQeK1LOJAnPHk6FR1GKyM=
X-Gm-Gg: AeBDietN524PCU3UBzJaL5ar6wt6ah7uKxDYk29Rp3BUTR5odYse5rR5PzYEAXSxYJq
	9MQiEI/rVnrmDEiEOE78bAdEY6hP9Rq/lFDgj4mZ+6oqOTUZkEsaNYLbawxCCSpTDC2fdM+GzZS
	V3QR88VrEy+ONSMJQTimr1MaleOLXYl2SqbY7DmlKYfI1e+1xWr0SVy8i7yuZ6FsGzp+a+qoW2f
	PMBNgGObMENloI/szOVOXwRorN/KW7axG5y7mQYyraDgelqlWoPQMYEU7mCae3Nv+smuPCLMz5x
	ddv9/NHt/nOjFVWKRGb7
X-Received: by 2002:a53:d748:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-65310a737b1mr21220612d50.48.1777021067703; Fri, 24 Apr 2026
 01:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415190738.3821974-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415190738.3821974-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:57:33 +0800
X-Gm-Features: AQROBzCmQJ1EX2ApfnpwOngh9p6OkQ-4OwvW-Db64LtyYbRXyvs5_5WPx0t6Mt8
Message-ID: <CANUHTR-JSL0rkw1VbAa1AYFsp0NGF2Dz3X2AWmQFcJ=mm-nsxw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: dnfb: fix reference leak on failed device registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 03:07, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in dnfb_init(), the embedded
> struct device in dnfb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   dnfb_init()
>     -> platform_device_register(&dnfb_device)
>        -> device_initialize(&dnfb_device.dev)
>        -> setup_pdev_dma_masks(&dnfb_device)
>        -> platform_device_add(&dnfb_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before unregistering the
> platform driver.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/video/fbdev/dnfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
> index c4d24540d9ef..72a9c47418f8 100644
> --- a/drivers/video/fbdev/dnfb.c
> +++ b/drivers/video/fbdev/dnfb.c
> @@ -296,8 +296,10 @@ static int __init dnfb_init(void)
>
>         if (!ret) {
>                 ret = platform_device_register(&dnfb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&dnfb_device);
>                         platform_driver_unregister(&dnfb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, dnfb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
