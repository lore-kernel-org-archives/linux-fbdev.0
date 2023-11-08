Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD51C4167D
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Nov 2023 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjKHVfN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Nov 2023 16:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjKHVfM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Nov 2023 16:35:12 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2EC2127
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Nov 2023 13:35:10 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7c08b7744so2186747b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Nov 2023 13:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699479309; x=1700084109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhaph37tDMn0AUVpfdaJ085jmOZUaCnuGtY8dKZyEE8=;
        b=JpAfsC4Ck58WLgzdf7Lgi9Xqhy0dtQyCc3J8bZ2qS5TpiQlFtf/DVrGGpkjmGj84wP
         SLqoBc+dePiFNWMsrjgrfLhipKYtX6KU2Mh+2QNCZTeYc/7si0n7ctphzr+37adZHksY
         Bu25Q+93cRk5BYGSQgvAcHl13GMTdtzc2dheq3QadNGw6WbNkESEtT5ACTCIuzptDgBu
         YtDf+e6RaqwehRm24rBr5jg8wQbwRnGYCgns5ZLJsa1VNJm/uy2uuaEH0lArw/bAHzRg
         NN4qrTxGx4azJnePss3cgtnqgTUP4mlFL/q9mH30kd1u117bCdlWGyBD6ukDE2hOSqD1
         KnYA==
X-Gm-Message-State: AOJu0YxZmVhA7vDipaQzsgGV92mvU2/dHHubXY59esWf4Jou4sH+7vYB
        N0dXrvU1MvG1032t6LV7/7Uc66mHuh9a9w==
X-Google-Smtp-Source: AGHT+IGJPO3nD/8Em+HhYqeUgft4FaP5q3Y2xLz1yG9S2kfh57bBuQFHfhvu0ExwVDb5HJFJnICSbw==
X-Received: by 2002:a81:4a44:0:b0:5ae:732b:ec21 with SMTP id x65-20020a814a44000000b005ae732bec21mr3236283ywa.34.1699479308903;
        Wed, 08 Nov 2023 13:35:08 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id p128-20020a0de686000000b0059beb468cb3sm7431899ywe.32.2023.11.08.13.35.08
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 13:35:08 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7af52ee31so2186207b3.2
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Nov 2023 13:35:08 -0800 (PST)
X-Received: by 2002:a81:80c6:0:b0:59a:d42c:5d50 with SMTP id
 q189-20020a8180c6000000b0059ad42c5d50mr2579753ywf.52.1699479308251; Wed, 08
 Nov 2023 13:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de>
 <20231107091740.3924258-2-u.kleine-koenig@pengutronix.de> <CAMuHMdVaaH_ZJT+jAyxZxnVYT3L=b4B-LEMTP4PqQH2TE0nH6g@mail.gmail.com>
 <9559f1d6-f68e-4c14-83b0-e5a545039124@gmx.de>
In-Reply-To: <9559f1d6-f68e-4c14-83b0-e5a545039124@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Nov 2023 22:34:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVsHHPAE5JXjC5rS86H=nDgBMePGU8b1y_wcQYrWZHuTA@mail.gmail.com>
Message-ID: <CAMuHMdVsHHPAE5JXjC5rS86H=nDgBMePGU8b1y_wcQYrWZHuTA@mail.gmail.com>
Subject: Re: [PATCH 01/22] fb: amifb: Stop using platform_driver_probe()
To:     Helge Deller <deller@gmx.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Atul Raut <rauji.raut@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Wed, Nov 8, 2023 at 10:32 PM Helge Deller <deller@gmx.de> wrote:
> On 11/8/23 22:06, Geert Uytterhoeven wrote:
> > On Tue, Nov 7, 2023 at 10:20 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> >> On today's platforms the benefit of platform_driver_probe() isn't that
> >> relevant any more. It allows to drop some code after booting (or module
> >> loading) for .probe() and discard the .remove() function completely if
> >> the driver is built-in. This typically saves a few 100k.
> >
> > Which is a lot on platforms with only a few MiBs of RAM...
>
> True.
> Given the warnings below, what is your suggestion?
> Better to drop the amifb patch ?

I think so. There is a reason these drivers use platform_driver_probe().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
