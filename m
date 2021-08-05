Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E8C432BE
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Aug 2021 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8042F60EB9
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Aug 2021 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbhHELb3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbhHELb3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Aug 2021 07:31:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80868C061765;
        Thu,  5 Aug 2021 04:31:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so7950489pjv.3;
        Thu, 05 Aug 2021 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EBdlg+wpGirHMmu5NpOXKP/wpVDNvTG7/9oMG8+2TA=;
        b=T79QxJMtJoS/ivMj3isDIYFd3/N4RCbbexFX0t1h5SX7XCPJG6tVru285TppZwWOPr
         eLuiWgak/SzvfxCMeG4cPfdLrPhJqkei5DRf6ZfGgL9tMjJQUU38jij0zr3xLU9j28GH
         wxfrOOBirApBfwqn3CSRucedRnCy4DrbFvNCcuCVWrZTZGGI0aVTm2TaHqUgjtJ+3/B2
         o31M0RBmSU/3x1RSNNGpOTtPvljeBXNQA+T3C1RHfEAJiEwBKlcRs9swRZXo1g/mYEAb
         0E8+4cxeJ9g6UfZ3uLjnb3l6p4N2oyMhLblsE4yoUBW/dejL05N4IYqb4X0fwpxGMZhh
         CqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EBdlg+wpGirHMmu5NpOXKP/wpVDNvTG7/9oMG8+2TA=;
        b=mImLOp5Zj3P7s55RbsUqBY0TvGLmGVHVMb8vfT8ELjNODOopzpS3MRV2TiDj72KV2q
         S0xb+mqtlvEwXauT/dskjScEFuWeYEMReW2Y7uq85glJ417W81IPpLi6o64HgVshwXqD
         RNq6ZkqCxAtw+4SFLLM9uOYXOpELXdoLEhqMimLysTn1WUCz6rtL4BhrWkvkFUje0X/J
         AmKu6bQffBP28HCJmKgmdUJAGyraMMWnzF23ssBPqaUOIDFdGUs7BXcOmlQ/Bj3WO+Yy
         RPQx7UEI7tMexOa1skbOHWaJu6BVg4ixOKDlcHgTWzi+YLJ72xI4vaqBMlDNmVT4neK9
         RrMg==
X-Gm-Message-State: AOAM533bxdQX8oaY2dDTV1BBelFTKyjvB6DijFk73XHJkfLR1v1pSXvB
        My+i9ItM3u9kgjK7pBGrOP0RzzorJbwN+oWrqdg=
X-Google-Smtp-Source: ABdhPJycCBqrY8XWLy+kVBb39vmiLH0ofV3jMCfOLQaWBv1ztWFo31bVO/8lk7CARMZbV+WTkAuumbYsSupxETjz690=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr14989609pjq.181.1628163074988;
 Thu, 05 Aug 2021 04:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210801085155.3170-1-len.baker@gmx.com> <CAHp75VcD_Kqedpkw-Pj+uQbWqdu_9FhXqJS5TuGUPoVv2x45-Q@mail.gmail.com>
 <YQvJB5s1zY2yO87D@kroah.com>
In-Reply-To: <YQvJB5s1zY2yO87D@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Aug 2021 14:30:35 +0300
Message-ID: <CAHp75VeUH3+dZ6scREA-sZz8-7AF_MLobde+2-eZJz=MsxaW0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove all strcpy() uses
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Aug 5, 2021 at 2:18 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Aug 01, 2021 at 02:40:40PM +0300, Andy Shevchenko wrote:
> > On Sun, Aug 1, 2021 at 11:53 AM Len Baker <len.baker@gmx.com> wrote:
> > >
> > > strcpy() performs no bounds checking on the destination buffer. This
> > > could result in linear overflows beyond the end of the buffer, leading
> > > to all kinds of misbehaviors. So, this serie removes all strcpy uses
> > > from the "staging/fbtft" subsystem.
> > >
> > > Also, refactor the code a bit to follow the kernel coding-style and
> > > avoid unnecessary variable initialization.
> >
> > I don't see patch 3 (even on lore.kernel.org).
> >
> > Greg, Geert, does it make sense to move this driver outside of staging?
>
> If you clean up everything that needs to be done, yes, please do.

Do we have a clear TODO for that?

The current one has the item which is not feasible to achieve in
reasonable time. Some of those drivers won't be converted to tiny DRM.
So the idea is to keep this out of staging in the maintenance phase
(as it currently states, i.e. no new drivers accepted).  For the rest
I'm not sure what else can be done (checkpatch? coccinelle?).
Actually the first sentence in this paragraph is a motivation for
moving out of staging.

-- 
With Best Regards,
Andy Shevchenko
