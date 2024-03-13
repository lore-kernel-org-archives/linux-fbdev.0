Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E9446A0
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338625; cv=none; b=UAbd56cdKDj818Xdya4N3QBf5CjSfYqA+BulHjV9stAo3Yq0ycmbfDa7Po9dTlBcz7yKCLTed0xaQ20NGARzmACyzlXmFjOTc0DDWXnoId5uw5rA5zXkjUTUR+EiqBMavZWdcKD1amSrBeU7Igum9w7I91MHXNanJXasqM67sO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338625; c=relaxed/simple;
	bh=huMv9uc9yHqLmX3xwNuScOZ0wNK0YtAHjR8bE2xUiuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6MxjzZkEvyyMkg5rDN9ADJIAnRIlpSGcJEMepxvsK1sajCgARPrtUyTavLUBzCqTPqEcfwersF1EDSC7o/vfQpIloPoFqGGCCEJW6a89fI3D4h6dVNFslD2egtptapM6H2HX9hGgvhHIYJM0QAgbNhspAa/Y9CAd4it1BVGTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlJbZnN8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlJbZnN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710338622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gxcyuud9PUU21oCT7HcyvGU9X3hZha1Ay6YbgZqHGYc=;
	b=AlJbZnN8OHz9UoMzuKKA9DTBGrdOkc1Amj3p1KTmUl56L7A2jCxPogU6H0pRr5PBFe6e0u
	aYqB2wussyQpfGD0T/lpjpd8aopWqgcal3satv7ZX8+/+GUQs/jbVV/NyDja2y+zkFx4jE
	+i2P3IC0yWfPlgJv/xT9zL00Dmp6C4M=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-LiR7-0tjNyuKwRdlLQSewA-1; Wed, 13 Mar 2024 10:03:39 -0400
X-MC-Unique: LiR7-0tjNyuKwRdlLQSewA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-609d95434daso95618777b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 07:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338619; x=1710943419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxcyuud9PUU21oCT7HcyvGU9X3hZha1Ay6YbgZqHGYc=;
        b=cwQajt0MZ5a+GJzXvmtD6NgnA8TMN+m4H0tRcYB1Gve9qledp+FMHGsZRxtGRtfjmV
         pcJAIQgKU0HRBAf4uDAWs81tZ4byzAteYoiaq186htR2FS/Lnr/NXm1x/e6JYJxYhpFP
         cvUd9sitx4b7hbFRlJNFS4NKF6R25npHYvA8vpddIrXmuOuh+ID+i2Yqn5q5Nl6f4v+Q
         3Yzgkcg1/8mJXGIPIU7XUkMOaOXynTv6/vY33ItaL9BBen0RPF4kg/cvIRt5VrqMFfMu
         hBxQVPCgeepgu/ZjBts0n2F5Buwnh5KbLuCmHOAbCd/bLDd4loLDr5jO8h+ry+gpeDlH
         9TmA==
X-Gm-Message-State: AOJu0YytPPTZSKsRyUQhHkQFHuZb0pNnEqesmXr8ppm8fP9/GeIx6dzr
	F4ioWTXBi0qzWigAo5JPkP0L1VpMGaUvCJ6Dik37uUkAUqiYEUQ5SZzdcOjtFrVPmyk802Qc0Tr
	fpJmrY6S+5BzbsTwKC27RTDni/5uHM/VLdmi5DYxLl0ZuryrcMwDH2XSGQY+y
X-Received: by 2002:a0d:eb81:0:b0:60a:15c9:1600 with SMTP id u123-20020a0deb81000000b0060a15c91600mr2846632ywe.37.1710338618999;
        Wed, 13 Mar 2024 07:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPG5IRrHrKwPgd/9Dh8Z9VwqPTesqBfo+4n0SoH+KhHZfNsII+UVsHejM49YUTC1uVCrEY0g==
X-Received: by 2002:a0d:eb81:0:b0:60a:15c9:1600 with SMTP id u123-20020a0deb81000000b0060a15c91600mr2846610ywe.37.1710338618766;
        Wed, 13 Mar 2024 07:03:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id v17-20020a81b711000000b0060a3b09a5c2sm1705232ywh.84.2024.03.13.07.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 07:03:38 -0700 (PDT)
Message-ID: <b35f1b2f-82c1-4c7e-a449-54e29000cfb6@redhat.com>
Date: Wed, 13 Mar 2024 15:03:37 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/43] drm/mgag200: Use fbdev-shmem
Content-Language: en-US, fr
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-13-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240312154834.26178-13-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn

On 12/03/2024 16:45, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   drivers/gpu/drm/mgag200/mgag200_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
> index 573dbe256aa8b..65f2ed18b31c5 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -12,7 +12,7 @@
>   #include <drm/drm_aperture.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_shmem.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_ioctl.h>
>   #include <drm/drm_managed.h>
> @@ -285,7 +285,7 @@ mgag200_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	 * FIXME: A 24-bit color depth does not work with 24 bpp on
>   	 * G200ER. Force 32 bpp.
>   	 */
> -	drm_fbdev_generic_setup(dev, 32);
> +	drm_fbdev_shmem_setup(dev, 32);
>   
>   	return 0;
>   }

