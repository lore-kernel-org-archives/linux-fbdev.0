Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C15C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiGKL0X (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiGKL0A (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B4719036
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657537294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoNRjwHn17Mb09qr5SAGudc0KtakAnj1BuIZJeny9no=;
        b=X9+HRFedpqD9NysdeAe34dXYrFUy6S4evPWSgOx2JL3i+LkJE2GD7eGnAUpfk0pVnkUhVA
        2rPc53Dbe2UQRGaCwEAnIrx6qpB5lfsqSTTSgD07LDcc08OiMXNfOT+qtrvLuvlnlieN+f
        cuGtM+k4c+piQHK/WANFdNh8QgbnRGc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-o1LWj4uQMlGKE7eFweUMKg-1; Mon, 11 Jul 2022 07:01:32 -0400
X-MC-Unique: o1LWj4uQMlGKE7eFweUMKg-1
Received: by mail-wr1-f71.google.com with SMTP id h6-20020adfa4c6000000b0021d6a5ac938so533873wrb.20
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DoNRjwHn17Mb09qr5SAGudc0KtakAnj1BuIZJeny9no=;
        b=gMDB+/lSn0Q6vYj+ciUH2Q0dpUAGaMjvegdCSSecNJh5D5LH85YCmQT1qeI3woEcGl
         Ze4qwNV0HtYjm8dYhZZJF1wScXuDrJ3yEOzulfjUkrPTlq1Dg9YoJ+lX+zFE0ZXJ2mK9
         3y8w9KYr9e+QM6fx2txh/B2rtrCmBnZW0edIerzN/L7Wa+/MAjWTBTisS1GiYZt2d9bq
         gxYyKaFwwhqsotk4gypiE64YbgaTGB9eypoLAxEYlGNc6rWtJBuS2JAoT2OsTrw+53mI
         m620GkCcmOi7z0P3nMrYwJRNiSDMRPSBtNjHrIFNkepky1MMZ7nAK0ifxgGEZUJtA0nc
         N0iw==
X-Gm-Message-State: AJIora8evxX6ohyq2bicaXS126oqIjGE1ZZq1/2tASM26NwHRPXFYGc5
        RwaHbGSJMpoBfH5NCFEakSrG37slN/WzB9Z3biZl2wAuYgRdZvvUj3h3OyVQxV97utU/h6ZQm+A
        pY3XE3gJ5gS+i0oCnF4eaVyg=
X-Received: by 2002:adf:f1d0:0:b0:21d:9c0d:9b5 with SMTP id z16-20020adff1d0000000b0021d9c0d09b5mr8849912wro.689.1657537291750;
        Mon, 11 Jul 2022 04:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8mnYTbK20OklBYjenRq7ddEU4KkMn7Awl5f5jeOdfl+tJzjz1kN5TZ+19bK982BF8qePriA==
X-Received: by 2002:adf:f1d0:0:b0:21d:9c0d:9b5 with SMTP id z16-20020adff1d0000000b0021d9c0d09b5mr8849874wro.689.1657537291410;
        Mon, 11 Jul 2022 04:01:31 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b00397342e3830sm18871245wms.0.2022.07.11.04.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:01:30 -0700 (PDT)
Message-ID: <8ebc1f33-f654-6b93-8a41-1aa66ab1901c@redhat.com>
Date:   Mon, 11 Jul 2022 13:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/11] fbdev: Convert drivers to aperture helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Convert fbdev drivers from fbdev's remove_conflicting_framebuffers() to
> the framework-independent aperture_remove_conflicting_devices(). Calling
> this function will also remove conflicting DRM drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

>  static int lynxfb_kick_out_firmware_fb(struct pci_dev *pdev)
>  {
> -	struct apertures_struct *ap;
> +	resource_size_t base = pci_resource_start(pdev, 0);
> +	resource_size_t size = pci_resource_len(pdev, 0);
>  	bool primary = false;
>  
> -	ap = alloc_apertures(1);
> -	if (!ap)
> -		return -ENOMEM;
> -
> -	ap->ranges[0].base = pci_resource_start(pdev, 0);
> -	ap->ranges[0].size = pci_resource_len(pdev, 0);
>  #ifdef CONFIG_X86
>  	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
>  					IORESOURCE_ROM_SHADOW;
>  #endif
> -	remove_conflicting_framebuffers(ap, "sm750_fb1", primary);
> -	kfree(ap);
> -	return 0;
> +
> +	return aperture_remove_conflicting_devices(base, size, primary, "sm750_fb1");

Do you know why this can't just use aperture_remove_conflicting_pci_devices() ?

It seems that the driver is open coding part of the logic already in that helper.
For example, figuring out if is a primary by checking the IORESOURCE_ROM_SHADOW
flag in the PCI_ROM_RESOURCE.

But also getting the base and size for PCI BAR 0, since the loop in that helper
would already take care of that (it also starts at BAR 0).

>  }
>  
>  static int lynxfb_pci_probe(struct pci_dev *pdev,
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index b311c07fe66d..e5e362b8c9da 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -54,6 +54,7 @@
>  
>  #include "radeonfb.h"
>  
> +#include <linux/aperture.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/kernel.h>
> @@ -2239,20 +2240,10 @@ static const struct bin_attribute edid2_attr = {
>  
>  static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
>  {
> -	struct apertures_struct *ap;
> +	resource_size_t base = pci_resource_start(pdev, 0);
> +	resource_size_t size = pci_resource_len(pdev, 0);
>  
> -	ap = alloc_apertures(1);
> -	if (!ap)
> -		return -ENOMEM;
> -
> -	ap->ranges[0].base = pci_resource_start(pdev, 0);
> -	ap->ranges[0].size = pci_resource_len(pdev, 0);
> -
> -	remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
> -
> -	kfree(ap);
> -
> -	return 0;
> +	return aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME, false);

Same for this.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

