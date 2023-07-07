Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CCBEB64D9
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGGNR4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGGNRx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 09:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF20113
        for <linux-fbdev@vger.kernel.org>; Fri,  7 Jul 2023 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9JvrGxpvmS801EGByUJbO9yImJLqiJJEkFic7ujcF2c=;
        b=be484T3sMWmB23fqs1789oc2iLa/9zcv7dO13MYSgeKWieXEQ0o6CcchPDGbIPKgS5JIk0
        hp4lIl9TbWGPJGrTitEVjO2jghy2DFTu/bVdIpMGcvkGuH/bb+OjOUgqRbv9jfRmNHkv6u
        w7jHoVmkLkugBys7C0Hjz7vuhbP7ScE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-uiGeRjkFPpqxOd1gsmBwig-1; Fri, 07 Jul 2023 09:17:03 -0400
X-MC-Unique: uiGeRjkFPpqxOd1gsmBwig-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so11195175e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Jul 2023 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735822; x=1691327822;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JvrGxpvmS801EGByUJbO9yImJLqiJJEkFic7ujcF2c=;
        b=bUGStTUCte/2wMVQsBK2C7YLqT116tlihRdGhQufwo1wyIqzZ8Gv1mQ0t72dWwOshB
         PvasOUW6nsCHj+JTMT3g86M4QzdlmWLYnIf7jpjIFi2MHxmzy1O6htrXS7gCtQH+HBrt
         Ho8wKKIsX+Ru7FAhq98PsN3WZYBQCR6QzTKsjMGBLe5e/bpzbbtG8QxFDHARmYcSSfBT
         wH+6nbDMuPLFIFcL63khUq+a2CYwF0eVve8lZeohXsuF4U5Don1AQPzGHcokRpqcka1T
         /jnXFLFfFCU6YjExIBzpz7+vhKmFEPvTjxa0g+/dM9Z5I/nxfDbJzEen53c8AAVApj8e
         b/Yg==
X-Gm-Message-State: ABy/qLa/lBPOyOc+J0WnxYGSkkOtZZmuAz+QD33PDAqAUZ19+exllcLa
        rk1OOmivS53WrnmcT8qnTBrQmajAAvCwmxQIgz3Bmw13EmKBb58PvPLo7Gk+ZTFjxm/0k+vErcB
        wyka7m2wGejI5pNyMsZsE72A=
X-Received: by 2002:a7b:c408:0:b0:3fb:d1db:545a with SMTP id k8-20020a7bc408000000b003fbd1db545amr3779655wmi.15.1688735822574;
        Fri, 07 Jul 2023 06:17:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWyEpITRdc6V/WDH+p8W9PEEzo9YNPXNRcelMOGQxrDOPXrD+EG7aq4IUiQzrsbuo+XZhh+g==
X-Received: by 2002:a7b:c408:0:b0:3fb:d1db:545a with SMTP id k8-20020a7bc408000000b003fbd1db545amr3779635wmi.15.1688735822235;
        Fri, 07 Jul 2023 06:17:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a7bc3cd000000b003fbaade072dsm2474749wmj.23.2023.07.07.06.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:17:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 1/4] vgacon: rework Kconfig dependencies
In-Reply-To: <20230707095415.1449376-1-arnd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
Date:   Fri, 07 Jul 2023 15:17:01 +0200
Message-ID: <87mt07yi7m.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

Hello Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
>
> The list of dependencies here is phrased as an opt-out, but this is missing
> a lot of architectures that don't actually support VGA consoles, and some
> of the entries are stale:
>
>  - powerpc used to support VGA consoles in the old arch/ppc codebase, but
>    the merged arch/powerpc never did
>
>  - arm lists footbridge, integrator and netwinder, but netwinder is actually
>    part of footbridge, and integrator does not appear to have an actual
>    VGA hardware, or list it in its ATAG or DT.
>
>  - mips has a few platforms (jazz, sibyte, and sni) that initialize
>    screen_info, on everything else the console is selected but cannot
>    actually work.
>
>  - csky, hexgagon, loongarch, nios2, riscv and xtensa are not listed
>    in the opt-out table and declare a screen_info to allow building
>    vga_con, but this cannot work because the console is never selected.
>
> Replace this with an opt-in table that lists only the platforms that
> remain. This is effectively x86, plus a couple of historic workstation
> and server machines that reused parts of the x86 system architecture.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Both our explanation and changes look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

