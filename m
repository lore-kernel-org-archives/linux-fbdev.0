Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335C5C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 17:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiBARGq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiBARGq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Feb 2022 12:06:46 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D4C06173B
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Feb 2022 09:06:45 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id b186so28373889oif.1
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdQTcqQ9Qr4h0L2NlLlM99qGIKmmmXyVpgAfVQlyXvw=;
        b=aBXJGsBy39GcwPGw1gQwRkkKV6thDHpcyarDrmkoubQM6M8m7KheFYLmVcR/iba2MT
         ++t5VYXBHifuxfZgt0rPdm2eEQIi4to/6t4QII6YDcjxIphQkcY9ydqlzF1HGNKaSs9V
         IvfM1MNQmBgOqUNJRefzdJIahGbbWzxTo2tEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdQTcqQ9Qr4h0L2NlLlM99qGIKmmmXyVpgAfVQlyXvw=;
        b=NHKGSF15pPZIUcAdrIPIVWYo2n9B3+Miox5V7/zVwkQZhomWvx064vNhaqteVpJ1a8
         3zduk0QYL9QevwR28KenK1qiStut3yIvW3sEWr44sNAeyRHZwW0LEmGTiRsoS//VAFiI
         /xnNmkBKMwyl4ppvWzctKeRYuskU617Jv2GqBTNIQfzDWDjcy9yMbadw21PZtpg1LFnv
         5qZNeR/J0xy+/CFzCYf2bXZuTpxNkKTRzBk0vbHa+fb8SqWAv/6OGEHpGACvOOxfdnDS
         zuD7+2f8oUyNRWpuIzeJfrYOgWm0o4cspKVMl4n+zbKp+9eWEcWcQOm5uQWm8H/qhTSU
         lyDQ==
X-Gm-Message-State: AOAM533GohiI0Crzoft1ApAkNkFKr9yWpr4u0yCUkobYyyl5x3E7DjsR
        acwERld9jBjy+uhwE26cvjXR1ut2DtxO8/7BZXHfdg==
X-Google-Smtp-Source: ABdhPJxmJTT10BhmESxaD9wSsaXi2TyqjKpx8TF/TQp9so++NA/uk65aK3wvzaI2XbQCX3/1SL7QYNE/AkpMguwVMkA=
X-Received: by 2002:a05:6808:1641:: with SMTP id az1mr1928959oib.278.1643735204982;
 Tue, 01 Feb 2022 09:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com> <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com> <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com> <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com> <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <ddb0f354-be19-92fe-20b3-56b00c9304ab@suse.de> <840ec74d-60c6-9480-709c-8cd597c6f5b0@redhat.com>
 <e7fbef3c-2f87-15f9-b24d-34ffaa5a2853@suse.de> <CAMuHMdXnn+JcyMAV_Vbb4Yj8hJmae=Snc2R2fLviq67UYXg7Ew@mail.gmail.com>
In-Reply-To: <CAMuHMdXnn+JcyMAV_Vbb4Yj8hJmae=Snc2R2fLviq67UYXg7Ew@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 1 Feb 2022 18:06:33 +0100
Message-ID: <CAKMK7uEPuw1+-=h7gvSyCxW4zNuTK3UNZP6yjpP6MPV17sAasQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Feb 1, 2022 at 6:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Thomas,
>
> On Tue, Feb 1, 2022 at 5:16 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Am 31.01.22 um 11:18 schrieb Javier Martinez Canillas:
> > > Another thing that's missing is a DRM_MODE_CONNECTOR_I2C, because I used for
> > > now a DRM_MODE_CONNECTOR_Unknown.
> >
> > That might have implications on userspace. Maybe ask around. (Not that
> > we actually run userspace on the device).
>
> Looking at the list of connector types (and wondering if we're gonna
> need more when converting existing fbdev drivers to drm drivers),
> there seem to be two different families of connector types, for
>   1. transports between CRTC and display (e.g. VGA, DVID, HDMI),
>   2. transports between CPU and CRTC (e.g. SPI, possibly USB, and
>      the proposed I2C)?

I was trying to argue for a panel connector type and stop doing all
these internal things because like you point out, it kinda doesn't,
only the external connectors are relevant to users. But it didn't
stick anywhere yet, we keep adding more connector types and then
having to update userspace, which should map these all to "it's the
panel" or something like that. But also since various technicolor
abbreviations are about as useful to end-users as "unknown" it really
doesn't matter, so I'm happy to let this bikeshed get a tad fancier
every year :-)
-Daniel

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
