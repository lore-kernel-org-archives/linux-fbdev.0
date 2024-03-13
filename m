Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C24502C
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338623; cv=none; b=SxTiALYaqUfNdSp9NMayAxv9WKza/JrmImZkIQp3N41+ftAYFlkSSEAH786hFWywEMPLXgQhQMOsQ4tTxXhNRLnQ1i49WlenFsfHMzBQEFjtth+BqQ43PMpf0EjiNesj1Ao6qJFW/E/PBY/KUTnm3all6IbY5KFRQTAxRKzhKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338623; c=relaxed/simple;
	bh=dz75euD3Yf2gqYqGznUQIlmYXLuEMBeTQIB/qOcaDYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hlv3fhA/8+djIn5JzfqYKBmqSsaT4LB96zCYIuQae9SNSXGJPqU0wl4GO7FfDk23p3PW1xoO4m0zgLirA+ZkT8fbatSomdl/QHZ/72fi215gKvfrvmaeXZrYPBjuldoLYdVDpMeiJkjBY6WwXotw4o+MSWCFkFja3xLvWwod4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epC0hUDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epC0hUDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710338621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUZt6MNgjNHKhgTBbA2vfDVZEI9VXutMPGq00oedqJk=;
	b=epC0hUDyv6MVNWsYE3rpnxG5GxFPUx2E9rkU2vTy5LZy9eLoINzRtrHrp9tEt5s0Giix3b
	PLriXlM0N81TyF1WgjVdfHeBJjOsn3Gaq6EFnCTzIOQiNyJs/jgymvjTVL9AbeqNTp7Jvy
	BwfxJLSR9W/c72j+PUdu0wOncFrtlv0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-tufwu9ZHOnqyc-fgT0VFaw-1; Wed, 13 Mar 2024 10:03:29 -0400
X-MC-Unique: tufwu9ZHOnqyc-fgT0VFaw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-60a2b53b99eso68326687b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 07:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338609; x=1710943409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUZt6MNgjNHKhgTBbA2vfDVZEI9VXutMPGq00oedqJk=;
        b=ZkS7FPWqCpVUGbBQHAmbvPiyF3Fa+6HH4WiGIJEgJeYmJsOvLElCA7Lr9yjsNMTy4p
         oBHQDvvhcRuEz36LvexJuOx0PV9loqL82csrxd79lJWQxyNITOk/ilXhP9nH1AvHCxlN
         5RKn+h7rbGpYP44LSrpi6n7x5JxkdjG+PSGXF+kV2xQC4ARjOAlH9n8rqsozzcE8KU/x
         l/8cFv2RSA845QRM/H061DysaILT9UqyEADsswUprONNAzLDXcevEPGeO3tN4OvFsLub
         AYmhzgQpSfLz7Ujju/+SqJoO+NG2dqELBrN5bNKrfWCqCjootvI0S7gvLkKabj0GgI96
         hwrg==
X-Gm-Message-State: AOJu0YyGyX0rTIv7kjxs3oqsefV6sTb/qgNtIwufJ/6iwx+0LQtvGjnJ
	QJDECzNFStWQ7AoTUS0qbPuWQX+SDNXINSYyrkDTlQW2W7MGg4E6qxv2L7WbC8J9HA1mzgnAcur
	jKvIxNrXwrWuqM3mAQwRgGx7jnkqs+pV8giBeFWGRglM6HhwqwrU+RkPJMVGL
X-Received: by 2002:a81:9246:0:b0:60a:747:3bfe with SMTP id j67-20020a819246000000b0060a07473bfemr2725719ywg.8.1710338609421;
        Wed, 13 Mar 2024 07:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWdsshGcAcaIQgsFp7I99HVmihocR1aZSa+pyc4phvvEbHewV9fwCvq2Sn0OpTojhIl+9vRw==
X-Received: by 2002:a81:9246:0:b0:60a:747:3bfe with SMTP id j67-20020a819246000000b0060a07473bfemr2725674ywg.8.1710338608970;
        Wed, 13 Mar 2024 07:03:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id v17-20020a81b711000000b0060a3b09a5c2sm1705232ywh.84.2024.03.13.07.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 07:03:28 -0700 (PDT)
Message-ID: <4ebc7904-ac18-480e-91be-d9338f1c01d2@redhat.com>
Date: Wed, 13 Mar 2024 15:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/43] drm/ast: Use fbdev-shmem
Content-Language: en-US, fr
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-10-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240312154834.26178-10-tzimmermann@suse.de>
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
>   drivers/gpu/drm/ast/ast_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index 90bcb1eb9cd94..4fcab4304e176 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -32,7 +32,7 @@
>   #include <drm/drm_aperture.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_shmem.h>
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_module.h>
>   #include <drm/drm_probe_helper.h>
> @@ -359,7 +359,7 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (ret)
>   		return ret;
>   
> -	drm_fbdev_generic_setup(drm, 32);
> +	drm_fbdev_shmem_setup(drm, 32);
>   
>   	return 0;
>   }

