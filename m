Return-Path: <SRS0=rtSR=EM=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FA8C55178
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Nov 2020 13:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C77C20735
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Nov 2020 13:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzSON4Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgKFNpM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Nov 2020 08:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgKFNpM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Nov 2020 08:45:12 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED38C0613D2
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Nov 2020 05:45:12 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id f9so2010607lfq.2
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Nov 2020 05:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFaaHkEZDXkZw7mcXitvww1WQi+lH9aVg20pXq1ppCQ=;
        b=AzSON4OcTiZTErjvNJ8J0hIanSqC5Az0EoeoKVGuINfoHdHZg5BwdConxyJCa1pKty
         Evwtr2Dh4f6H288yjXruzhm+9dyKcIB2Qi7aPJNC9/wMc3Wg/BniZf75gDvCEgyV83nb
         s2w9/p500HUWRzYnVVFFA2RYyMR0Wb8uk1hKI9aStZSmndNHP/VupUVWpKuWD4r1QYQl
         /wgx+TrVclBVqEvJybXvSYe9Kt/x6uK9Uxh0q+/C/fVByy0jz/ez372HpUOxAQ7HsaHh
         59k5mCm/T8HxQZYyXNmIiLY5fDYHob0qCWWxuC1/kWzvreJSd+TCWhky9TIhri0Ztdjw
         9oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFaaHkEZDXkZw7mcXitvww1WQi+lH9aVg20pXq1ppCQ=;
        b=tFvlp6vXZcDE8vbTjmdxye/wazrDqkGUwhazGCcWXqSE6Fn9QhHM61K7YgGAf2vYf4
         lWxgg+T7cXSRn4EC/3t3vUGT7hTJtzTnnG1p2BUU0j8BjkWpo/kOqwNjjCmyiQ17K1Xy
         tS717xjUJ5BRXBGEzfubj0dMDJ/3Q7anU4U5eipzPukcUK/Z9f/BF08RiyUmU5XcTiqu
         FOoMuE2lKubU6ZkUmEBulnDW6siTkFpiEwcxrMJrdd7smtGkBRoy30QS3RlGL8BnRorb
         mDmwWyWlEgluh9L/n+BGX7EJnWsnIwbDsie8nHplAyN6QSKhUQRMR3EqOmRE2YQ6CY+J
         jfRw==
X-Gm-Message-State: AOAM5308X2NSSyoq2nwSp9cniUuRdn/rm108gQ1WI1V64JWxkxhpkXbe
        6ZHEDu96/02VWb8HdFl47mWGTc1Geh1xAaY0fnxHbWsUxJZ3Cw==
X-Google-Smtp-Source: ABdhPJyWSHxi1tQV8EQby75x5Z0Et6RvcJdIJRQogh9Gp81MCwEMVm+LRT9B9Zs5gzv1i+Uu1O1U6Y8Bz3sWlTsv7Uk=
X-Received: by 2002:a19:f00b:: with SMTP id p11mr885482lfc.585.1604670310747;
 Fri, 06 Nov 2020 05:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20201030002850.6495-1-linus.walleij@linaro.org> <20201101093654.GC1166694@ravnborg.org>
In-Reply-To: <20201101093654.GC1166694@ravnborg.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 14:45:00 +0100
Message-ID: <CACRpkdbdEVj0stJRbUDb3AVdZ0kVJP=z1-=DzB2J3aY+DgfPMg@mail.gmail.com>
Subject: Re: [PATCH] fbdev/sh_mobile: Drop unused include
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Nov 1, 2020 at 10:36 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Oct 30, 2020 at 01:28:50AM +0100, Linus Walleij wrote:
> > The driver includes <linux/gpio.h> but doesn't use any symbols
> > from this file.
> >
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks, I went ahead and applied this to drm-misc-next.
> And then I remembered you have commit right too :-(

Thanks! It is always better if someone else does it anyways!

Yours,
Linus Walleij
