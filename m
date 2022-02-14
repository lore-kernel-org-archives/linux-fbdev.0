Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019AC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 08:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiBNI5g (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:57:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbiBNI5e (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 03:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4A855F8F9
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 00:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644829046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69HvyvUIhOkkZrR25T0A4ak3h9jrAFSNcZowRzKJYOE=;
        b=Zjzwtl4YMYyVNy9+afaGXUCmm9n2IgIfHb/tE3TlE3kwQDfjCXdg2TgDIe1dwgCsXOTjok
        Duf6fbR2EUVTkIAb19nMK1dkHtKmrQl1UcHgpFHtdbY8/ISKj7445tU0fTrDkVatiD6725
        8aNIoXkU+tUkFTTWTrbxsri8L9Jch8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-88xhKrfhNtKsnVr5q_HeFg-1; Mon, 14 Feb 2022 03:57:25 -0500
X-MC-Unique: 88xhKrfhNtKsnVr5q_HeFg-1
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso4711686wmb.6
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 00:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=69HvyvUIhOkkZrR25T0A4ak3h9jrAFSNcZowRzKJYOE=;
        b=mJf4/wlExArO/VzgNkgeEfYPwgSzmOY9TfZyf54kORrdXmm1WcJc5OJEw6NTPGWkLe
         TFa9v7/F366XkwGKg7i4fNU0//Do2YhGCnPtt3kEjNZHQCLD9y6kX0EvL5fwGSTjRa08
         Z20R2t+Sl0f0rHQ1L9O12IlGDR68ALcTzDmLIpFJPlBeiTqdrj/tmAoSzsvVPK44C+6t
         3nBIJCRzCh3CXdresvmwRJrCsWJ82oiIj6nv+ccrjE/DfSUpI8bF9mc64nJ11mp48gtA
         BDks8UFPz47nb4DijXdFNtVLzO7/SO6oVZlzX0kx0MxdX8v02nFgOR4LNsE99TYhIN8/
         yzug==
X-Gm-Message-State: AOAM531NUEMkC6EVp5UFwjqFKRnPmiVUYd/J+SxNU6TCg+SzIHYKAtxR
        MHaYhtPYcVFUlvzTvpprqGvjv99miWfa7tMeM03Ztfng95kl3/YdQAaniHF79Iv+YGx6wdeFF7Q
        Qzg/TO1blNoHsxkpnmtyokFI=
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr10133012wmr.141.1644829044201;
        Mon, 14 Feb 2022 00:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLJdMQROn0HBjGMEca6+PzxDVdcjo/+C+qxpaxDMr5SR2UrWB2rcNzjEWlQvJ11E6dtoU4Jw==
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr10132993wmr.141.1644829043953;
        Mon, 14 Feb 2022 00:57:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l20sm11561086wmq.22.2022.02.14.00.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 00:57:23 -0800 (PST)
Message-ID: <e50211b1-08fa-de09-8948-664493423c33@redhat.com>
Date:   Mon, 14 Feb 2022 09:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220211143358.3112958-1-javierm@redhat.com>
 <20220211143358.3112958-3-javierm@redhat.com>
 <CAMuHMdUeqXs2PeV9s8+edPpOGodRT=it3g+fOTB7DuTuW2J9ZA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUeqXs2PeV9s8+edPpOGodRT=it3g+fOTB7DuTuW2J9ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

Thanks for your feedback.

On 2/12/22 16:54, Geert Uytterhoeven wrote:

[snip]

>> +
>> +               for (i = start; i < end; i++) {
>> +                       unsigned int x = xb * 8 + i;
>> +
>> +                       byte >>= 1;
>> +                       if (src[x] >> 7)
>> +                               byte |= BIT(7);
>> +               }
> 
>     x = xb * 8;
>     for (i = start; i < end; i++) {
>             byte >>= 1;
>             byte |= src[x + i] & BIT(7);
>     }
> 

I think the original version from Noralf is easier to read and understand.

It makes explicit that the bit is set if the grayscale value is >= 128.

[snip]

>> +void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
>> +                                     const struct drm_framebuffer *fb, const struct drm_rect *clip)
>> +{

[snip]

>> +       u8 *mono = dst, *gray8;
>> +       u32 *src32;

[snip]

>> +        *
>> +        * Allocate a buffer to be used for both copying from the cma
>> +        * memory and to store the intermediate grayscale line pixels.
>> +        */
>> +       src32 = kmalloc(len_src32 + linepixels, GFP_KERNEL);
>> +       if (!src32)
>> +               return;
>> +
>> +       gray8 = (u8 *)src32 + len_src32;
> 
> The cast can be removed if src32 is changed to "void *".
> For symmetry, gray8 and mono can be changed to "void *", too.
>

Yes, but these being "u32 *" and "u8 *" also express that the source buffer
contains 32-bit XRGB8888 pixels, the intermediate buffer a 8-bit grayscale
pixel format and the destination buffer a 8-bit packed reversed monochrome.

Using "void *" for these would make that less clear when reading the code IMO.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

