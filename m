Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820F2C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Feb 2022 08:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiBDIhb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Feb 2022 03:37:31 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:40634 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiBDIha (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 4 Feb 2022 03:37:30 -0500
Received: by mail-ua1-f42.google.com with SMTP id w21so9625645uan.7
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 00:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vew3Q/Ah/4OT+X0N/2HgswSOS5AWlJRbsuKjUyZGy9c=;
        b=aUSB0VKm+wQK+4XUCzyIEhf+v4ZCi2SPKsLjPcSaOSZcD25Gi7faDH444itmvovnQn
         JuI7S1fxR7hR8g1uoZ+y7hZCjIVWHI8iRn0UkrqbVHyf5ZYZhBD1t2XWmTC1uewApPT+
         yyjLQ7UtxIR5b8JdHIc4bD2Zdlhm+kpfyarGMzq45PAU8mFF8OBfATSUW4ODmCqhDr+8
         EGWV/MtlvUoQ40SPy0lWmYrdy/SFyVe5qXwnLbQcCSR73OIqXFABiMTEhTPzPCr+fDgG
         0pGCEduSAbnxgp7IZQB65mjsMqZEjOzV2Ck4Q07BPh9+Z+y4ZcWL3CgBvtzFrGD2cBdN
         Rx7Q==
X-Gm-Message-State: AOAM5308S3S5b0mDetc9klg96CEODORf0LKHc1/nAFyD8ebn+zXGOWZI
        RSbVbUT1z/tCVWS/N+dX0KOLTIh6ZNJcAg==
X-Google-Smtp-Source: ABdhPJw/Yn81zkDBXonJJQCii4tdEstJ7nVHUO/5Yt7gAVTK2C4iufhem/2M4/C/v4tPIK2GZMcdHA==
X-Received: by 2002:a67:c40d:: with SMTP id c13mr459255vsk.4.1643963849425;
        Fri, 04 Feb 2022 00:37:29 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id d25sm318226vkl.53.2022.02.04.00.37.29
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 00:37:29 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a24so9596007uat.10
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 00:37:29 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr463972vse.38.1643963848955;
 Fri, 04 Feb 2022 00:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20220202135531.92183-1-deller@gmx.de> <20220202135531.92183-4-deller@gmx.de>
In-Reply-To: <20220202135531.92183-4-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Feb 2022 09:37:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTuFt12faj58sLv3H9rN0xK-+CCTkFeEiKdLSQTU2Lmg@mail.gmail.com>
Message-ID: <CAMuHMdWTuFt12faj58sLv3H9rN0xK-+CCTkFeEiKdLSQTU2Lmg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fbcon: Add option to enable legacy hardware acceleration
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

Thanks for your patch!

On Wed, Feb 2, 2022 at 8:05 PM Helge Deller <deller@gmx.de> wrote:
> Add a config option CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION to
> enable bitblt and fillrect hardware acceleration in the framebuffer
> console. If disabled, such acceleration will not be used, even if it is
> supported by the graphics hardware driver.

Note that this also applies to vertical panning and wrapping.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
