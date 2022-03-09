Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00147C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 12:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiCIMEL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiCIMEL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 07:04:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B007CA41AE
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 04:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646827389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tg1o0vf2e/XRSv/u3YehBRlt1pjhs1t2fKcaz6fZZ34=;
        b=idUtu5WxwdXiQun5W9+kmbYKBIHh5eFhsPdHeB5uPNAUcE2xBs8xZI52bYnjul9VsY5wWl
        r/b4MR/N51MZ8f2yJJAS7gq5QmRDdF+OBdKsGZxZRY52GuyujL502UnYJRfKsXnkZoOxpV
        u0VGDoZOQf71deZ3JHKkU7pYt3PZ+D0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-hCEV6LByNNSw1Alw-uTm7A-1; Wed, 09 Mar 2022 07:03:08 -0500
X-MC-Unique: hCEV6LByNNSw1Alw-uTm7A-1
Received: by mail-wr1-f71.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so684797wrh.14
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 04:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tg1o0vf2e/XRSv/u3YehBRlt1pjhs1t2fKcaz6fZZ34=;
        b=ciYyiVGBwHj3bVdb3PBKZQHX60tPGC2CqvY/dtICBOkxLXENHJAllpjsMyyehWyk2H
         7GhZ4rGnr8zGjFxLZoMh4V6/WDlQ+O/dRGNYO0PgWkr19G5YLzIr1h9SIW4QAaM4OYPx
         gjkFuDaaZaGMYjznFhiAyCXQnw/NG3FlKz2x3XH72uxWD3cmLr5vh/OgXk6IUR8jP1uK
         CEQOAQ8tbMD/6y/Mds/iWEZVeuDEzKlzU8wppSB3v55Zz+rdq78i8Jn3URvQL2p4Vp6i
         ZtJMgWeRhT6B9/Tyrxug+rcEC0L8mpgfKwoqyn6Ik3HYC4rFZtMfjvHGZafpPFtCUl7s
         dXoQ==
X-Gm-Message-State: AOAM531hLoOU3vB3gFy2V8XLTcsuBrVoYRqLEZIH3QjWepechPQ7efDj
        xZOwsMgDOC8yjRjVOdmIa+Ied273L2Rcs5UZNzm3i+5h9mgp/QkKllmVF7fzCGPOnu9miYGP4GO
        yllBrMGN3PKpb1t8PHgdV5LE=
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id 13-20020a05600c22cd00b00389c99a45a4mr3087814wmg.38.1646827387295;
        Wed, 09 Mar 2022 04:03:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvQMnTjm+Qq5odCLZwgqJ2OfY5/z2HM+SprEExkrP+P+U9HfPpAzWfgeU88YgEHXz8I1b3Nw==
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id 13-20020a05600c22cd00b00389c99a45a4mr3087777wmg.38.1646827386977;
        Wed, 09 Mar 2022 04:03:06 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g17-20020adff411000000b001f03426827csm1551217wro.71.2022.03.09.04.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:03:06 -0800 (PST)
Message-ID: <809430bb-4ffb-3bd4-7062-ec8b78245387@redhat.com>
Date:   Wed, 9 Mar 2022 13:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-3-javierm@redhat.com>
 <CAMuHMdWZHBVwaLDi-B=PrVOfcHxGLxwgDBisvexE94x72qvdJg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWZHBVwaLDi-B=PrVOfcHxGLxwgDBisvexE94x72qvdJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

Thanks a lot for your feedback.

On 3/8/22 17:13, Geert Uytterhoeven wrote:

[snip]

>> +
>> +static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,
> 
> "pixels" is not the number of pixels to process, but the number of
> bytes in the monochrome destination buffer.
>

Right, that parameter name is misleading / incorrect indeed. Probably
should be changed by dst_pitch or dst_stride.
 
>> +                                              unsigned int start_offset, unsigned int end_len)
>> +{
>> +       unsigned int xb, i;
>> +
>> +       for (xb = 0; xb < pixels; xb++) {
>> +               unsigned int start = 0, end = 8;
>> +               u8 byte = 0x00;
>> +
>> +               if (xb == 0 && start_offset)
>> +                       start = start_offset;
>> +
>> +               if (xb == pixels - 1 && end_len)
>> +                       end = end_len;
>> +
>> +               for (i = start; i < end; i++) {
>> +                       unsigned int x = xb * 8 + i;
>> +
>> +                       byte >>= 1;
>> +                       if (src[x] >> 7)
>> +                               byte |= BIT(7);
>> +               }
>> +               *dst++ = byte;
>> +       }
> 
> The above is IMHO very hard to read.
> I think it can be made simpler by passing the total number of pixels
> to process instead of "pixels" (which is bytes) and "end_len".
>

Agreed that's hard to read. I think is better if you propose a patch
with your idea to make it simpler.
 
[snip]

>> +void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
>> +                                     const struct drm_framebuffer *fb, const struct drm_rect *clip)
>> +{
>> +       unsigned int linepixels = drm_rect_width(clip);
>> +       unsigned int lines = clip->y2 - clip->y1;
> 
> drm_rect_height(clip)?
>

Yes, unsure why didn't use it since used drm_rect_width() for the width.
 
>> +       unsigned int cpp = fb->format->cpp[0];
>> +       unsigned int len_src32 = linepixels * cpp;
>> +       struct drm_device *dev = fb->dev;
>> +       unsigned int start_offset, end_len;
>> +       unsigned int y;
>> +       u8 *mono = dst, *gray8;
>> +       u32 *src32;
>> +
>> +       if (drm_WARN_ON(dev, fb->format->format != DRM_FORMAT_XRGB8888))
>> +               return;
>> +
>> +       /*
>> +        * The reversed mono destination buffer contains 1 bit per pixel
>> +        * and destination scanlines have to be in multiple of 8 pixels.
>> +        */
>> +       if (!dst_pitch)
>> +               dst_pitch = DIV_ROUND_UP(linepixels, 8);
> 
> This is not correct when clip->x1 is not a multiple of 8 pixels.
> Should be:
> 
>     DIV_ROUND_UP(linepixels + clip->x1 % 8, 8);
>

Agreed.
 
>> +
>> +       drm_WARN_ONCE(dev, dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
> 
> This triggers for me: dst_pitch = 1.
> Which is perfectly fine, when flashing an 8-pixel wide cursor ;-)
>

Indeed. I think we should just drop that warn.

Do you want me to post patches for all these or would you do it
when simplifying the drm_fb_gray8_to_mono_reversed_line() logic ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

