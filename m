Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12388C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 11:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiBALsw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 06:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237587AbiBALsr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 06:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643716127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAQrcI0deDlNA9eCisSMwUR/TZsbNGoMTXQyByv6Pq0=;
        b=VRBAKh1Ai5vH0ajraEih6JrMLbejf57xM3h9aW/lsbpM/JvRs73cXJTmQxVM0jlrWCF2rs
        4s1hCcfIbpQ05eSqZLQo0o4ThwCORgcI+iJTj9kMnbXTUGjHEWpVb8oU+T2VasOZvSAmQU
        B4JytFc3tvf3YgS8swy8aEd+AJNaizI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161--1mIqCbEMPuR9D6UKcAINg-1; Tue, 01 Feb 2022 06:48:46 -0500
X-MC-Unique: -1mIqCbEMPuR9D6UKcAINg-1
Received: by mail-wr1-f69.google.com with SMTP id c10-20020adfa30a000000b001d79c73b64bso5943898wrb.1
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 03:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HAQrcI0deDlNA9eCisSMwUR/TZsbNGoMTXQyByv6Pq0=;
        b=tQcgL6XKVbeNlW0DXIcKABLYeQJjwRrTX9XbaMTqwb8e9PmN4UIA38bw8KaotUhEa/
         egoK6wH9ODvHDxr8vN7QaLiPykOTaij8LlzlvgWRV8MoG05Lg+QfByswAbElREc1zgfw
         CRwdCHio0Wa70fUWz4mhUMSpxCGrI+tulZ5FYWppeJPl3U6LEQlfvS3pt1vjsdCAg9Ms
         bj7G0MxL1I+2O093fI8iIVmb8miBn6WggLKo9v4kchm02ODEPKCkRP2026Oex8uE7wd6
         X0TPQimiFREBAxUiFW6EGN5yw/KlPWcv16eFYLeAITD+egUNry/+KSOS/ANZ6yXiUXOj
         napw==
X-Gm-Message-State: AOAM530aSsMngqqVY/Df5NRqKqfCsq+5ZK1F184MjqP8ILas6WBfwRZj
        VYD6molmtjLoXxsBd2D7dtsnL8A4GBk27+7iqVsn/GqMwECkG2jlCtgrmkTK7+mqLBsdLYCjRnM
        ZI7tMxX4j6YeeXwS1v+IXOIQ=
X-Received: by 2002:adf:f58f:: with SMTP id f15mr12076475wro.192.1643716124452;
        Tue, 01 Feb 2022 03:48:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzd9BlV0HRMbyk/XwhfXyaNQQpXbeT1Gbtln4v7etwlKLUXdBdHLLvcKWVu2NnD4Vi+vIyooQ==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr12076463wro.192.1643716124242;
        Tue, 01 Feb 2022 03:48:44 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g6sm14023059wrq.97.2022.02.01.03.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:48:43 -0800 (PST)
Message-ID: <c10f8a68-6c45-41ec-7061-ff69360f1fbb@redhat.com>
Date:   Tue, 1 Feb 2022 12:48:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] drm/format-helper: Add
 drm_fb_gray8_to_mono_reversed()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-3-javierm@redhat.com>
 <e52560f0-bd0c-b51b-af1b-bd4be2df8702@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e52560f0-bd0c-b51b-af1b-bd4be2df8702@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

Thanks a lot for your feedback.

On 2/1/22 10:59, Thomas Zimmermann wrote:
> Hi
> 
> Am 31.01.22 um 21:12 schrieb Javier Martinez Canillas:
>> Add support to convert 8-bit grayscale to reversed monochrome for drivers
>> that control monochromatic displays, that only have 1 bit per pixel depth.
>>
>> This helper function was based on repaper_gray8_to_mono_reversed() from
>> the drivers/gpu/drm/tiny/repaper.c driver.
> 
> You could convert repaper to the new helper.
>

Yes, I plan to do it but was out of scope for this patch series.

>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/gpu/drm/drm_format_helper.c | 35 +++++++++++++++++++++++++++++
>>   include/drm/drm_format_helper.h     |  2 ++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
>> index 0f28dd2bdd72..bf477c136082 100644
>> --- a/drivers/gpu/drm/drm_format_helper.c
>> +++ b/drivers/gpu/drm/drm_format_helper.c
>> @@ -584,3 +584,38 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>>   	return -EINVAL;
>>   }
>>   EXPORT_SYMBOL(drm_fb_blit_toio);
>> +
>> +/**
>> + * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
>> + * @dst: reversed monochrome destination buffer
>> + * @src: 8-bit grayscale source buffer
>> + * @clip: Clip rectangle area to copy
>> + *
>> + * DRM doesn't have native monochrome or grayscale support.
>> + * Such drivers can announce the commonly supported XR24 format to userspace
>> + * and use drm_fb_xrgb8888_to_gray8() to convert to grayscale and then this
>> + * helper function to convert to the native format.
>> + */
>> +void drm_fb_gray8_to_mono_reversed(void *dst, void *src, const struct drm_rect *clip)
> 
> IMHO it would be better to have a function that converts xrgb8888 to 
> mono and let it handle the intermediate step of gray8.
>

That's a good idea. I'll add that too.

>> +{
>> +	size_t width = drm_rect_width(clip);
>> +	size_t height = drm_rect_width(clip);
>> +
>> +	u8 *mono = dst, *gray8 = src;
>> +	unsigned int y, xb, i;
>> +
>> +	for (y = 0; y < height; y++)
>> +		for (xb = 0; xb < width / 8; xb++) {
> 
> The inner loop should probably go into a separate helper function. See 
> the drm_fb_*_line() helpers in this file
>
> At some point, we's want to have a single blit helper that takes source 
> and destination formats/buffers. It would then pick the correct per-line 
> helper for the conversion. So yeah, we'd want something composable.
>

Agreed. I'll split that into a separate helper function.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

