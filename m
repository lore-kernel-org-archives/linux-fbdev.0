Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B068EB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Jul 2023 08:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGCIuz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Jul 2023 04:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjGCIuv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Jul 2023 04:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCA010D4
        for <linux-fbdev@vger.kernel.org>; Mon,  3 Jul 2023 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688374175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=+TImfC7tK2SsSjZEh/HT3vdbJQbag2Dkm/n26z7WMho=;
        b=Nme9C41kSZ57gRoAj4g/SfFueSciOMPiWDxnysOxi6IIFv3ydb1J2J+aGYGQIJAYOYdiFo
        R39vEAy/dJLX73q4zrcnu6pJ/KrXLj8goCOtTuDJ4F4spMa3DmDiuvW7jRneOh5QEDmUbF
        FzDhWK41YuF4/MhD5QT3ouj7FKCNsDg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-CVnV9TlgOKuDzUKbqQpxVQ-1; Mon, 03 Jul 2023 04:49:34 -0400
X-MC-Unique: CVnV9TlgOKuDzUKbqQpxVQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3141e72a2e9so2031600f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Jul 2023 01:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688374173; x=1690966173;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TImfC7tK2SsSjZEh/HT3vdbJQbag2Dkm/n26z7WMho=;
        b=Lvcg/2kt8rh0PNeVZjhFL3grwZzwrU4i6bTCPFF3mto6LX7FAHVRJpLwu0tiBy2IYX
         lqkdWCrXFTE+aTutylqwSmbKUKlXuniicAYZyD00IyJcTINPXuaKey9iampZ9I+Izak/
         BTaWvA9iAEKAEjL0t/Y3DKtcf/jWz42C6RJMFY4OZqTs+buiFCDHOfWb4OatBxkYVRZS
         9kvoFmYOWsDnM4j2Y+RjmCmf5T4icswPWRGWZ8hXZKqY+zpp1Eub1j8iDSwj5JLviL8B
         fGtY/liOI74/hwe95KSpjkmNUnpQYADupJFzHrULz/clWwrTX7F5BT+sH86+A0qAgdDV
         x/hA==
X-Gm-Message-State: ABy/qLbnFiUjAG0yNewobz3mNCu/nqqbeJxkNotjq72BjdI+Zr74sKSV
        8QD+yUA9hVSsZnC4BV8NhKaa6sNMauMUFqvjMUV5QccxQTrwkrQalrEsJlfIFk3Z3Gq8YNGfAKQ
        CYeb1pEziEqMzzN6Nt8ygNfs=
X-Received: by 2002:a5d:5141:0:b0:313:e88d:e6d6 with SMTP id u1-20020a5d5141000000b00313e88de6d6mr8286635wrt.14.1688374173214;
        Mon, 03 Jul 2023 01:49:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGg6K8WUHE8euyn+3LOEa30xbblNJ36iK0ft7TSKaKSogN5/e+nUCA42ROWlI7aSWhx9VYj0A==
X-Received: by 2002:a5d:5141:0:b0:313:e88d:e6d6 with SMTP id u1-20020a5d5141000000b00313e88de6d6mr8286616wrt.14.1688374172926;
        Mon, 03 Jul 2023 01:49:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id da16-20020a056000197000b0031274a184d5sm25157550wrb.109.2023.07.03.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:49:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        dri-devel@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/2] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <04fa72f3-d6ca-bd68-7ed9-57151c1877df@suse.de>
Date:   Mon, 03 Jul 2023 10:49:26 +0200
Message-ID: <87o7ktz8fd.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>>>>    config FB_DEVICE
>>>>    	bool "Provide legacy /dev/fb* device"
>>>> -	depends on FB
>>>> +	select FB_CORE
>>>
>>> This should depend on FB_CORE.
>>>
>> 
>> Yes, already fixed in v3 too. I did a select to prevent symbol circular
>> dependencies but doing that lead to CONFIG_FB_CORE=y even if CONFIG_DRM
>> was set as a module.
>> 
>> But with the "select FB_CORE if DRM_FBDEV_EMULATION" in the DRM symbol as
>> Arnd suggested, I was able to have FB_DEVICE to depend on FB_CORE again.
>
> BTW, where does this item now show up in the menu? It used to be in the 
> framebuffer menu. It's now in the graphics-drivers menu?
>

No, it's still in the framebuffer menu. But after the FB_CORE split the
menuconfig ends broken (no sub-level for fbdev drivers anymore).

I was talking with Arnd and Geert about this. I think that will pause this
series and instead first focus on cleaning up the fbdev Kconfig, then it
should be easier to add the FB_CORE on top of that.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

