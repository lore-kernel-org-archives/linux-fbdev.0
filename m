Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF934B19A
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021484; cv=pass; b=dt9cw3It52fM8RbMCoMEpdVM11zuArGxuRqJHqz0Bo/rbFE7gne6fDwbqZfeg6m5gSzcPtXXcLtkkg3BpLp1dakGGwZRpFsxNW95R7AACt6WIoe58yZc5I9T4Amy2kxetgmggRpYOPXH/YPyxSiwC81HkRzYUq18Ja8CFUG7rwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021484; c=relaxed/simple;
	bh=A4jH1huI9yFh1il+odDweWEa+S5rrAi0RBYTn1kn1/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpaAWv2XM1QgMzVWQW/qDmrmdCtk/u3uoLVO/5c+KCXAnAsBbvfK9+Bo+OfIzTaD6LS7kOR2AvTW5OmUpdEYnsuh3HjPgpXHfbfm/8G4E9ABc9Yg4++yxLWPurC182xxqX2a9pfxLm3jCDKQVVpMz7INIg5hcuQPzscnM9S7EIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLnNhF1K; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLnNhF1K"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6530dd51ccaso6972949d50.3
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 02:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021482; cv=none;
        d=google.com; s=arc-20240605;
        b=IHfoSU8jMrOujpLLeEKQs14Gw+0Szx6uzcP42kpq+CXf95N3UpX8nk/cooKgklIEuK
         /8yKZrDQEnfJ+00FSgiw/FEsOGKqrnukUVFJMeiqzxN75ELUe0tnkB4XQqE5OajjB0y6
         Mnmjns9V5hl0M4XZALdqGvNYqZI0ZDPGQPw3bdTKumKSHPBDlyLidB1fmNxpilko97J3
         XyVLpcC9FS2PuKszfzPLpsqlBvIDHDTpQHYs3P1ziqMicrDY30pt4NlGzMEKmgLKcwo4
         kvqtoC5mDfOyoDz9UKJ6zK7qSD6CJIcCP1X9oqpdII5FhASQvGf6/t8pzsDCh2XgeLNW
         B4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
        fh=Bpl+t3rhELqoYXzm7ULQ1hleHwNFSXtjD/o7SeSeq2s=;
        b=f9so1bAtShrT//sJBS4s0dV4MNM3HlJFjo+JkFuI+x0UHg/b8ym4SW0F0yooUZR1Mv
         SQI7kCZhxf+5WT0MZXU6SIkMZx6wmZLQcGkoqz5F1xhu77qvc7p6cQLNmgWJ3D1oR+8Q
         Qj98ao9TkS4CvhCGX5QS2yOq9IriIHov/BClc3Yo7h9C94k6ZFj7GvW7ZBh2/QIexA2f
         EqNyGLIvtmO0bIDB4kVje+9bixv91Xr2nsPlO5HSwkvO5e8Jt4sZj2JlY4bZQjDtUZx8
         mdaVECEgtNzBrM9OlK/cIAIlyYMjabasOsPeaQ+/WFHZamuz3aceuL42OFHCQYSOehTo
         aEhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021482; x=1777626282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
        b=NLnNhF1KDy4LZCUrNLNN1t/m/OZhDExs12BAEYc3vmWsKIscL00TLi4ldWV7Rf0qJz
         jD0jasGnpLZXX/B6HK0UuT4KwY3In7f1nPu1vzpKdqx9SmC4AWLlESy+U6Hf70oV4G7j
         CsFEaY7N7HOoEdi77H164Csedcb8P1jcJ+cER33JCCHRye52rZTnefZXpG4sP2C03pqx
         fmcWFlwtlDdLzyR4a+jIYavs7JqCMmdr05tRRpa+Xijbqc+/7MR9JJ82GaunCpEigYmC
         GWWPpANBuUcf3CY0XhPL9IxOMJQOVAVi6YjklnmaYfvVQjT5O0CeANn30Xn1ANSusOKM
         i15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021482; x=1777626282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
        b=Q/SzQ8VwCdtX9KCkam0w1/Wa10tKKUVwu2fZr8fnOScKj7fwzrz6s8F2LWvKlJ6j3h
         KozN3V5ss2Zflk3M6e2G42qnKfk4HJJRpshKMbwmaNWERv7KtSFo+NB8JHbmnAp/7oUr
         uHv2U9QDW/Y4ulCbLzfLWmck4X/HGEy897nTL795wacr7CqDq3PrMAGgBwnOthXV2FuI
         59b/B/AlNn4lI/oHdcuW7qQCiG99l1RdiVZ8PHNZdtHZG5fB8FbEwPmVN1z5bTbFzSBT
         aXGShF7ai14oNo5G1GpyUT3KPIkzWdlrslWxEeJLfQ1ZJVcn30x8/PSlSefvJhzgA5YM
         vU1g==
