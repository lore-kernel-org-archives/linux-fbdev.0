Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37AC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 13:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbiBANGM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 08:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237979AbiBANGL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 08:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JQQOEd58RWuQGlfFpmDXOvRRGfDXT71ddV8rPIIJl0=;
        b=UCi1fnIUNsEZ5DcUNRo6455Qu5KuTCo8jzMfSR4JnxGIbMaG7Y0oVL4AUK1NA2bJmVHmMC
        l82t2LD5wYpmzZDQ0+A164XQXb2Vu90U8IrV7HEvniwpVuEIpmLutsPYRMLSt8GQVo08za
        5ZwpE0Xxn6ganJSOIf1WzYVjPRH7kXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-MOLVfDkBPSqz0dXooxWcLQ-1; Tue, 01 Feb 2022 08:06:10 -0500
X-MC-Unique: MOLVfDkBPSqz0dXooxWcLQ-1
Received: by mail-wm1-f70.google.com with SMTP id r9-20020a1c4409000000b00352cf8b74dcso812000wma.0
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 05:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/JQQOEd58RWuQGlfFpmDXOvRRGfDXT71ddV8rPIIJl0=;
        b=8IrLXRkPNwB+wH1D8O8hVLO6UDMZywjMVdt8pN3F1o3x8HjU1TgEOpuowgKNEbQ0w6
         /Djw4rRi42auJB6VThsN0qNSNHjCQa8E0WVDS6puuSZQzUpY/hLMvlCHz9CBMNy8rcpq
         fRz0vxuGB3Jr9Xv87noJcOqa0tHJNHVnMfLeQ5KZhxadR7y4L658IobJ1WFaod3qLo1/
         WpIHTD0SOBBjImuqW0N7UAJ0X+vVOizM6yf1ebaupecy8CBLmvJSzEZCEFLYmKal08XB
         2siVmsEEmY12CfxAsPsmPtrXkpTo+w0I1OMh0wQHduIrPoBnb7pXMCXNuIfJBSPHGyZ7
         YM/Q==
X-Gm-Message-State: AOAM533B6oFspgkgK/G58JotN4T+FHmQbVcxTU76OAeszZIoyDU3hwag
        K0IPmVNohrZxedrcTyR0KBxCRl6ZqbKk3KNmDUFJJC1f7rhdM+g8N7hCEHjTHafSp7CA0/+Sur8
        oXdT7ag9ujRb/BNMPRuMqhYY=
X-Received: by 2002:a1c:3586:: with SMTP id c128mr1752538wma.15.1643720769213;
        Tue, 01 Feb 2022 05:06:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYHBjANBhvf+E+2paUEQ5NN7skEmnIc89W4J4poW5Ib7Aw4MHr3Wo/i0Jc5irQYQHxGDNJ+g==
X-Received: by 2002:a1c:3586:: with SMTP id c128mr1752519wma.15.1643720769023;
        Tue, 01 Feb 2022 05:06:09 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4sm15793539wrs.6.2022.02.01.05.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 05:06:08 -0800 (PST)
Message-ID: <4322f58b-dbeb-b90f-2770-d6881f8005b4@redhat.com>
Date:   Tue, 1 Feb 2022 14:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Content-Language: en-US
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
 <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Noralf,

On 2/1/22 13:58, Noralf Trønnes wrote:
> 
> 
> Den 31.01.2022 21.52, skrev Sam Ravnborg:
>> On Mon, Jan 31, 2022 at 09:12:21PM +0100, Javier Martinez Canillas wrote:
>>> There isn't a connector type for display controllers accesed through I2C,
>>> most drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.
>>>
>>> Add an I2C connector type to match the actual connector.
>>>
>>> As Noralf Trønnes mentions in commit fc06bf1d76d6 ("drm: Add SPI connector
>>> type"), user-space should be able to cope with a connector type that does
>>> not yet understand.
>>>
> 
> It turned out that I wasn't entirely correct here, mpv didn't cope with
> unknown types. In the PR to add support Emil Velikov wondered if libdrm
> should handle these connector names:
> https://github.com/mpv-player/mpv/pull/8989#issuecomment-879187711
> 

I see, thanks for the information. What should we do then, just use the type
DRM_MODE_CONNECTOR_Unknown then ?

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

