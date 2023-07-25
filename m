Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC59C00528
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jul 2023 16:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGYQwE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jul 2023 12:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGYQwE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jul 2023 12:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F982D68
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jul 2023 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690303817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReBcQaJh4ciBZ53LwBH/iMnMAzVIg5ii3SO9ToZLyw4=;
        b=SRL9N3XS8gStdAxKa1gAj71YZOikMQobP1hTCrhH3EwGkSCBRTDoqHUJuHRxjSAFk60ypO
        NL9aeW4YJZLq7k4gy95rK2U9wdGDFXZnUq2/iZ5wrLHxfOIlkTPqMm1dM7QoXSQ8PrEhBB
        IEgOI2k6rkfN4ddLPIWenH4fi91QY+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-clXRyAY0NcG7zkN8Nk9oxw-1; Tue, 25 Jul 2023 12:50:13 -0400
X-MC-Unique: clXRyAY0NcG7zkN8Nk9oxw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so28403575e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jul 2023 09:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303812; x=1690908612;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReBcQaJh4ciBZ53LwBH/iMnMAzVIg5ii3SO9ToZLyw4=;
        b=N5KBvgthTtsTow3AengGPm+GVnwGK83RKRPSYwipChC8LaVRxcTaNGr1r82sp7ELaO
         vPZkRjaxPbc8+L7EyuMGESR9nnAMP7v+MFHV7GZDP7wb6+6DBFjfQ8BfKk+kvY4lxG7f
         cUkAtgPqi8Q0N+W2fJUB/AVvg3eVduCM2+pjdVbIS4nhhwSF1ZlUShKCqBJ/o9XHNgxd
         C1uQNj7qKTcRGMDNwkxNJJchAGyR9Mf1OQE7Pajj5z3ieoXeveIg1rik262PP+d71IzS
         7kI58x5AYOiY/Ip3+p/qAqILRRxRiUQiWNyqa8w2P1v5ttuKtscLiXKhGeFYRuE4jycq
         emEg==
X-Gm-Message-State: ABy/qLaC55x2nyXjfiMPZUrp43nRnx1jSiyzalyUc/cwAqg+XIOFLdUd
        KF+iNbeEsNhojkmxrYhobb+IEstQAX6brAsDEZXDEXDdkpNrSNiiXR3pusE7Dms0qFHEYMPzUNe
        7fETcXOfFe9iucT0lT07ckB8=
X-Received: by 2002:a1c:750f:0:b0:3fb:e4ce:cc65 with SMTP id o15-20020a1c750f000000b003fbe4cecc65mr8474615wmc.25.1690303812289;
        Tue, 25 Jul 2023 09:50:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHN82DdekK0zitC8eYAyRNRTQ+aka1Hte/M4lbyqh0MgYS8XBWVNfmNZPV6nkNQ6F6sXzyn3A==
X-Received: by 2002:a1c:750f:0:b0:3fb:e4ce:cc65 with SMTP id o15-20020a1c750f000000b003fbe4cecc65mr8474601wmc.25.1690303811924;
        Tue, 25 Jul 2023 09:50:11 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc851000000b003fc00212c1esm13464147wml.28.2023.07.25.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:50:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
 <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
Date:   Tue, 25 Jul 2023 18:50:10 +0200
Message-ID: <877cqoj5q5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Tue, Jul 25, 2023 at 6:07=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert+renesas@glider.be> writes:
>> > If CONFIG_FB_CORE=3Dy but CONFIG_FB=3Dn, the frame buffer bootup logos=
 can
>> > no longer be enabled.  Fix this by making CONFIG_LOGO depend on
>> > CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
>> > logo code to depend on the presence of real frame buffer device driver=
s.
>>
>> Indeed.
>>
>> > Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and =
FB_CORE symbols")
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > ---
>> >  drivers/video/Kconfig      | 2 +-
>> >  drivers/video/logo/Kconfig | 2 +-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> > index e5b1cc54cafa10d5..b694d7669d3200b1 100644
>> > --- a/drivers/video/Kconfig
>> > +++ b/drivers/video/Kconfig
>> > @@ -63,7 +63,7 @@ if VT
>> >       source "drivers/video/console/Kconfig"
>> >  endif
>> >
>> > -if FB || SGI_NEWPORT_CONSOLE
>> > +if FB_CORE || SGI_NEWPORT_CONSOLE
>> >       source "drivers/video/logo/Kconfig"
>> >
>> >  endif
>> > diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
>> > index 6d6f8c08792dc897..b7d94d1dd1585a84 100644
>> > --- a/drivers/video/logo/Kconfig
>> > +++ b/drivers/video/logo/Kconfig
>> > @@ -5,7 +5,7 @@
>> >
>> >  menuconfig LOGO
>> >       bool "Bootup logo"
>> > -     depends on FB || SGI_NEWPORT_CONSOLE
>> > +     depends on FB_CORE || SGI_NEWPORT_CONSOLE
>> >       help
>> >         Enable and select frame buffer bootup logos.
>>
>> Should then move this option to drivers/video/fbdev/core/Kconfig ?
>
> No, all logo options are in their own file.
>

Yes. I meant to move drivers/video/logo/ to drivers/fbdev/core/logo and to
source its Kconfig from drivers/fbdev/core/Kconfig, since it now depends
on FB_CORE.

But I see now that it also depends on SGI_NEWPORT_CONSOLE, so having those
in drivers/video/logo makes sense indeed.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

