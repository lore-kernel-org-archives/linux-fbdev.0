Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39DCA0ECA
	for <linux-fbdev@archiver.kernel.org>; Tue, 12 Sep 2023 07:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjILHtC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjILHtB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 12 Sep 2023 03:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3A11E7C
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Sep 2023 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694504893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2B0WC8PzLNLdGRasGQ/ag9W7qGL3oBFmynvW1yiJ2zE=;
        b=DR7DB/PTgaV89H09PpN2cmXUy1QTCcibPArTICn4mAg9cssZ3X/a2xxD0ycE8Qnt8EkN9k
        HAbx0BuQoGA5RqPWZ+9qArPBZXCD9Dtda7CChEL/o1yD+Nr3jDdKYbevkSFI26bjGWjZud
        LTFCWl5fZf/ER/tK2NtZ1ANNyP1jMqE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-IZXCQYYaM_avrgFKFVd-cQ-1; Tue, 12 Sep 2023 03:48:12 -0400
X-MC-Unique: IZXCQYYaM_avrgFKFVd-cQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401e1c55ddcso42230665e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Sep 2023 00:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504890; x=1695109690;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B0WC8PzLNLdGRasGQ/ag9W7qGL3oBFmynvW1yiJ2zE=;
        b=Afk/b3zJTdLt7EmwURwRqeisFew9lPzqDVYRGZIwDsJyPUhr4aDrnX+xB+DtZFVtFT
         4ce9nEcR2B99vClPRIpCTkd8UAshH533lQqVk4IaH3l40EuDLCGjYiGS+0b9rjiUZlyw
         dXShqLikOdTigLWd8OF2bQxMfp0QkzeABFs53lgqX9DcSWd0KCzYRIuEDwFJfCo/yRVZ
         cppd2pDAZTAwgMlVrM5w8XdBKaly1Uv+Rn/SxVMM9nvavLP/4Ot2LYczfzSvFoPyrdBH
         NpWLl6Z8ej1YACn46rskWjsE0Qw2TcSOtD1gc1JeHq31iw9cWUwVG3neQt5fbORxa9xx
         91Og==
X-Gm-Message-State: AOJu0YziUqODG1n2aBLJJd5OVy9C87uztSbuc/5Zj24v12ficLxlrBLt
        OoZV4A6NtB1zkrHGsoj4uy5TIMEsc2GUIPrkUiaZHMZl20mppNn4V47GE6UPuoPSZr7A0VKJyoB
        oiXnYKoT7fRE7ze4VUHq0L2Q=
X-Received: by 2002:a1c:7508:0:b0:3fe:1f93:8cf4 with SMTP id o8-20020a1c7508000000b003fe1f938cf4mr9447292wmc.8.1694504890542;
        Tue, 12 Sep 2023 00:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+rSaX2GVdThWkFlifttXlbzNXae8MOoKXkiRAt9ShgN0wMc6R6A+/mp5KLadFPQ6BmDhQJQ==
X-Received: by 2002:a1c:7508:0:b0:3fe:1f93:8cf4 with SMTP id o8-20020a1c7508000000b003fe1f938cf4mr9447271wmc.8.1694504890238;
        Tue, 12 Sep 2023 00:48:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g17-20020a7bc4d1000000b003fc02e8ea68sm15255183wmk.13.2023.09.12.00.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:48:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
In-Reply-To: <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
References: <20230911205338.2385278-1-arnd@kernel.org>
 <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
Date:   Tue, 12 Sep 2023 09:48:09 +0200
Message-ID: <87a5tr3k92.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Arnd,
>
> On Mon, Sep 11, 2023 at 10:53=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> =
wrote:

[...]

>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
>>         bool "Enable legacy fbdev support for your modesetting driver"
>>         depends on DRM
>>         select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
>> -       default y
>> +       default FB
>
> While this is true for existing configs, it is no longer true in general,
> as DRM_FBDEV_EMULATION is no longer related to FB.
>

Maybe default y if (FB_DEVICE || FRAMEBUFFER_CONSOLE) ?

>>         help
>>           Choose this option if you have a need for the legacy fbdev
>>           support. Note that this support also provides the linux console
>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconf=
ig
>> index b575cf54174af..83c2d7329ca58 100644
>> --- a/drivers/video/console/Kconfig
>> +++ b/drivers/video/console/Kconfig
>> @@ -74,6 +74,7 @@ config DUMMY_CONSOLE_ROWS
>>  config FRAMEBUFFER_CONSOLE
>>         bool "Framebuffer Console support"
>>         depends on FB_CORE && !UML
>> +       default DRM_FBDEV_EMULATION
>
> Sounds good to me, although it looks a bit strange at first sight
> (FRAMEBUFFER_CONSOLE defaults to n on a system with real fbdev, but
> y on emulated fbdev?).

And there Maybe default y if (FB || DRM_FBDEV_EMULATION) ?

> So this is the fix for commit a5ae331edb02b ("drm: Drop select
> FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION").
>
>>         select VT_HW_CONSOLE_BINDING
>>         select CRC32
>>         select FONT_SUPPORT
>> diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core=
/Kconfig
>> index 114cb8aa6c8fd..804c2bec9b43c 100644
>> --- a/drivers/video/fbdev/core/Kconfig
>> +++ b/drivers/video/fbdev/core/Kconfig
>> @@ -28,7 +28,7 @@ config FIRMWARE_EDID
>>  config FB_DEVICE
>>         bool "Provide legacy /dev/fb* device"
>>         depends on FB_CORE
>> -       default y
>> +       default FB
>
> Changing this means possibly causing regressions on systems running
> an fbdev userspace.
>

Right, specially if using DRM fbdev emulation since then the default will
be different between v6.5 and v6.6 (that's what this patch tries to avoid).

So probably we could keept that default as 'y'.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

