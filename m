Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF8604AA
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527741; cv=none; b=ZQjvhWmdrqh9GS7G811inO7J2E8I+rEYlC9wmWIxruLvxGi2ahrhLWeCTa1w3xB3neOp/J2yjzCqnUp1Plod9oJqn1jXVGVYmtqGBZovSkOIxv+FytswmRCwg3mOFxg4Ai5iNPAtd8ZCk6kTXSOhnXxIP8b17xHx/HANqT7/scM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527741; c=relaxed/simple;
	bh=TghN7O3N8SxYXGGUQdoUHF8mgCKitKKWM5GnQFR82KY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nAI8eyJ6si6Dlb165PCSaKQ0vjFneD0bvcQI09MmHiPdUEZhzi0qY+s1YuRp+Wj4VEx+RkV4N4ngOeQ1tlwMavAJZgtPjGQ+dRCyCdCPkdkh+M6TD9wGa1naGLsNTe3d5ybpmJ4DqmzkqX3k/V5+39CF6z08/aavTGA5PjEnJNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPtRqneP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPtRqneP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706527738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8SlJkgyf4F72zAmTqwHZjwa5jBZV7W7p8nr0oKMhHk=;
	b=GPtRqnePaLkOECQkojiiuXS2eheiu/Irtabx9SS/KL85gxO0O1hDjtSXeyTwCK9CDR3UPC
	NMuXKUseLB42AXYW3k4/kGRy1+KhB0UrctIkmplMyo7HATFIN8xXP/cDTQPkv/Fy545tlE
	O8r19uRUbHRyzCNBtZC27ApCPFR0Wjs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-l2X2R7ygNj6xJvTznLUbDw-1; Mon, 29 Jan 2024 06:28:57 -0500
X-MC-Unique: l2X2R7ygNj6xJvTznLUbDw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e6f3c5730so26759565e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 03:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706527736; x=1707132536;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8SlJkgyf4F72zAmTqwHZjwa5jBZV7W7p8nr0oKMhHk=;
        b=wwWNTZsAMyi1znoNVbHGSU+N4s7ZnYI76idVJiTKruoJapsfwt38Ax+KhHXDIv/SRK
         ubBUfi0qHDgrm/MJ7ZGW1iz1L9ByYnuxfNZ+OnNWK0dkNgIEwfI716jgIcsWuay0CUcG
         Ft8fGbPVL19HJ9RAKtZxUkdnsi0cKBo94BSzQHdvTflOU0vbRYH4cxMsMSxdLvgjaEQq
         fTRMrw38ILv9Ob5v49qel66xwpH+UzHPA4cxlRxUfvJxMq5RKzCbhOv6wHevHdlK0Rkl
         rap2+7Tk01Ctcv8Ck2maSwzSE16szhLpxFbQOdkBlzHB2NJ1osBSFvNqZcA07I9+u/yb
         v8vw==
X-Gm-Message-State: AOJu0Yy1IYhsbVZnczzOw04bm5fWF4PgAY3t5SthGd5ExR90E5BouWm1
	ak472yErCmDJVkpeGQGSrc/tKMaUeO/ATbaV5uQJofSg8G+BlTybGMHXRQcHiJbsnhKzJKkOidW
	Oop/LPa5xNcK5JQLRFrez9hQRMWsu7WcBiLt99RppNWzgwRAZz13WcqeSDhDp
X-Received: by 2002:a05:600c:4e8c:b0:40e:e25c:41cf with SMTP id f12-20020a05600c4e8c00b0040ee25c41cfmr4504922wmq.12.1706527735810;
        Mon, 29 Jan 2024 03:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0xVaWWL3o51Qn/gqs0+H0Eyaw1ZIB6VRyL1cww2mueAr4kLpgaFw+NXNnWMf5iFyHSjpDsA==
X-Received: by 2002:a05:600c:4e8c:b0:40e:e25c:41cf with SMTP id f12-20020a05600c4e8c00b0040ee25c41cfmr4504907wmq.12.1706527735466;
        Mon, 29 Jan 2024 03:28:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp19-20020a5d5a93000000b003394495566dsm7950616wrb.22.2024.01.29.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:28:55 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/8] firmware/sysfb: Set firmware-framebuffer parent device
In-Reply-To: <20240117125527.23324-4-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-4-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 12:28:54 +0100
Message-ID: <87r0i0v0nd.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Set the firmware framebuffer's parent device, which usually is the
> graphics hardware's physical device. Integrates the framebuffer in
> the Linux device hierarchy and lets Linux handle dependencies among
> devices. For example, the graphics hardware won't be suspended while
> the firmware device is still active.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/sysfb.c          | 11 ++++++++++-
>  drivers/firmware/sysfb_simplefb.c |  5 ++++-
>  include/linux/sysfb.h             |  3 ++-
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 19706bd2642a..8a42da3f67a9 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -29,6 +29,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/pci.h>
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
>  #include <linux/screen_info.h>
> @@ -72,6 +73,8 @@ EXPORT_SYMBOL_GPL(sysfb_disable);
>  static __init int sysfb_init(void)
>  {
>  	const struct screen_info *si = &screen_info;
> +	struct device *parent = NULL;
> +	struct pci_dev *pparent;

Maybe pci_parent? It's easier to read than pparent IMO.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

