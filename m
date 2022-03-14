Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9CC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Mar 2022 14:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbiCNOJA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbiCNOI7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Mar 2022 10:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93008B7C8
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Mar 2022 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647266868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1n9imp/roVGFW+MJg7Js2iXDtKYDylDPOOBQLufwOMo=;
        b=Ib7Pdsjf9S4oNapcCrEYDvb9D+sgnXAUpoPBex98vP0pq+qX/rUUst20SGJKrSmL+SBYnh
        6/A3zMb9MSxgkmNe8+N1yO9TZhX9ABkLiAtNdcAfZL2rpOJdaOrmFv9jjgG6wnliAJmLET
        yhcikAupQIvbLDXRtM06kaTDOJPwsGM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-vIS3shY1OV2NPl1WlOBQ7w-1; Mon, 14 Mar 2022 10:07:47 -0400
X-MC-Unique: vIS3shY1OV2NPl1WlOBQ7w-1
Received: by mail-wm1-f69.google.com with SMTP id 26-20020a05600c22da00b00388307f3503so7086839wmg.1
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Mar 2022 07:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1n9imp/roVGFW+MJg7Js2iXDtKYDylDPOOBQLufwOMo=;
        b=rj7cREM8Gz+r9G1tcr/n4EhOVPnCNre6GrAA+EW77xHFCPKlZMtdZIUneXhX6PwHSr
         l0UUvc+3ODsLCTIokO+TaqqNX7y1Xix9r0rtzflUerpzJX9b62d2T9kyRxE2+Bresd6v
         9Gq2zuYY6WXy43sojB8YHWumv0iQGHmAtT7XkcIyPJ0vmPNWFoJpYSk/4HXTE4OjqR8t
         ZTLBSKVypx/Ryf82PgVaYFR0fpHSxFv/kuxzhgCm65qJAs70CTlUnqzheWjexPCfTRS8
         goDBJmKMeKW8n5YYwo9T5hvCORoaRgTh1PyL0dJac96BwSWckaGaTIaBt73hBePebLBv
         WPnQ==
X-Gm-Message-State: AOAM531zGyfvaV8t/g5CmMnevakzCXbjOTyd7pCjnd7yVRuRmuupNw6F
        VzsF/50bcRUHH8hGi6rPFVGKpqd+ERlAVE7kCfSJ8snSFTYZNXkzuS/jUVTbp0GyC/fOVOI63kC
        RgIHreKBs+ygmC372jVp+n/o=
X-Received: by 2002:a5d:6daf:0:b0:203:8214:ae65 with SMTP id u15-20020a5d6daf000000b002038214ae65mr16784121wrs.145.1647266866161;
        Mon, 14 Mar 2022 07:07:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUmZKMWpb2vbN6Fu8O0zteEWAjmmY/DHvyxw4A1qQVFF+i6VWRfQ9qS5Kjt/nNczT10/+Vzw==
X-Received: by 2002:a5d:6daf:0:b0:203:8214:ae65 with SMTP id u15-20020a5d6daf000000b002038214ae65mr16784102wrs.145.1647266865920;
        Mon, 14 Mar 2022 07:07:45 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b00389bcc75559sm15441665wml.27.2022.03.14.07.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 07:07:45 -0700 (PDT)
Message-ID: <9b8bbc6a-e499-99c7-8fe6-95c4256ef61d@redhat.com>
Date:   Mon, 14 Mar 2022 15:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] drm/format-helper: Add
 drm_fb_gray8_to_mono_reversed()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-3-javierm@redhat.com>
 <CAMuHMdWPQrErbMZ4wJPgROY7XOnKGvimNFg8JpiyuWqz2a3Gzw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWPQrErbMZ4wJPgROY7XOnKGvimNFg8JpiyuWqz2a3Gzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

On 3/14/22 14:40, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Mon, Jan 31, 2022 at 9:12 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Add support to convert 8-bit grayscale to reversed monochrome for drivers
>> that control monochromatic displays, that only have 1 bit per pixel depth.
>>
>> This helper function was based on repaper_gray8_to_mono_reversed() from
>> the drivers/gpu/drm/tiny/repaper.c driver.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
>> --- a/drivers/gpu/drm/drm_format_helper.c
>> +++ b/drivers/gpu/drm/drm_format_helper.c
>> @@ -584,3 +584,38 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>>         return -EINVAL;
>>  }
>>  EXPORT_SYMBOL(drm_fb_blit_toio);
>> +
>> +/**
>> + * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
>> + * @dst: reversed monochrome destination buffer
> 
> What's the meaning of "reversed"?

Originally I took this helper from the repaper driver and it was called
repaper_gray8_to_mono_reversed(), so the naming just got carried over.

> During the last few days, I've been balancing between (a) "reverse
> video" and (b) "reverse bit order", but none of them seems to be true.
>
> (a) The code maps 0-127 to 0 and 8-255 to 1, which just reduces from
>     256 to 2 grayscale levels, without inversion. The result is also
>     white-on-black on my ssd130x OLED.
> (b) On little-endian, the CFB drawops use little-endian bit order,
>     which is what ends up in "byte" in the code below.
>

As far as I understand is (a) from the options since the repaper display
uses black-on-white. But as you pointed out the ssd130x OLEDs instead do
white-on-black.

I should had probably just name the helper drm_fb_gray8_to_monochrome()
or maybe drm_fb_gray8_to_gray1() ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

