Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4788EC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 11:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiBALp6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 06:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237253AbiBALp5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 06:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643715957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULqxq85+QXgVuXkXrsFWoQ+Jj3hdrBT3Ayah3/h4Tac=;
        b=PfcO40Wx941Fs+5jlVj0SlHB5Rsbeexq+XpGc2NqXKeaScJvlJsICTc3a/BLqYAtHGCEFw
        ATM3v3hg4inG9EyUWDfASjR4MGQ4ioQprTX1WfH5nLe7cFeFGT+/DPKNVhhPYmRQkmMSp5
        2s3vp9i0fcpJIf4yimVkrcuHtJydBt8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-z6NBInhmPluTTki-LI0krw-1; Tue, 01 Feb 2022 06:45:56 -0500
X-MC-Unique: z6NBInhmPluTTki-LI0krw-1
Received: by mail-wm1-f69.google.com with SMTP id q127-20020a1ca785000000b00352a4860babso872617wme.0
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 03:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ULqxq85+QXgVuXkXrsFWoQ+Jj3hdrBT3Ayah3/h4Tac=;
        b=e2ZSLpqTHzIqYgZmkgQuQhcLq7aSMH5EZ3PgFtRLvXTNJBSOrtDPpbdyENVBNP0nsc
         ph0OMwEw6t4MCqUimS11F9jwl0ln6/+ZBwgNTn3rtTsV8Mm6CT3sOueA5qSce31yjSjM
         IxDx7x7EOkHkUr+MVYk+26TLVg7NeCF+oIcdw06oToYgAztCQ4KWWusSq/9jpHwoIiEI
         MudA1ajPI6GNhtEFGMCvXnwIKP2Z2bRiyNQxcJLN0OR/gyGYus0MJK4UYdV7g6asxtLC
         6QHDlSZ2Jlnqs3eoJtdCEhHtvXa8sGVaJuIx6bjhYhoFX0tYIpFRNi2xnFdINXrfit6G
         lm0w==
X-Gm-Message-State: AOAM533/t/XhvKGo+f3Tk/RxNu7ayzojdwRPZhw8Yd/V1M/87LmLVtLI
        4WywoEqGuBFlERIc7Y3Xv8e6n5FRCcuTCAVU8rA/vzgb0E9AySJ8/noAtz59C8rxpalk/0q9P/v
        CCgxZWoUSQixGfqpw220Le6k=
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr20919094wrx.79.1643715954914;
        Tue, 01 Feb 2022 03:45:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxu53NCCBkPLUIyYKlJCJN/UR7WXCnqrTa2SCyLCQ+kIZ18n0Z2nEp2RQQD+B1odXGUsfHjbw==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr20919072wrx.79.1643715954648;
        Tue, 01 Feb 2022 03:45:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h11sm1811015wmb.12.2022.02.01.03.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:45:54 -0800 (PST)
Message-ID: <9ddd8a8c-4aa9-bc4a-5637-66197a7342d1@redhat.com>
Date:   Tue, 1 Feb 2022 12:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>
References: <20220131202916.2374502-1-javierm@redhat.com>
 <YfhVBtv1UIA7bJja@ravnborg.org>
 <3aac291a-b30e-2775-336f-66dd08d634e2@redhat.com>
 <YfkA4ER/52I2v1JP@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfkA4ER/52I2v1JP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/1/22 10:44, Andy Shevchenko wrote:
> On Tue, Feb 01, 2022 at 01:14:22AM +0100, Javier Martinez Canillas wrote:
>> On 1/31/22 22:30, Sam Ravnborg wrote:
>>> On Mon, Jan 31, 2022 at 09:29:16PM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> The driver uses the pwms property for the backlight.
>>> It would have been much better to bite the bullet and require the
>>> backlight to be specified using a backlight node in the DT.
>>> This is the standard way to do it and then the driver could use the
>>> existing backlight driver rather than embedding a backlight driver here.
>>>
>>
>> I did consider that. Because that would allow me to use a struct drm_panel
>> and as you said make the core to manage the backlight. But then decied to
>> just keep the backward compatibility with the existing binding to make it
>> easier for users to migrate to the DRM driver.
>>
>> I wonder if we could make the driver to support both ? That is, to query
>> if there's a backlight with drm_panel_of_backlight() and if not found then
>> registering it's own backlight like the driver is currently doing.
> 
> If we keep 100% backward compatibility, just drop the old driver.
> After all module name is not so important as compatibility strings.
>

As mentioned I don't believe those two things are related. You could make it
backward compatible but still keep the old driver around until no one else
would care about it.

This DRM driver is brand new and there may be bugs, performance issues and
whatnot. At least I won't propose to remove the old fbdev driver but would
want people using DRM to have a choice.
 
> The problem with no backward compatibility means that removal of old driver
> makes users unhappy since DT is kinda ABI and we do not break it.
> 

I think that's the crux of the issue. Do we want people to update their
kernel but using their existing Device Tree and be able to switch to the
DRM driver ?

My take is that we should and that's why I kept the backward compatibility.

Maybe we could do that in the meantime and at some point introduce new DT
bindings (with a different compatible string) that would use the latest
and greatest conventions in DT ? That seems to be a good compromise.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

