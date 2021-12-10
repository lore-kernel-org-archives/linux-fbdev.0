Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4155C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Dec 2021 14:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhLJOUR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Dec 2021 09:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbhLJOUQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Dec 2021 09:20:16 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52E2C061746
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Dec 2021 06:16:41 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so9754663otl.3
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Dec 2021 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOSoarCCbZM7dlcjmgAvZBd2Ge5y+aGOq0kCRiTe4tw=;
        b=lsFSompV1OCJP8n00tqcmPhSB4U7IEQ6pnwkl8mM6i6SPt5ZGXNzqYRzrPCP5ycozH
         Lc3LBns3JreH4ulGaPEkT0EvnFOmNL1PcYb0Qw+uUvtessMSUOo98/sZ/GLwK8Gt54VH
         A1uDTNRyt4uJ9V17abTvznDzwv6cXKkwpOOtBGseHvco62o5nH5qrvscNezxp31rzhLW
         XSI2SOU7HaIxeJs/iVe+prYJRREV0R/BLvqXBg14JIr8UtOAFmNTWCeukrXynVoTExe+
         HWbjByukta9YKjkT+O5Ei/60PnnNLqkikjpNVlrxuUuduCHmGGxBAazDgtSIKxGB9eTR
         oC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOSoarCCbZM7dlcjmgAvZBd2Ge5y+aGOq0kCRiTe4tw=;
        b=s1Ui2CCjpSW9/n6b+Tc9rBZSXXbEdXcS56dlvkxGGBYk2ZE3IwumjIijDBn2EaeeDV
         gQbUPYHKshEDlFzNRy0OPmQM4vyPWpFrtTkpg6PtXtRUYZ5pnPN6h/tr3Ri/ExHiZkfu
         J6VHWm74/LXJXcCh9wFCgs34hAFKS9hdfgLx53eKJz//fBtiSiWYqHU4DVbXTXOI1quE
         KwJRQSF/mnfVa1ZSwXK3DRht4iffm7pDN9t1drRISdiL50wNRW7iKjy66s0ueivaJszc
         e5i1G+7hPXXOwKn5BktIepYDn1xx4lay9bQfPnwrzfC4dYWF9jrbEdsFuRDPvyHevw7J
         kYeA==
X-Gm-Message-State: AOAM532hysefEk9ESlO4l5M6SkLErHvsxJvTRHjvZLsHD4BcFwyAvh2d
        P5CopO5/LCIcB5t5OG8y/6Y9ZUFnhElRLksJYXw=
X-Google-Smtp-Source: ABdhPJzxEixHNY/ukDs1bIqZdHB/bSDP4VRdSeRVaKe8t7pjUL4W1JYcWPxk99li/psv45WFTLJCZZdgC34P0aaSQV4=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id v15mr11608187ota.200.1639145801225;
 Fri, 10 Dec 2021 06:16:41 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com> <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com> <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
In-Reply-To: <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Dec 2021 09:16:30 -0500
Message-ID: <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, pjones@redhat.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Young <dyoung@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Dec 10, 2021 at 9:09 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Thanks a lot Alex / Gerd and Thomas, very informative stuff! I'm glad
> there are projects to collect/save the data and reuse after a kdump,
> this is very useful.
>
> I'll continue my study on the atombios thing of AMD and QXL, maybe at
> least we can make it work in qemu, that'd be great (like a small
> initdriver to reprogram de paravirtual device on kexec boot).

Why not just reload the driver after kexec?

Alex


>
> Cheers,
>
>
> Guilherme
