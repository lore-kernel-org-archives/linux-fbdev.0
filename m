Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECAC4338F
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD9C60F47
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 09:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhGZJCX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhGZJCX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 05:02:23 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67827C061757;
        Mon, 26 Jul 2021 02:42:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x15so10178528oic.9;
        Mon, 26 Jul 2021 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmkea5YDHGw17k/ybnZR0rAFGmyibzBzYCKsHFjIEzA=;
        b=pyjNPEEUkCDlGg18k4xOqInTRq+09N4hGdKi4FyCWX8axPRjR3KlqaZWcmGqrm+rSp
         gBiTp843hbax36haDP969DsSTuB0w+2oz0yClZpj07zj6uTib9llPknRlALQOO+64y4L
         sPWUYohijjrikV83ag9J0Bbib04C921VrSrKC7hURd8QyrJiS0wE5RwkKUS8T/UjziGw
         XaV6b9NAyx7EEssBgXkV6L7KSpyuicP5wNiQjiZBlCaQ9VAu2U0JVyX5uwFzhql4GiSx
         opipW05EZwpCsBBb8H3/JL/LWAhvkXextIeeLnjZ3OMMRfvE4we815oNII91P5/p4UwY
         iaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmkea5YDHGw17k/ybnZR0rAFGmyibzBzYCKsHFjIEzA=;
        b=CINrgsHEoDCo3AMEsO2+zwzvRLnmmmkS3sKSzZi+8fdeK8O9tnFLg2Mr1wSRZGstXA
         83caq7s8YmeOdYeZA056DECeNBtb7dC+cICN4gSoWkvlGrAnDtmdGuUcmUZnAeuH6ezn
         hjpCNj4TcTxdLSdr4NZ85Ecn3k6TK1ncp5kplMekNgKrI7bxaWzXCNfM8cnm9B82Gnhb
         2G2G9rra22dEnhD9xxyuugb45pMhcS0dTuAJme78h8oqLalXlbxmzNaKcSqiubE2NCbr
         PtewfibrE07RjgoCqxAB0uzemLJxYRYcbP4yBtOK3wS/VQSSTYn4Ujt+xGBI1V24pjNY
         wZXQ==
X-Gm-Message-State: AOAM5324z8iyTPS6lS24XjuBliQALsPvrUPFfsXF6CPL5O14miRKOnDw
        ELWH9DpaszD/3LfYDOlTvl9ypJtP1y/WaT8XQQ==
X-Google-Smtp-Source: ABdhPJxIgzRyC9Q9Eo0c7XHCyPeYoTsLo1zcVEOgH0skxN2GsCcZOc3VeoF4D0/YO4Ckd1zJwLLPp4dH+9ovajf1R5M=
X-Received: by 2002:a05:6808:1448:: with SMTP id x8mr10606901oiv.57.1627292570863;
 Mon, 26 Jul 2021 02:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <1627179054-29903-1-git-send-email-zheyuma97@gmail.com> <YP3HI0rm9jVwm3ma@ravnborg.org>
In-Reply-To: <YP3HI0rm9jVwm3ma@ravnborg.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 26 Jul 2021 17:42:39 +0800
Message-ID: <CAMhUBj=hkmDjo4MseGsYRwwofQdeUm4HChsRWdwE0XF4WY9x9Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] add checks against divide error
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     adaplas@gmail.com, linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jul 26, 2021 at 4:18 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Zheyu,
>
> On Sun, Jul 25, 2021 at 02:10:51AM +0000, Zheyu Ma wrote:
> > Zheyu Ma (3):
> >   video: fbdev: kyro: add a check against divide error
> >   video: fbdev: riva: add a check against divide error
> >   video: fbdev: asiliantfb: add a check against divide error
>
> I would prefer something a bit more descriptive - like:
>
> video: fbdev: <driver>: Error out if pixclk equals zero
>
> Please respin so we have something like the above.
> I looked briefly at the patches, they looked fine.

Thanks for your valuable comments, I will re-edit the commit log and
send the patches.

Regards,
Zheyu Ma
