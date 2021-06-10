Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB0EC48BCD
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Jun 2021 02:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FFA61407
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Jun 2021 02:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFJCXJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:23:09 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40829 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJCXI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Jun 2021 22:23:08 -0400
Received: by mail-qk1-f179.google.com with SMTP id u30so25848835qke.7
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Jun 2021 19:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uDPH+DyrrwT4lbSphWmCoG1hpViWuQ2w27mykBkFVc=;
        b=Njm7S8vwHEU8y8WEPunSiOxdB85MAQChH0JJOqrIkLcXEISqthVv8toHTTIoj3mQck
         IJi0bhlcQlSbtjo9RCsyYEFqB+HrRD+5LGngi9NSS6HQKRUkpRpZjG84dohQK4yqgtyD
         e7rbI5g9mHtNqwoVWZ5n7XwNz/8043AM2adPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uDPH+DyrrwT4lbSphWmCoG1hpViWuQ2w27mykBkFVc=;
        b=dqggljiL2d6A/lyX1LQmk6oDe+2+OongMNZoiTe3YSryBC1vmpQ9QT5sWlYzqcv5hT
         bUtmiWpv/iPPP3fnxomuOXOdLY8C8CmsH5v17TbGWni/4Fi3Nk2BSNu4RA30HYyPTNIE
         0XeMiTR4eJKgk5e4XdwR9EiDu7UtksYwO3YzAJ1lFvDeEF2kbi/53nPlyYJApLny3CSq
         9nX3xtApNyzPrmYVGYOSV1xv1Si4/YCo4gPq68l72EGsCDiQVggBjw7yiwhKqvwpQrAZ
         q1lE1QTdk0gueqrRmmllft5sZtDb3a4h2iQd2FfPReYg2lraYEuWb3IjQL3hR/mj3iyW
         3IRg==
X-Gm-Message-State: AOAM532jz5gcGUItQr1bh4cPF4nXq7yxov2IKH1pShoxpKnFs6CfCYsx
        ve1UtxlI60Lhpl7rL2IUM7UiK9tFFFCFP71GJEFuFH0plMk=
X-Google-Smtp-Source: ABdhPJw3IL4mazrZgUhwP9U38MSzT4sS5dTjdzlKcKDRF2J3YiqUCreyiGkPK4H66++NDELboZAPF03DLAnk3a6VVQs=
X-Received: by 2002:a05:620a:1485:: with SMTP id w5mr2678230qkj.66.1623291597799;
 Wed, 09 Jun 2021 19:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210608103833.598348-1-joel@jms.id.au> <CAK8P3a00xuEAKTHrCDw52M-YPJUphSU8bYayW9P_xyNDsTsNzg@mail.gmail.com>
 <3877ae18-dbda-242a-60b2-f73734f8ba03@xs4all.nl> <CAK8P3a18EdBKQdGDOZc9cPKsf=hY8==v2cO0DBE_tyd82Uq-Ng@mail.gmail.com>
In-Reply-To: <CAK8P3a18EdBKQdGDOZc9cPKsf=hY8==v2cO0DBE_tyd82Uq-Ng@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Jun 2021 02:19:45 +0000
Message-ID: <CACPK8XcXABRKMRq95+w+TNW8NNccd0otoK5uRBSPca535yq7rA@mail.gmail.com>
Subject: Re: [PATCH] ARM: config: Refresh mutli v7
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 9 Jun 2021 at 09:30, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jun 8, 2021 at 6:49 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > On 08/06/2021 18:14, Arnd Bergmann wrote:
> >
> > Right now it is inherent to the driver. It is probably possible to drop support
> > for video overlay devices if CONFIG_FB=n, but it is not something I have time
> > for. It's just a test driver (albeit a very useful test driver), so it is no
> > big deal if it is disabled when CONFIG_FB=n.
>
> Ok, thanks for the reply, makes sense.
>
> I checked what other consequences there are if we disable CONFIG_FB
> and CONFIG_DRM_KMS_FB_HELPER=y in all the defconfigs now,
> as the patch from Kees did.
>
> It appears that the only other arm32 framebuffers that remain are
> FB_EFI=y, FB_WM8505=y, FB_MX3=m and FB_SIMPLE=y.

FB_SH_MOBILE_LCDC on arm32 too.

> As long as simplefb, efifb and xenfb are needed though, we probably
> want CONFIG_FB=y anyway and leaving VIVID=m with the dependency
> does not cause problems until those are all turned into drm drivers.

I will go ahead with this for the v7 defconfig.

Cheers,

Joel
