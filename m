Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71180C4167B
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Nov 2023 17:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjKARzm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjKARzl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Nov 2023 13:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18511D
        for <linux-fbdev@vger.kernel.org>; Wed,  1 Nov 2023 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698861293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnKpb4EeK07qAJufbEwOR+W4LEQMu0mtbC3uRm1Hwfg=;
        b=T7CKSQCo+4p1EXCJcHJXjv9u0OyIl6Ot25lEZxWl6RpND63Y3OijiBHgUdLb9nnLwRgajh
        50PsAXY6bdWRVcCfMA7ZQBtCEcNeKSJAYxaPwtgPKeIlHebYHzJdYg/7Dcm1PCjCZsxK07
        4cmSjxjLuK4T04WqN3YjyX0Ee0nQbdM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-gcLwgStJMAaTafowN2Jdug-1; Wed, 01 Nov 2023 13:54:50 -0400
X-MC-Unique: gcLwgStJMAaTafowN2Jdug-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53ee9f409a9so23463a12.1
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Nov 2023 10:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861289; x=1699466089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnKpb4EeK07qAJufbEwOR+W4LEQMu0mtbC3uRm1Hwfg=;
        b=ZqgjzLBAXaOKMQ1ZGBawcn8dmwynHZ5Nu5mdDje/fbqDNxNlBtjxZvmaPXDd2LeyA+
         Ny6WOa3emxEfTrKSsOlkjr3YY+CoFoRyD61W8t9UnD4uqrI8Eqgu98MJvN2iLr0k4dh/
         N9U71V/tssLCJmcPNIXWIZAgH6FK8ie7fH95I+MDoK0lSftoQCM8OpiDvvDWK8+4f10A
         iaNfcdVSg4OVE8h0wEzX4Hpy6IBp7AawVLZ0ZXdu/mxmYJnDF7YmzWFeLMLL1iVK4T+4
         AFga30/EBepeU9T6/4ahx4bsAaMm+QmY1lJlyo1bWJ/OiS6xD+Nr2W3cen+5qgXBjgYc
         ywAQ==
X-Gm-Message-State: AOJu0Yye6PrAPdRxuQdPg5FRW3/afIlUhZkLXRDAwgQoeOQD70MltrT6
        DVTef9P9I6Eq1AfIRZqYvT+eNIgXZEnWl2jM10b+bdfdUhR43v6/o4d4UNzppk/yPraVz3YAKsU
        QJUKR0GLzbF6dAaKVet8y2++LMbNCq0A=
X-Received: by 2002:aa7:d0ca:0:b0:530:74ed:fc8a with SMTP id u10-20020aa7d0ca000000b0053074edfc8amr13224040edo.41.1698861289534;
        Wed, 01 Nov 2023 10:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVnFRMTGJHQlmpCorHWXgjX/JDj2IwGcvCvUpQyXc80EQmO4QlCuNvR898VgWual5BmnPZQQ==
X-Received: by 2002:aa7:d0ca:0:b0:530:74ed:fc8a with SMTP id u10-20020aa7d0ca000000b0053074edfc8amr13224026edo.41.1698861289276;
        Wed, 01 Nov 2023 10:54:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l2-20020a50d6c2000000b0054018a76825sm1353748edj.8.2023.11.01.10.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:54:48 -0700 (PDT)
Message-ID: <56fbbe6c-0342-01d9-9840-40c7fa13f1f2@redhat.com>
Date:   Wed, 1 Nov 2023 18:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/2] fbdev/simplefb: Add missing simple-framebuffer
 features
Content-Language: en-US, nl
To:     Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
References: <20231101172017.3872242-1-thierry.reding@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231101172017.3872242-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 11/1/23 18:20, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi,
> 
> This contains two patches that bring simplefb up to feature parity with
> simpledrm. The patches add support for the "memory-region" property that
> provides an alternative to the "reg" property to describe the memory
> used for the framebuffer and allow attaching the simple-framebuffer
> device to one or more generic power domains to make sure they aren't
> turned off during the boot process and take down the display
> configuration.
> 
> Changes in v2:
> - remove unnecessary call to simplefb_detach_genpds() since that's
>   already done automatically by devres
> - fix crash if power-domains property is missing in DT

Thanks, the new version looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Helge, will you pick these 2 up, or shall I push them to drm-misc-fixes?

Regards,

Hans





> Thierry Reding (2):
>   fbdev/simplefb: Support memory-region property
>   fbdev/simplefb: Add support for generic power-domains
> 
>  drivers/video/fbdev/simplefb.c | 128 +++++++++++++++++++++++++++++++--
>  1 file changed, 123 insertions(+), 5 deletions(-)
> 

