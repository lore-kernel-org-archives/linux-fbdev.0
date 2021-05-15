Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A03C433B4
	for <linux-fbdev@archiver.kernel.org>; Sat, 15 May 2021 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062FA6127C
	for <linux-fbdev@archiver.kernel.org>; Sat, 15 May 2021 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEOQn2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 15 May 2021 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhEOQn1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 15 May 2021 12:43:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCBAC06174A
        for <linux-fbdev@vger.kernel.org>; Sat, 15 May 2021 09:42:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j10so2670938lfb.12
        for <linux-fbdev@vger.kernel.org>; Sat, 15 May 2021 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKkVD1Qtnhdv59KfIngIIRAgpMVGtUMoAaJE9aWcwDg=;
        b=ZTy8QEEoSvjvmpGGdABqj29z7ZcuL0IRQ9UBKh89fhMz+j8cPVNUeZBKE8yaOCqkMJ
         kXzjCIiBF/NlemQsWsYyOaATN469b44wJYerSUSZFnkQiC4aQLy7om0FmX9cUarP4FxA
         D1eo9OLAbDq5eCqiokMYbyAbQahObMHCCCKQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKkVD1Qtnhdv59KfIngIIRAgpMVGtUMoAaJE9aWcwDg=;
        b=s+Bro/jo4iRRyqGksxTW5kYZOeOpSJAV5QY61VSx6APlX5lBe5BrrfiwAWa3hi5Mqz
         AxJCyh8x4LkG9g0QZzkh3yl0GkHCOayacJxtFitETw/6dBEVxC4tfEZIMw7pSciY/1ws
         Fnq3I7kjD5VHwhJmbNADS8FJyvqevqQjB8q3BpPM5+4Afg0mcZOKZp2rS5u6NWGKFRp2
         lLNeEyLTM1ZgyzgK3Cke0zk2Ga8ZZXYLPUzzkJOo3SZCtYI8aXgsVcd8nipi8VQHPGiE
         3zI2bxU0lEMmiDcmYw+ndQmcTjxuHJoBsS5bE96O724TJmKpmRwsZytk/RYArODQywsS
         c3YQ==
X-Gm-Message-State: AOAM532x0MHArQZkvD7LVGtWOTjvI+CQ0YAh6Y0WXSuruvF/rUWk/OdU
        D67VwcfVXfFU+BHvYOLQIyYr6Fj4DnDV6GYLPDk=
X-Google-Smtp-Source: ABdhPJzLrsfQ1L7slBdofCNjOC6K1LT/H/V2Tjtul6kUhUu+QNosI0q1OMDGGlQRdgmmqaLBuU4Jbg==
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr30134395lfu.647.1621096930946;
        Sat, 15 May 2021 09:42:10 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u11sm1179185lfo.28.2021.05.15.09.42.09
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 09:42:09 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x19so2731366lfa.2
        for <linux-fbdev@vger.kernel.org>; Sat, 15 May 2021 09:42:09 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr35147289lfs.377.1621096929091;
 Sat, 15 May 2021 09:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
 <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk> <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
 <CAHk-=wjkVAjfWrmmJnJe1_MriK9gezWCew_MU=MbQNzHbGopsQ@mail.gmail.com>
 <97f1d292-c3a8-f4d6-0651-b4f5571ecb72@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2105151815040.3032@angie.orcam.me.uk> <alpine.DEB.2.21.2105151828380.3032@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2105151828380.3032@angie.orcam.me.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 15 May 2021 09:41:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz-iC97f0cnawKZc_S4-0ZEOdOx43J7pVX6b=AqYUhfg@mail.gmail.com>
Message-ID: <CAHk-=wgz-iC97f0cnawKZc_S4-0ZEOdOx43J7pVX6b=AqYUhfg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: vt: always invoke vc->vc_sw->con_resize callback
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, May 15, 2021 at 9:33 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>  NB I suggest that you request your change to be backported, i.e. post v3
> with:
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org # v2.6.12+

I've applied it to my tree, but let's wait to see that it doesn't
cause any issues before notifying the stable people.

               Linus
