Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7DBC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 Jan 2022 10:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiAQKCk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 Jan 2022 05:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiAQKCk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 Jan 2022 05:02:40 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE19C06161C
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Jan 2022 02:02:40 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id b15-20020a4a9bcf000000b002dc83a61053so4774609ook.1
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Jan 2022 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqXcDREe5y1sCCawQrq5gS0r+qm6TMEu5IgagEe+Xnk=;
        b=bIv8XIAU0GsSyIwX6nsbk3i/t2O8vvYeunZVSIrKk3F32b5AVoFwIuTETUfRcoNTAv
         +h3oO9tLPGF9tBJjejEdSSTOH6duM90RBVMsihNbbUHfBxb27b2Y2XDhJDh0CYhgt8W2
         BxYG+jkBKpCKCNsoaanja7a4R2cqDV8A5Ci24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqXcDREe5y1sCCawQrq5gS0r+qm6TMEu5IgagEe+Xnk=;
        b=deqi7cnxFtWHoGJwxkqswilJNHgzlvViMfyUVhFXCqQjcaRRxoIGlU2vKYN3HkSmoi
         NhTiaKbBluBnCpUcASi/3daGJSgr8JZCWpBS9VGhdKsN2mxMu4QmgFHMJyk+YHNln06/
         2v6Oq+kqntoWccUAW4sIfvi3LONc/0VhKLm99aM+7kNm/ni+bt62Wny5DS8zz/oUCS2D
         qWQLVjqjJytaOCKwtO1scwRVDlSg3OcmFrKedY8BxtWD1TOchcj6vWrW1tO2k0JxWhUe
         2LPeCUHlsQqQ77fcHcti+o01r7bfkTNOmU9I/KsQC1NIgW/p/dJLBTDNXpzAQD1kC5sY
         WWjQ==
X-Gm-Message-State: AOAM532xRF2EJrdGqy4Qmy0kP/R4qaN8cTFZjFT8kL4KofQfmZ74ioDi
        FC5rWWKZoJQYoBQMk0fiRTKwnifvF48aGlhBwNcNrA==
X-Google-Smtp-Source: ABdhPJwvPKmDxxJJ1qa577C8egiG4E+qjDnMKNDKT3l/zj/o4nz98PNcYsm9tz4V8VBIdw49tjknfpyUQtCv2tyYqwE=
X-Received: by 2002:a4a:db96:: with SMTP id s22mr12394697oou.66.1642413759605;
 Mon, 17 Jan 2022 02:02:39 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530>
In-Reply-To: <YeG8ydoJNWWkGrTb@ls3530>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 Jan 2022 11:02:28 +0100
Message-ID: <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "airlied@gmail.com" <airlied@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge

On Fri, Jan 14, 2022 at 7:18 PM Helge Deller <deller@gmx.de> wrote:
>
> The fbdev layer is orphaned, but seems to need some care.
> So I'd like to step up as new maintainer.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d0cd537803a..ce47dbc467cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7583,11 +7583,12 @@ W:      http://floatingpoint.sourceforge.net/emulator/index.html
>  F:     arch/x86/math-emu/
>
>  FRAMEBUFFER LAYER
> -L:     dri-devel@lists.freedesktop.org
> +M:     Helge Deller <deller@gmx.de>
>  L:     linux-fbdev@vger.kernel.org
> -S:     Orphan

Maybe don't rush maintainer changes in over the w/e without even bothering
to get any input from the people who've been maintaining it before.

Because the status isn't entirely correct, fbdev core code and fbcon and
all that has been maintained, but in bugfixes only mode. And there's very
solid&important reasons to keep merging these patches through a drm tree,
because that's where all the driver development happens, and hence also
all the testing (e.g. the drm test suite has some fbdev tests - the only
automated ones that exist to my knowledge - and we run them in CI). So
moving that into an obscure new tree which isn't even in linux-next yet is
no good at all.

Now fbdev driver bugfixes is indeed practically orphaned and I very much
welcome anyone stepping up for that, but the simplest approach there would
be to just get drm-misc commit rights and push the oddball bugfix in there
directly. But also if you want to do your own pull requests to Linus for
that I don't care and there's really no interference I think, so
whatever floats.

But any code that is relevant for drm drivers really needs to go in through
drm trees, nothing else makes much sense.

I guess you're first action as newly minted fbdev maintainer is going to be to
clean up the confusion you just created.

Cheers, Daniel


> +L:     dri-devel@lists.freedesktop.org
> +S:     Maintained
>  Q:     http://patchwork.kernel.org/project/linux-fbdev/list/
> -T:     git git://anongit.freedesktop.org/drm/drm-misc
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
>  F:     Documentation/fb/
>  F:     drivers/video/
>  F:     include/linux/fb.h



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
