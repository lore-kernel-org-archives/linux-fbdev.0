Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F1C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 14:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiAXOXG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233777AbiAXOXG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 09:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643034185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cs88OS8ntrHeBIPi6HCjuIRnxV3UU2trcG+6nvyi6gs=;
        b=i8wmV0rMniJmZrdBrMkLUmMwe0WHQshdNqR+Cr6UjYoYNkhtH9N78D7KqRQw4SKQexsqCS
        +cLMej3Vbo3ioM7zE+hvMKaxR8CdtnGlQ/GYpBfPW+pIQyk4+MlXcFB9NmlJ0YnZTNQUWy
        KJ/ORTERQILeotl6dFBDKZBiTPuBpzA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-Krcxh6yTPJCYCi7MqHRdqg-1; Mon, 24 Jan 2022 09:23:04 -0500
X-MC-Unique: Krcxh6yTPJCYCi7MqHRdqg-1
Received: by mail-wr1-f72.google.com with SMTP id g17-20020adfa591000000b001da86c91c22so816515wrc.5
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 06:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cs88OS8ntrHeBIPi6HCjuIRnxV3UU2trcG+6nvyi6gs=;
        b=ynhvTOl2opG2ljDWFi6lRIOWXh5AUIpCp/SY43BNNqUaYbngQ4IllyXLVzwOynaNnM
         IKWOCiGpCIe6RJ6conEh1pAxwt/pPQ0xnQlDh9veFao72WNTeTKO2OTbSx4pCW67jLon
         bs1DM7zqc4BOGhzIdXJdMIclZJyig5rqxxRfg4ovABuq4ybffd2Sw9GDepV+WDYGVtUa
         7DYQ5xRms5IN6nmCJo7YEtbdmRcVIk4i/7kgMcjyY3RIN0Ikk7MLB9a2eRpUXAeOQcHs
         xpeFNilO4mWwuVNIkSYnAluiZeyh+BussHejfs7LkgwMkBkTuNU7SucqA2KQvK006auL
         ZmeQ==
X-Gm-Message-State: AOAM532v+7A06ZoHH9NrkYSXAML5Q4+y111eM6GesJMAI9/6q+13aSbq
        Xa7qlkadF/V+6iyuJHZcX/52ri2PqtezvkqORh2GlT1QPfM6+weNVKLY9SiNsIZ9ZulOden2VJ3
        1DEykndKzM7xyqJhis0q8gT8=
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr3236182wrs.410.1643034183538;
        Mon, 24 Jan 2022 06:23:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1B9bMdw7KWzqCPgCXI5UiRxAg4SRlxhbTFcyTAgjjrPAcK8XbeRhoAQcwKWpMrNIpiD4sZg==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr3236164wrs.410.1643034183321;
        Mon, 24 Jan 2022 06:23:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:f4b2:2105:b039:7367? ([2a01:e0a:c:37e0:f4b2:2105:b039:7367])
        by smtp.gmail.com with ESMTPSA id m11sm13864188wmi.16.2022.01.24.06.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 06:23:02 -0800 (PST)
Message-ID: <bede759f-23c2-a87e-abde-108196e36fde@redhat.com>
Date:   Mon, 24 Jan 2022 15:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/5] drm/simpledrm: Request memory region in driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, zackr@vmware.com,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, hdegoede@redhat.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220124123659.4692-1-tzimmermann@suse.de>
 <20220124123659.4692-4-tzimmermann@suse.de>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20220124123659.4692-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 24/01/2022 13:36, Thomas Zimmermann wrote:
> Requesting the framebuffer memory in simpledrm marks the memory
> range as busy. This used to be done by the firmware sysfb code,
> but the driver is the correct place.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/tiny/simpledrm.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> index 04146da2d1d8..f72b71511a65 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -526,21 +526,31 @@ static int simpledrm_device_init_mm(struct simpledrm_device *sdev)
>   {
>   	struct drm_device *dev = &sdev->dev;
>   	struct platform_device *pdev = sdev->pdev;
> -	struct resource *mem;
> +	struct resource *res, *mem;
>   	void __iomem *screen_base;
>   	int ret;
>   
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem)
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
>   		return -EINVAL;
>   
> -	ret = devm_aperture_acquire_from_firmware(dev, mem->start, resource_size(mem));
> +	ret = devm_aperture_acquire_from_firmware(dev, res->start, resource_size(res));
>   	if (ret) {
>   		drm_err(dev, "could not acquire memory range %pr: error %d\n",
> -			mem, ret);
> +			res, ret);
>   		return ret;
>   	}
>   
> +	mem = devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
> +				      sdev->dev.driver->name);
> +	if (!mem) {
> +		/*
> +		 * We cannot make this fatal. Sometimes this comes from magic
> +		 * spaces our resource handlers simply don't know about
> +		 */
> +		drm_warn(dev, "could not acquire memory region %pr\n", res);
> +	}
> +
>   	screen_base = devm_ioremap_wc(&pdev->dev, mem->start,
>   				      resource_size(mem));

if mem is NULL, accessing mem->start will segfault after the warning.
I think you renamed "mem" to "res" so probably it should be renamed here 
too ?

>   	if (!screen_base)

