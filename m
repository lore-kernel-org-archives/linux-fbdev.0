Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94489C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9C661B62
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 09:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhKPJdd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233119AbhKPJda (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Nov 2021 04:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637055033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSJuWcsoneSy8n7p/CMH5CiBgKa6pj13KM6UjkRVYgQ=;
        b=ZNuw90pTNo8VJXxz7jytgIOtMXeoDb4DbUHAGdahSP8vRwHAmGwfZGKZBZwHU/MeHpkhZ/
        xNSSa13UmHXu20euuyTvHp1oK2pcwzIz4pX49X2ZgQUrlJBPk1I53JXypZDih8s43l3jBX
        je44eTgQy+Yl+yCqbLiqHFpaMNaHcPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-FXHSSIIBOiKlrSplbO1-Hw-1; Tue, 16 Nov 2021 04:30:32 -0500
X-MC-Unique: FXHSSIIBOiKlrSplbO1-Hw-1
Received: by mail-wm1-f70.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so940637wma.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 01:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mSJuWcsoneSy8n7p/CMH5CiBgKa6pj13KM6UjkRVYgQ=;
        b=jeIpHLiHN/8uBjf1k9+6Ntj1nxiqeOZoAeorX9VkAC34Ia3BmThsuukkMH0AumG5br
         oQjn4UkTCW5z7NwwDefGUTto1hUW57n6931lAEM6S/Q3UoGK2rRF6C0BFZj4TNkTgwoS
         2aMWsPutUcF0yERK8Mn0Un8vl//Cv/EV9imonwh8PYdzt6p/z6aAA+3kKoSj39AlS+Lj
         KVq3zqWA6Uo06iFVyxD721gAiE8B7JsL5rxjiWU8MWdqRDf3A/xrXBOm4PUBZ7rF+6or
         9eGjL0XdHNNqK75FtZOkPSxVbycsROJHYkYuw3/kYX+QVaIxWniQy6a5k+fFwBz6jOTy
         GpaA==
X-Gm-Message-State: AOAM533MJToDmpKMYeUytDYaDKz7Q078iwBQRMhXd3Vd0wUJjokHdRPq
        dhV2JeeDQnTI+aQG+H3/TfIb7BHgp6IERdBJjCV5w4Chz1CKrGe8d6Yt2hko7QIMBRl01jRF0+0
        TlxgP2N1SrJxp/gfwUOxRvBQ=
X-Received: by 2002:adf:a389:: with SMTP id l9mr7555781wrb.121.1637055031192;
        Tue, 16 Nov 2021 01:30:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgwiZj0DgXvYqrW2sWMV/yCu3WNu9rReMDFw4j3A00MnBKJ5k23ydvxJPOILvWBidIQ2S8/A==
X-Received: by 2002:adf:a389:: with SMTP id l9mr7555735wrb.121.1637055030865;
        Tue, 16 Nov 2021 01:30:30 -0800 (PST)
Received: from [192.168.1.102] (91.pool90-171-47.dynamic.orange.es. [90.171.47.91])
        by smtp.gmail.com with ESMTPSA id p2sm1944790wmq.23.2021.11.16.01.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:30:30 -0800 (PST)
Message-ID: <579a584a-68af-d5c9-0547-30cb1592d46f@redhat.com>
Date:   Tue, 16 Nov 2021 10:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is
 already registered
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211111111120.1344613-1-javierm@redhat.com>
 <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

On 11/15/21 17:20, Geert Uytterhoeven wrote:

[snip]

>> @@ -351,6 +351,17 @@ static int efifb_probe(struct platform_device *dev)
>>         char *option = NULL;
>>         efi_memory_desc_t md;
>>
>> +       /*
>> +        * Generic drivers must not be registered if a framebuffer exists.
>> +        * If a native driver was probed, the display hardware was already
>> +        * taken and attempting to use the system framebuffer is dangerous.
>> +        */
>> +       if (num_registered_fb > 0) {
> 
> Who says this registered fbdev is driving the same hardware as efifb?
> This might be e.g. a small external display connected to i2c or spi.
> 
>> +               dev_err(&dev->dev,
>> +                       "efifb: a framebuffer is already registered\n");
>> +               return -EINVAL;
>> +       }
>> +

That's true, although I wonder if the {efi,simple}fb drivers should even be
probed in that case. As I see it, these are always a best effort that are
only useful for earlycon or if there isn't another display driver supported.

Since there may be other conditions needed in order for these to work. For
example, when using the u-boot EFI stub in most cases the unused clocks and
power domains can't be gated or otherwise the firmware frame buffer could go
away (e.g: will need to boot with "clk_ignore_unused" and "pd_ignore_unused").

Same for the simplefb driver, if the DT node is missing resources that are
needed by the display controller to continue working (clocks, regulators,
power domains), the firmware setup framebuffer will go away at some point.

So this is already a fragile solution and $SUBJECT doesn't make things worse
IMO. Since not having something like this can lead to issues as reported by:

https://lore.kernel.org/all/20211110200253.rfudkt3edbd3nsyj@lahvuun/

We could probably do some smarter here by providing a function that checks
if the registered fbdev drivers matches the aperture base. But I'm unsure
if that's worth it. After all, fbdev drivers are likely to be disabled by
most distros soon now that we have the simpledrm driver.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

