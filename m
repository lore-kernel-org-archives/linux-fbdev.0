Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B71C001E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jul 2023 08:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjGZIsb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjGZIrU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jul 2023 04:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDF4EDB
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jul 2023 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690360749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAaxUKQ38GDgR2OmXqLR47mRWIe2n/NF7SoPW0emVCM=;
        b=YTpkfUSNMwNue0LhzuiKyz6E8ij2Jdz9nQJxx4ClDB65qsqt+3sKLNCC0onSt25o0podOM
        rRf9o0QaiHKT8LD9x0TZz5PWI+52P+NgX+k760XpSp8amjDyzc9Us6fYC9WFkT74kndv3a
        oCrvi44sdKYvfGePbwBuBEB5PlbtOks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-PsO3UC4eMRuWtF5_tj7lrg-1; Wed, 26 Jul 2023 04:39:08 -0400
X-MC-Unique: PsO3UC4eMRuWtF5_tj7lrg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so34302845e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jul 2023 01:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360747; x=1690965547;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAaxUKQ38GDgR2OmXqLR47mRWIe2n/NF7SoPW0emVCM=;
        b=SPsUdjeaDYJhYis+Sl1Ar3AIYRwcyMVsBHlehJoZ+5AdB4JtT5h7uO24F5r5cboAaH
         BYBRZNrGEVbXQZZBzNl9A3POZBg+FTnX7gcieZqKw5OpvlgwIqV/q1S1E+Uf6lKUVkYK
         BaNRp6lnc0MN5K5wNWsbCkRki9yQnaCHz2lMwfIy8EtwLpNOYqqrfhhhqf5grC37iXOj
         we9rKS+O5WIr2BR/RnV1pp0dIxXZqZ1hbxq/WB3Ud3pTCEeQ7YiWfaBEft+MGAmp0deT
         J6kBQxgehlC6pWeB2sT6Od8FWUKRohTKOUQlKaMkcowYLmi25q94G2jPvmkdxF5NJ+KS
         LnBA==
X-Gm-Message-State: ABy/qLayO9WGdmPgGSXLVOQ7OQbaQ6Dnj7oDO+c0RAZ0BJ0Mdj6bwxCE
        +ZxxajBoIJVWYfif3KjACW3iKov8RrFpoeG5j9J6t/eLwFF7S6VQiOoQXjzgVk/40X2cpCDGMBf
        i+kEk1rZSVP+bOfnhbfu0+GM=
X-Received: by 2002:a7b:c4d9:0:b0:3fd:ee50:d6a4 with SMTP id g25-20020a7bc4d9000000b003fdee50d6a4mr760516wmk.17.1690360747438;
        Wed, 26 Jul 2023 01:39:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEr6DyQHuloA2nD4iog3/3e8RP4qSZv58+bnBAhRP20NVfUdCPAbe6s+RxrRyARWcpPBM/KHg==
X-Received: by 2002:a7b:c4d9:0:b0:3fd:ee50:d6a4 with SMTP id g25-20020a7bc4d9000000b003fdee50d6a4mr760504wmk.17.1690360747093;
        Wed, 26 Jul 2023 01:39:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l25-20020a7bc459000000b003fbaade072dsm1343652wmi.23.2023.07.26.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 01:39:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <20230726083557.GA921641@ravnborg.org>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
 <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
 <877cqoj5q5.fsf@minerva.mail-host-address-is-not-set>
 <c10d925b-8d37-caa0-8f66-a0206f948c69@suse.de>
 <874jlrkbtf.fsf@minerva.mail-host-address-is-not-set>
 <20230726083557.GA921641@ravnborg.org>
Date:   Wed, 26 Jul 2023 10:39:06 +0200
Message-ID: <87y1j3hxsl.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Tue, Jul 25, 2023 at 09:53:16PM +0200, Javier Martinez Canillas wrote:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>> > Hi
>> >
>> 
>> [...]
>> 
>> >> 
>> >> Yes. I meant to move drivers/video/logo/ to drivers/fbdev/core/logo and to
>> >> source its Kconfig from drivers/fbdev/core/Kconfig, since it now depends
>> >> on FB_CORE.
>> >
>> > No, please rather leave it where it is. There's no code dependencies to 
>> > the fbdev core; it merely depends on the Kconfig token.
>> >
>> 
>> Sure, fine by me. But I disagree that there's merely a Kconfig dependency.
>> The include/linux/linux_logo.h header declares both fb_find_logo() and
>> fb_append_extra_logo().
>> 
>> The fb_find_logo() function is defined in drivers/video/logo.c while the
>> fb_append_extra_logo() is in drivers/video/fbdev/core/fbmem.c, even though
>> only arch/powerpc/platforms/cell/spu_base.c uses fb_append_extra_logo().
>> 
>> So there's a relationship already between logo and fbdev/core, that's why
>> I wondered if would make sense to also move drivers/video/logo.c to have
>> both functions in there.
> Or as I also suggested on irc - to pull out all the logo stuff from
> fbmem and put it in video/logo/
> With a bit of refactoring to make it obvious this is logo stuff and
> maybe avoid some of the ifdeffery in the code of the users.
>

Agreed. That option may be better.

> 	Sam
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

