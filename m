Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39EFEB64D7
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Jun 2023 12:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjF3MXC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjF3MW7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 30 Jun 2023 08:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FED1FFA
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688127728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjBHzznZRAO5b+oTZ+HRqFaAiumM5bRIl1sq2uXKgNA=;
        b=Dh40Fi9UKlKArt0q5p4e4nZt1aqJ1VHbNh6BOgfX6jTh/LkM+AS9x8T7+gCvpvpQ/90jvK
        lqnn8qrVzdDarn56bFIIlAqFaKs3nt3f4ocOxnz8Ckh92+inkQAZkrwStOAq9z0UQz5Elj
        VlMh/veFfu5yJt+1a6mweWbfWYJ36Bs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-ZANjDWQpM_eW4raf8Kb_ng-1; Fri, 30 Jun 2023 08:22:07 -0400
X-MC-Unique: ZANjDWQpM_eW4raf8Kb_ng-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f84a8b00e3so2074198e87.0
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 05:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688127726; x=1690719726;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjBHzznZRAO5b+oTZ+HRqFaAiumM5bRIl1sq2uXKgNA=;
        b=k7kZWnBOHNMXYSCnFRFQ0O9v2UoLgp0WVtYOZzAqESuUjwr8FFp7Zmif9uf8WtMbQ6
         0J9QwoYaZ419nVeTNiXWkwMl03k8IDe4nHf5MsO0ig/yjpqSF7U16u0IfALjT4XFg8Jz
         i0uzhy22zJ1M5uCEzi0+4kWCnUv21sxlw0HuN7erZl2dr29QPI1l/wZuBMyVsYWTuV3e
         +HkyUH5xWDEQ7Df8Fp1t8JpgYnP82a1EHfV5Rs0FbV26MAef7oIwuVnASXaJbL1Zprj+
         yc1oPc6mrn7T+TRaYhbu/ULx+33I/XYsWtEV4+YZB5XgAK5aEY857yUAx8se1QX0vkT7
         Hpag==
X-Gm-Message-State: ABy/qLbdVhPv2bmPfIWRuM5/lIMQ+r/ShGRPnBeBxnBP230CHMHdBB1l
        PB7ybIxYFspX1Q3Rr5why+4G+lLB+5D8CiM657ozSxrjadeJOgDsSZAImkKtXdp+h+XXBHkQPvW
        Atd7Pf6LAC/J8sTyKyItop/E=
X-Received: by 2002:a05:6512:3b9c:b0:4f9:5c04:af07 with SMTP id g28-20020a0565123b9c00b004f95c04af07mr2686239lfv.26.1688127725927;
        Fri, 30 Jun 2023 05:22:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3XoUQ9KpkX8QPf4PFTTLP+ewfN6G9JWZef+8cWWP/TixtMSBIlwlTByP+dlOaRwnayEZVCA==
X-Received: by 2002:a05:6512:3b9c:b0:4f9:5c04:af07 with SMTP id g28-20020a0565123b9c00b004f95c04af07mr2686214lfv.26.1688127725530;
        Fri, 30 Jun 2023 05:22:05 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003fba94c9e18sm9022049wmj.4.2023.06.30.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:22:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] fbdev: Split frame buffer support in FB and FB_CORE
 symbols
In-Reply-To: <ea049651-32c5-42d7-96a0-fc236680a714@app.fastmail.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <20230629225113.297512-2-javierm@redhat.com>
 <723a3c51-7997-46d0-9262-68f33384a9e7@app.fastmail.com>
 <87h6qpdy04.fsf@minerva.mail-host-address-is-not-set>
 <ea049651-32c5-42d7-96a0-fc236680a714@app.fastmail.com>
Date:   Fri, 30 Jun 2023 14:22:04 +0200
Message-ID: <87edltdtsj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Fri, Jun 30, 2023, at 12:51, Javier Martinez Canillas wrote:
>> "Arnd Bergmann" <arnd@arndb.de> writes:
>>
>>>> @@ -59,7 +71,7 @@ config FIRMWARE_EDID
>>>> 
>>>>  config FB_DEVICE
>>>>  	bool "Provide legacy /dev/fb* device"
>>>> -	depends on FB
>>>> +	depends on FB_CORE
>>>>  	default y
>>>>  	help
>>>>  	  Say Y here if you want the legacy /dev/fb* device file and
>>>
>>> I don't see this symbol in linux-next yet, what tree are you using
>>> as a base?
>>>
>>
>> It's now in the drm-misc/drm-misc-next branch [1]. It's not in -next yet
>> because it just landed a few days ago [2].
>>
>> [1]: https://cgit.freedesktop.org/drm/drm-misc/log/?h=drm-misc-next
>> [2]: https://cgit.freedesktop.org/drm/drm-misc/commit/?id=701d2054fa3
>>
>> In fact, that's the reason why I rebased my previous attempt [0].
>
> Ok.
>
> I wonder if it would make sense to also make FB_DEVICE depend on FB
> instead of FB_CORE then. I don't think there is any actual dependency

No, because that wouldn't allow to have /dev/fb* devices when using the
DRM fbdev emulation layer. It could be the case that users have an old
fbdev user-space but the platform only has a DRM driver, in that case we
want to disable all native fbdev drivers (CONFIG_FB not set) but still
have FB_CORE, FB_DEVICE and DRM_FBDEV_EMULATION options enabled.

> between the two, but as I understand we want modern distros to use
> neither FB nor FB_DEVICE, so tying them together with a dependency
> may be desirable anyway.
>

As said, modern distros would want to disable both FB and FB_DEVICE, but
we want to allow for these two options to be {en,dis}abled independently.

>
>>>>  config FB_BACKLIGHT
>>>>  	tristate
>>>> -	depends on FB
>>>> +	depends on FB_CORE
>>>>  	select BACKLIGHT_CLASS_DEVICE
>>>
>>> Separating this one from FB_CORE would help avoid circular dependencies,
>>> this one keeps causing issues.
>>>
>>
>> You mean separating from FB or should I keep the existing depends on FB?
>>
>> It seems this is only used by fbdev drivers so probably the latter?
>
> Right, I meant keeping the dependency on FB. Ideally we'd
> turn this all into a set of 'depends on' instead of 'select',
> but that is a completely separate topic.
>

Ok.

>     Arnd
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

