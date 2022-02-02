Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB10C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 11:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbiBBLLB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiBBLLB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Feb 2022 06:11:01 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C8C06173B
        for <linux-fbdev@vger.kernel.org>; Wed,  2 Feb 2022 03:11:01 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v186so59959064ybg.1
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 03:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5o2JVyWPjvF0CuBYdtH6rf3OCwSu8v5z/m2E3EDxEVQ=;
        b=6JC4qWqQoyur6n49lXlwJ8argU2sfdQwrI+5UZ/cAgJfz/Wny6UxNwpfY4nKvjDOf4
         bC8yqlshTJqy2m9fSfRZx1mHvZHvU9NCnbTm2Hz8QKFGXNmTLuF2q/PQPQcJnF2rdPfI
         7EQ8tQsgBfjmBUJ7GKHlLlmXRyoppvNp37bOKrZ4l/v573+8dKE7AtQOjDIqDzNUrl5O
         M5dmxC6WklOEBh19YK8riY5u60LO+BbHsdTedAZO8mKbSRT+bkvd5WqWMzTGa0MP8bsy
         i2QRtLbgjqRDiIiagTRyBHl/amtF7ScuFdW7LxgXu1qUFnOZTEOkenxrGPpIREqp5/KT
         gUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5o2JVyWPjvF0CuBYdtH6rf3OCwSu8v5z/m2E3EDxEVQ=;
        b=J0cHQHdGs8r7cfE91fv6KV4HPfuQ98QKenyYIlXc6324YgF1G1dMW9i49NGxmAMnuS
         kzSEOOHVOlbRUFOy8mJ4QoV2NecSye9oXYswPX0TfoAVNAgYxKR5/TJ0Y41nM0Ul65Lk
         6fNoJoJeSAwnjQMLNgC6XTKC4l8y/ZCuta2qle70rmT4fen+6oDmsZ2eZq2GnMf7IrLR
         /CMXV6K65ELZTBFjfebDLbDv1JmdReLNnnXzqg2T9RcnhKUZCiwIFEihUYHtLznolioO
         LsFDxRrXsxduAMtUh5sU1Fs68KnuBG7ffSPL0h087iJco6jEZUPjC2fxvanHi2dpFYOy
         HGxw==
X-Gm-Message-State: AOAM533Crhxu6IESkA8fxmxaCCnq0Q+EYXH7nnPXgX80DvF8RogCMl+N
        A4cOdmicTbJK1ZPOOW+m9bBKbL2oUbhfgOzgaSAUoQ==
X-Google-Smtp-Source: ABdhPJxXYTqOt/oSe5PrM2Wrpx8vatAUxY/eNAT3jcriiGBCZwZLVaTevoVERbyDMHiO0clxqoChrMTzgZvvtsyVmcE=
X-Received: by 2002:a25:a206:: with SMTP id b6mr20061500ybi.707.1643800260369;
 Wed, 02 Feb 2022 03:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch> <20220131210552.482606-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 2 Feb 2022 11:10:49 +0000
Message-ID: <CAPj87rMhkdtoUHTB4y4HLR8KM2tPkQCufFcHbvA0_xHycCHmhg@mail.gmail.com>
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 31 Jan 2022 at 21:06, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
>
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
>
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
>
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.

Acked-by: Daniel Stone <daniels@collabora.com>
