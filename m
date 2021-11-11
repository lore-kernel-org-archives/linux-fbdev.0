Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD2FC433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 11:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC1B61058
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 11:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhKKLVE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230400AbhKKLVC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Nov 2021 06:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636629493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cm+DUi8ko4XSbRJD2kBqXRStf4XmBaQnXCvcSQsugM4=;
        b=O7OOvBcQuZjmXK/lX+1egIUxRrTeKwPtodZyIMhTfFHcsn9cA92ffIcZkPD7RKqBIDFEew
        HO3WfzDe7EgOF+bpnp+6GwuGjWxdrg2xugHZ+z98o4gZkk0rH/HpB+yOjImFtfsg5aVBPh
        wsfEWTfLlwJ0xB1/NTQJMEHdssLkEC4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-EbI0VzldMHe_Gmbpy6Dc7A-1; Thu, 11 Nov 2021 06:18:12 -0500
X-MC-Unique: EbI0VzldMHe_Gmbpy6Dc7A-1
Received: by mail-wm1-f71.google.com with SMTP id a67-20020a1c7f46000000b00333629ed22dso1066641wmd.6
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Nov 2021 03:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cm+DUi8ko4XSbRJD2kBqXRStf4XmBaQnXCvcSQsugM4=;
        b=j4QyYuzn/UEFHqe4wJ3JMkXJMwmQu9N39zq7t4QesuvlVaF4TWkUz6lRM1kRmV+FWY
         PpelDwoKuagjlJ5nJ8YvJr66rIqncrPWpzs/kAaKuokKb0biQ3NFGKxMMo9vH9dt+f9j
         +ujSqCT/erwUniHQvoAWtFdyVBMsecWAlOzFby6dvqPB3IVrVLjkakrtkcbpIzsPkqUl
         UiXPSovF9iX28C6V35SrQuKYTV3JHFSLxmRVEjwvYS99Lud2D7nDTN3MycE59v6Co2+E
         urM/jy5Q9BgYKHsqHErAiu5xZNijdrjtWwzgsbOZzVsqo5fQeYdekop7a2MHxsbQGGKL
         D6hg==
X-Gm-Message-State: AOAM53198d1oPWGmeAvIWBFoe6Hfp+tC/wxIsuKv3/NxyI0MhtekmS4D
        bYgfzdSH/HSM/6v55QVjl5fx13ayBn4PDpCQj4NW93dMmzcwsyOFLE8tWeXGIt4dWGaZumvFV86
        YLQxqEV2Vq6xwJfFBUjA9GNU=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr24715982wmk.40.1636629490889;
        Thu, 11 Nov 2021 03:18:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4QxzjI3CdpXCnsWkA7eOREXt8H1mIwhs9QLzOlluAuSBhSe0vmw+5iQBIRwQe7D8C02d50Q==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr24715959wmk.40.1636629490719;
        Thu, 11 Nov 2021 03:18:10 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o2sm2797562wrg.1.2021.11.11.03.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 03:18:10 -0800 (PST)
Message-ID: <62258612-be91-d195-58e4-057819e7b29e@redhat.com>
Date:   Thu, 11 Nov 2021 12:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fbdev: Prevent probing generic drivers if a FB is already
 registered
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>
References: <20211111092053.1328304-1-javierm@redhat.com>
 <YYzoWTMBkC64a4Cn@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YYzoWTMBkC64a4Cn@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Daniel,

On 11/11/21 10:54, Daniel Vetter wrote:
> On Thu, Nov 11, 2021 at 10:20:53AM +0100, Javier Martinez Canillas wrote:
>> The efifb and simplefb drivers just render to a pre-allocated frame buffer
>> and rely on the display hardware being initialized before the kernel boots.
>>
>> But if another driver already probed correctly and registered a fbdev, the
>> generic drivers shouldn't be probed since an actual driver for the display
>> hardware is already present.
>>
>> Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Thanks for your review.
 
> Also Cc: stable@vger.kernel.org?
> 
> btw time to organize drm-misc commit rights so you can push stuff like
> this?

Yes, I'll start the process today to request that.

> -Daniel
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

