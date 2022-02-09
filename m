Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFD8C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 15:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiBIPbD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 10:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiBIPbA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 10:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DABDC0612BE
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644420662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPpvyB7McdG+sCGO6qQRcD8vYFMWX9f+Cg4663yTg2s=;
        b=a8KbDlb4GGIEg9Cjf8Zl80Fpvi0/d8HvroNARdOX76rbAFY9QAEHiwUeqrFpfOJ5OoqQil
        Hg/mKf1+rXxw7qo3j3C06HtwoW7mg1FRgfwGIJGvADgOnQYJIIeyr02QIAkWW7SjNF21zD
        K1TqjYHfKaUlYx3uyAMfL1e28iHiOk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-pJClIMIfP3GeHR5lSfsshg-1; Wed, 09 Feb 2022 10:31:01 -0500
X-MC-Unique: pJClIMIfP3GeHR5lSfsshg-1
Received: by mail-wr1-f71.google.com with SMTP id h24-20020adfaa98000000b001e33eb81e71so1245984wrc.9
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 07:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WPpvyB7McdG+sCGO6qQRcD8vYFMWX9f+Cg4663yTg2s=;
        b=c1ZS7u31dv1F05iNjN33W1rwJuuTP3nEvZov7dOa9+WS188kvVd9TWXD5MjsCNT9V+
         LxsSbROAaHhzE/UISZii7BKO6qKCluJP5cOrjX8JXpftXtolvtI8MlHDCvuRq1Iaccan
         2tP/fAHlpOo9PYk6yT7gGipPQ68IHiQzgVreDMrm0wkFMI9knpHGY76D5MXxjsrdOndk
         t6i/lnO8pHXrnim3K/Lqir1i6woM4uH4VOHc0U+tosVp279B+wwNJTRYoYqxWUhosAHb
         ZtJxv2+mtPp6FCE4qjttMxAJ2AHsPDNc8QnIHmGsPXY4d/at9kNUUX4miAhx/rvZZOsd
         gBuw==
X-Gm-Message-State: AOAM532HfSm7NxQ7x22e5Uf5RO1isJ2a7Q2gwcc3vzaWhYsxPS7SZVKK
        Y1aDYGCQJGrtpCjj6CgDEeNoE7pPa9PnfmBqWmHPNiLM4Z1PeaGDHkJsVlVimdW5QHTkQyAOGfR
        hmEycr7HKaZnmIMfjIWEb7dc=
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr2557992wrq.6.1644420659909;
        Wed, 09 Feb 2022 07:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUJ460salQYs6rWREOZPwbsIL73KBkIAP9a0luO40gtQzhT1NgjwQDGKwNSlhfORRzFqslOg==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr2557983wrq.6.1644420659724;
        Wed, 09 Feb 2022 07:30:59 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c8sm6408714wmq.39.2022.02.09.07.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:30:59 -0800 (PST)
Message-ID: <3b6fe640-47e5-8765-3a09-8f9f2f0a6329@redhat.com>
Date:   Wed, 9 Feb 2022 16:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/7] drm/format-helper: Add drm_fb_{xrgb8888,
 gray8}_to_mono_reversed()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-3-javierm@redhat.com>
 <6df9c28d-968d-ff16-988e-8e88e4734e49@suse.de>
 <f75a1544-5a3e-e49f-7eab-5dd5c72584b9@redhat.com>
 <d5fc654c-643a-7b20-85f1-54169a3aa889@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d5fc654c-643a-7b20-85f1-54169a3aa889@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 16:21, Thomas Zimmermann wrote:

[snip]

>>
>> It could be taken from this patch-set anyways if someone wants to wire the
>> needed support for R8.
> 
> I think, policy is to not keep unused code around.
>

Ok, I'll drop it then. We can include it again when adding R8 formats.
 
[snip]

>>> If might be faster to allocate both buffers in one step and set the
>>> pointers into the allocated buffer.
>>>
>>
>> Not sure I got this. Do you mean to have a single buffer with length
>> linepixels + len_src32 and point src32 and gray8 to the same buffer ?
> 
> That's the idea. I don't know the exact overhead for kalloc(), but at 
> least the in userspace, malloc() in hot code paths is not a good idea. 
> There's usually some searching for free space involved.
>

Sure, let's do it in one allocation then and I'll add some comments to
make easier for people to follow the code.
 
> In the long term, we could add a field in struct drm_framebuffer to keep 
> such buffers around for reuse.
> 
>>
>>>> +
>>>> +	/*
>>>> +	 * For damage handling, it is possible that only parts of the source
>>>> +	 * buffer is copied and this could lead to start and end pixels that
>>>> +	 * are not aligned to multiple of 8.
>>>> +	 *
>>>> +	 * Calculate if the start and end pixels are not aligned and set the
>>>> +	 * offsets for the reversed mono line conversion function to adjust.
>>>> +	 */
>>>> +	start_offset = clip->x1 % 8;
>>>> +	end_offset = clip->x2 % 8;
>>>
>>> end_len, again. If you have 1 single bit set in the final byte, the
>>> offset is 0, but the length is 1.
>>>
>>
>> Agreed, will change it too.
> 
> Feel free to add my
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks!

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

