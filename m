Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD1CC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 Jan 2022 09:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiAUJyC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 Jan 2022 04:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiAUJyC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 Jan 2022 04:54:02 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910BC06173F
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jan 2022 01:54:02 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so11101245oto.4
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jan 2022 01:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DBIqMCyoYKwtluhZLWFJ5ts4b1jZKqmXZEC6sptQraM=;
        b=SYqFCpZEA/SN54ldAC401emwbTE/qusES8QA6f3e2UqL1LzZ0oYRi1NCy/feVkq/gN
         6GadX9sXbRqUNqwbxfR093EnyMMRdf605YLyB4f8+BjsTFEOkDduV0XNRUD0KkTApTOb
         5nJ2q3uS2EegutSMiHxxyQ8/vs2r/WaMRFElQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DBIqMCyoYKwtluhZLWFJ5ts4b1jZKqmXZEC6sptQraM=;
        b=Mml60TIgaFguLAr79TwRy6nDaLMisE7zZZX+J5soMFrAGx9a7zQQUxj9EUNab714UE
         fakKVpfWPEsYlyK1oTLr7Wsi5PkhDoGso/40kqZB1O+mrW3iD3cbJ3KY+4tdVyZC1UN3
         ZdAB9g9yvsa05jMHhQmWrb9tK2TJxrfunI2Gw0Iknp/CIU7DcwWQL3kBZ8f/JaX+WojQ
         tK7KcxN3CPw9m5CrDcrQbZmgEaz8RLo9wzjva/boqFDue7C0MjbfpZShzCPdZEwuDt15
         IgrNqva2j1xhA/cFQjCe87enVFONzITpx4lzvwbS+nVigP961ycnPTFwfFq9G0iya7nK
         /SXg==
X-Gm-Message-State: AOAM530JBbtTakx7bAp2dLMHPNpItqJPji/GvI+55QRTck/D4SUssSEj
        pqH5HUwu5qftYVrJbqVOq+zLCYcMrUKicb8AtaaZrQ==
X-Google-Smtp-Source: ABdhPJx0crwT3jJOrS0+wVulq7ZmDGhsyd9nIrBXcQE6LrIe8Q+G/CTmt2aPnAXNaQ+yZj4mlLrcRo6GWluuwPA13wc=
X-Received: by 2002:a9d:685a:: with SMTP id c26mr2158585oto.239.1642758841495;
 Fri, 21 Jan 2022 01:54:01 -0800 (PST)
MIME-Version: 1.0
References: <Yeg11pHSqx29yg/T@ls3530> <CAKMK7uGeGBBvTGFyBxLwvTAxEWwXMS8U1rrYUb_7gbui-jV+KA@mail.gmail.com>
 <87fsph4fr2.fsf@intel.com> <Yep6te0wrK0ZQ8SB@google.com>
In-Reply-To: <Yep6te0wrK0ZQ8SB@google.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 21 Jan 2022 10:53:49 +0100
Message-ID: <CAKMK7uG9FaBM6e_kXFZUgBCk4JFcPCbzG5D_9XcypwVeXqDq6A@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.17-rc1
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 21, 2022 at 10:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 21 Jan 2022, Jani Nikula wrote:
>
> > On Fri, 21 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Wed, Jan 19, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
> > >> A first bunch of updates and fixes for the following fbdev & backlig=
ht drivers:
> > >> ocfb, aty128fb, mb862xx, omapfb, qcom-wled, dt-bindings, hyperv_fb,
> > >> lm3630a_bl, omap2, controlfb, matroxfb
> > >>
> > >> Nothing really important, mostly cleanups, const conversions, added =
null
> > >> pointer/boundary checks and build fixes.
> > >>
> > >> Signed-off-by: Helge Deller <deller@gmx.de>
> > >
> > > Not sure whether Linus missed this or just wanted to let the
> > > discussion settle first. But since this is all random patches for
> > > drivers that many distros don't even enable anymore there's no issues
> > > here, and I very much welcome someone volunteering to pick these up.
> > > I'd expect there's a pile more since it's been 1-2 years since Bart
> > > took care of these and merged them consistently.
> > >
> > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > ...
> >
> > >>  drivers/video/backlight/lm3630a_bl.c                     |  1 -
> > >>  drivers/video/backlight/qcom-wled.c                      |  1 +
> >
> > Backlight changes usually go through the backlight tree.
>
> Yes, they do.  How were these applied to the DRM tree?

They are not applied to any drm trees, Helge jumped in last week to
take over drivers/video maintainership.
-Daniel

>
> I don't see any mails about them being applied:
>
>   Luca Weiss (2):
>         backlight: qcom-wled: Add PM6150L compatible
>
>   https://lore.kernel.org/all/20211229170358.2457006-2-luca.weiss@fairpho=
ne.com/
>
>   Xu Wang (2):
>         backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls
>
>   https://lore.kernel.org/all/20220113084806.13822-1-vulab@iscas.ac.cn/
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
