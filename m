Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD45C433B4
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Apr 2021 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2156120B
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Apr 2021 07:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhDLHCC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbhDLHCC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Apr 2021 03:02:02 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C59C061574
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Apr 2021 00:01:44 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x2so12489133oiv.2
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Apr 2021 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eoMDF/wQXgBqcptxwajgyfKHfls18wSno0OgI96W1M=;
        b=Z8VViXsU+J+0t/NeghxVqUCLlf+iJt7KQWTk4fn7J0Nqu3GKiTU3uJNBi11dErZRwT
         qnV047UmDkOKJgZ2nIQStIbrlGb9jB10Xmbj7Mejny8Wh9w7qeKQqkHolxPkpkHbbbBD
         aiS9/TWhgdvEiE4xcNmO7YFTO+uBl46QmeBMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eoMDF/wQXgBqcptxwajgyfKHfls18wSno0OgI96W1M=;
        b=Rblpio86BEADDc2hPFh82dCCjpKdQiQ3E6Yx7UFvIDN2LQWI+PBlB9IVabpT9irbcs
         jNwWgMw5qbza6mFrUiOwia274EsVS+x6vGn04dOjLR91wRk2BJM7opg5XSPFpIZNbSx/
         3CDx7ZssEiyXG9ft2oXRRcP6kjTEPxTMQmZYbv3XyuI0oLcqHHPoc0PjnAqOjB6+p1r+
         uv8R40k5PgnidcGDgdJ9f8SqFihhLXgufyTLE3JJ9jTL24junymNDT+j9bQn+AukZRnM
         TObETTaoBVY6OaFtUDRnIeESm8hiRPR7hZKF+WMzhKWBdn4tBYbVwlZX2AWOstxXPlMQ
         WveQ==
X-Gm-Message-State: AOAM5303txnqQ2bq1cBX8xJOzlj/Jx6rf9yOAD/8mD7F1ZqBI7wR6+tD
        bjfXEwTxJVAsMhYDKY0szKyXbtyZ6i3F9GW0ou94ZA==
X-Google-Smtp-Source: ABdhPJzn5Y2JD1WWkuSgCEM5RLfbCHfU+wnK35eIswbiFH+SCiimFsZXPintcEeiw7HxTPKJ26KJl6K2LFSWL/9S3TA=
X-Received: by 2002:aca:b646:: with SMTP id g67mr17522124oif.14.1618210904061;
 Mon, 12 Apr 2021 00:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000226d3f05b02dd607@google.com> <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN> <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
 <20200928175956.GF24673@neutronstar.dyndns.org> <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
 <20200929105203.GG24673@neutronstar.dyndns.org> <20200929165657.GS438822@phenom.ffwll.local>
 <20200929171040.GB1351851@kroah.com> <alpine.DEB.2.21.2104112250310.65251@angie.orcam.me.uk>
 <CAHk-=wgF8e5i+9eeGu=CgWAagTPv-9UbkG7B6bR5jDe6kkkFZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgF8e5i+9eeGu=CgWAagTPv-9UbkG7B6bR5jDe6kkkFZQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 12 Apr 2021 09:01:32 +0200
Message-ID: <CAKMK7uH4+SGr0=FDBiTsMg+iE1ztiuP2QBxsgcvHNhd38ocndg@mail.gmail.com>
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg KH <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Apr 12, 2021 at 12:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Apr 11, 2021 at 2:43 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> >
> >  So it does trigger with vgacon and my old server, which I have started
> > experimenting with and for a start I have switched to a new kernel for an
> > unrelated purpose (now that I have relieved it from all its usual tasks
> > except for the last remaining one for which I haven't got the required
> > user software ported to the new system yet):
> >
> > "struct vt_consize"->v_vlin is ignored. Please report if you need this.
> > "struct vt_consize"->v_clin is ignored. Please report if you need this.
>
> Note that it's entirely possible that things continue to work well
> despite this warning. It's unclear to me from your email if you
> actually see any difference (and apparently you're not able to see it
> right now due to not being close to the machine).

Original search didn't turn up any users of VT_RESIZEX, this is the
first. And looking at the source code I think we could outright remove
support for VT_RESIZEX (but make it silent) and everything should keep
working:

        /*
         * ALWAYS do a VT_RESIZE, even if we already did a VT_RESIZEX
on a 1.3.3 or higher kernel,
         * until those kernel programmers make this unambiguous
         */

       if (do_VT_RESIZE(curr_textmode->cols, curr_textmode->rows,
resize1x1)) sresize=TRUE;

       if (check_kernel_version(1,3,3, "VT_RESIZEX"))
         {
           /*
            * VDisplay must de divided by 2 for DoubleScan modes,
            * or VT_RESIZEX will fail -- until someone fixes the kernel
            * so it understands about doublescan modes.
            */
           if (do_VT_RESIZEX(curr_textmode->cols,
                             curr_textmode->rows,
                             curr_textmode->VDisplay /
(MOFLG_ISSET(curr_textmode, ATTR_DOUBLESCAN) ? 2 : 1),
                             curr_textmode->FontHeight,
                             curr_textmode->HDisplay/8*curr_textmode->FontWidth,
                             curr_textmode->FontWidth, resize1x1)) sresize=TRUE;
         }

The functions are just straightforward wrappers. There's also no cvs
repo, changelog or old releases before 2000 that would shed some light
on why this code even exists.

I think we can just tune down the pr_info_once to pr_debug and done.
Maybe a comment about where the single user we're aware of is.
-Daniel

>
> The fact that v_vlin/v_clin are ignored doesn't necessarily mean that
> they are different from what they were before, so the warning may be a
> non-issue.
>
> > It continues using svgatextmode with its glass (CRT) VT to set my usual
> > 80x37 text mode (720x576 pixel resolution) by manipulating the VGA clock
> > chip and the CRT controller appropriately for a nice refresh rate of 85Hz:
> >
> > Chipset = `TVGA8900', Textmode clock = 44.90 MHz, 80x37 chars, CharCell = 9x16. Refresh = 52.51kHz/84.7Hz.
>
> That doesn't seem necessarily wrong to me.
>
> >  So what's the supposed impact of this change that prompted the inclusion
> > of the messages?
>
> There _may_ be no impact at all apart from the messages.
>
> The code _used_ to set the scan lines (v_vlin) and font height
> (v_clin) from those numbers if they were non-zero, and now it just
> ignores them and warns instead.
>
> The code now just sets the font height from the actual font size when
> the font is set. Which is honestly the only thing that ever made
> sense. Trying to set it with v_clin is ignored, but it's entirely
> possible - maybe even likely - that your user of VT_RESIZEX sets it to
> the same values it already has.
>
> Exactly because setting a font line number to anything else than the
> font size isn't exactly sensible.
>
> But if your screen looks different than it used to, that is obviously
> interesting and says something actually changed (outside of the
> message itself).
>
>            Linus
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