X-Forwarded-Encrypted: i=1; AFNElJ8M5hNUl6qQaup4vS/XL/GV4NtSF/RrT+JJtfWhUCn8m9HITzBrXJiQhp+kUPLhKsaaKYIihUr+PLmC5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdpYPDLFMj5y4VsZRva5TUbyfUY6yKE316KsKJpPh3EFqKrXda
	u4m4tzFJ84s9tqNCi2V3i+i/F15Oj5rQYonNdU+zOVXUCDMRaKu9cvxyn1fsFhzTwocScyqUVGl
	fVopPA9PjwHLGgEpCoBY2edQDJFzSCoI=
X-Gm-Gg: AeBDievJgykehDcjkxHT7Y98Sg02dMyDKdjgvhAk80Ol/L0mDMGBEyz579lKqRJbme1
	HkH0kS1u0ZDAK30ydphiQS6juMC1/OoxWTi6rDKS0tXpxC+czvbhQ6ZelBdgTuYGyJ/mgepcK8p
	4qcwVnZCpQErwrgjKnAwrXDKigtDXsFz+IYvQc6nOoBQUI+BQQ9x12/baSJd7yEg0k++G9IZIF6
	rE9hQ94hbNwitU3BQr6JxyZSbPg/uhDu33muEOkjWOL8js3pAu63OndXTVzYLbxHtIfhWiWwiou
	AdRtAHh4wgU6DQYu8ZG1
X-Received: by 2002:a05:690e:4141:b0:653:3f1a:798d with SMTP id
 956f58d0204a3-6533f1a7f4bmr26739134d50.23.1777021482431; Fri, 24 Apr 2026
 02:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415191306.3837839-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415191306.3837839-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 17:04:28 +0800
X-Gm-Features: AQROBzD3ciSHDJ4yZ2SN0KweOJ4wwJwZ7CklV1Yarwt6T_p1EdetKVc2Xh8dTK8
Message-ID: <CANUHTR_zY8f3eGUJwzcq_rAe=XfturfT5N=E3fYLyaYXqGV4Tw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: q40fb: fix reference leak on failed device registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 03:13, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in q40fb_init(), the embedded
> struct device in q40fb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   q40fb_init()
>     -> platform_device_register(&q40fb_device)
>        -> device_initialize(&q40fb_device.dev)
>        -> setup_pdev_dma_masks(&q40fb_device)
>        -> platform_device_add(&q40fb_device)
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
>  drivers/video/fbdev/q40fb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
> index 1ff8fa176124..0151a41267b3 100644
> --- a/drivers/video/fbdev/q40fb.c
> +++ b/drivers/video/fbdev/q40fb.c
> @@ -141,8 +141,10 @@ static int __init q40fb_init(void)
>
>         if (!ret) {
>                 ret = platform_device_register(&q40fb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&q40fb_device);
>                         platform_driver_unregister(&q40fb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, q40fb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
