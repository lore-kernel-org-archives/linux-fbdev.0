Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136FCEB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Jul 2023 07:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGCHri (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Jul 2023 03:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGCHrh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Jul 2023 03:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA1CC4
        for <linux-fbdev@vger.kernel.org>; Mon,  3 Jul 2023 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688370409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNgNGFs6FpSFYvjUbX6e2xS8On7P23RQ79WPke3buhU=;
        b=ZXbOxYSoe0iNriVFuapktpHaSF9UEpQIyIPRdjgnsE2ZDfjUDb6+HMoqBvToit0FbaU6LU
        gGqCgG6TwiaZ0Ehm1smCmaZV0sOQVJlFyuQHxQtrc2JLFmCKJxDIxRwoTWFK9IdVfJvykc
        581Bv207wnUq6sVG6f0aXZlM+08D4FU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-3sirbKnDNcCrcS2ptl6fHw-1; Mon, 03 Jul 2023 03:46:48 -0400
X-MC-Unique: 3sirbKnDNcCrcS2ptl6fHw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fb40ec952bso25986485e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Jul 2023 00:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370407; x=1690962407;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNgNGFs6FpSFYvjUbX6e2xS8On7P23RQ79WPke3buhU=;
        b=b+yGe/akr3lzg6N1g+WPDVML4K+jKEq62OnfypXsWzkMtz69HKuWkX/puRWTcjb6kT
         4iNCwPwW6yvXjLbPo1TJ5LC97WXyOSvpQWWyLwZOPDY0Nn0KujyJtR2SfJvQI+NVpPgw
         IcNBb8T9Tjy3WwMV8Ermu7uddKLgHW63EBeE9ND/7ZMmZzwJkHplG700wrqLN9rPTiA1
         ogk0lxJ1yxSXT0xxg3T29CLXffKnI7z9kAJeRJ0cb3jg5bz8M4/ibeQSZnTaM3AvnC1/
         SqX4azhyE4Nb7rYQIXGh1TTFwsxL4wmr2qeGsmPOCqhZLbB2WfOeALxdVVE58d5SupR3
         YzwA==
X-Gm-Message-State: AC+VfDwLZFuKqvuCA2RqcxdLBvMTbl+gpN3rBT+e0lJbIP37jPqCaxCz
        ENKy3m2P6CVyU5rgDXE0yEOV4ql19jxu8CVVQd/DHAzj2MrZiw9ceXENthiJEZr00QjnC88Cl1d
        xR4W6wIdfqts1Qx3KvTFHXiQ=
X-Received: by 2002:a1c:7918:0:b0:3fa:abd8:fcc4 with SMTP id l24-20020a1c7918000000b003faabd8fcc4mr8817028wme.35.1688370407013;
        Mon, 03 Jul 2023 00:46:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZHf5JE/CnYHILDYfyhHHHkhMi2GF7fF1uBCkCYh2SoENZccptRl4sK5yd0X6dACwuqT4ylQ==
X-Received: by 2002:a1c:7918:0:b0:3fa:abd8:fcc4 with SMTP id l24-20020a1c7918000000b003faabd8fcc4mr8817014wme.35.1688370406654;
        Mon, 03 Jul 2023 00:46:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003fbc30825fbsm9505588wml.39.2023.07.03.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 00:46:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-fbdev@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/2] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <e83eab26-a8fe-b151-6bd4-7a7db6ceee1f@suse.de>
References: <20230701214503.550549-1-javierm@redhat.com>
 <20230701214503.550549-2-javierm@redhat.com>
 <e83eab26-a8fe-b151-6bd4-7a7db6ceee1f@suse.de>
Date:   Mon, 03 Jul 2023 09:46:40 +0200
Message-ID: <873525e8tb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Thanks for your review.

> Hi
>
> Am 01.07.23 um 23:44 schrieb Javier Martinez Canillas:

[...]

>>   
>> +menuconfig FB_CORE
>> +	tristate "Core support for frame buffer devices"
>
> With the text, this is visible; as others noted.
>

Yes, I misremembered what made a Kconfig symbol non-visible, and thought
that was just the lack of a help section but forgot to remove the prompt.

This is already fixed in v3.

>> +
>>   menuconfig FB
>> -	tristate "Support for frame buffer devices"
>> +	tristate "Support for frame buffer device drivers"
>
> Just keep the text as-is.
>

I disagree. Because we are slightly changing the Kconfig symbol semantics
here, for instance CONFIG_FB_CORE + CONFIG_DRM_FBDEV_EMULATION will also
provide a frame buffer device (and with CONFIG_FB_DEVICE, will be exposed
to user-space as a /dev/fb? device).

So now CONFIG_FB is really about allowing the native fbdev drivers to be
enabled. That's why I'm changing the prompt text to make that more clear.

[...]

>>   config FB_DEVICE
>>   	bool "Provide legacy /dev/fb* device"
>> -	depends on FB
>> +	select FB_CORE
>
> This should depend on FB_CORE.
>

Yes, already fixed in v3 too. I did a select to prevent symbol circular
dependencies but doing that lead to CONFIG_FB_CORE=y even if CONFIG_DRM
was set as a module.

But with the "select FB_CORE if DRM_FBDEV_EMULATION" in the DRM symbol as
Arnd suggested, I was able to have FB_DEVICE to depend on FB_CORE again.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

