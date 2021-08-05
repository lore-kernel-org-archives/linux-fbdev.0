Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD6C4338F
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Aug 2021 11:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B3461102
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Aug 2021 11:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhHELSs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbhHELSs (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 5 Aug 2021 07:18:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DABF0600EF;
        Thu,  5 Aug 2021 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628162313;
        bh=DdQzlZ8vWjMbBjovaP8o9XoM1Irb0BPSwOEizsTvoPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6Y4IlN3BosamOneCduHXzFLrjeCTqR+kC/hL+fUn1zkZ0KB99FGtBi6f/bzJ+22a
         QBynemR7NZnbRCiVATHQfiIj9HKfnefJ5FhngZBbZKqyqgI9BbIsCQ7E7nUjBdmWKA
         g3Fwl4+4xKHj5kn8lTkB6F2mJr5E7nyWBOqM09hk=
Date:   Thu, 5 Aug 2021 13:18:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Remove all strcpy() uses
Message-ID: <YQvJB5s1zY2yO87D@kroah.com>
References: <20210801085155.3170-1-len.baker@gmx.com>
 <CAHp75VcD_Kqedpkw-Pj+uQbWqdu_9FhXqJS5TuGUPoVv2x45-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcD_Kqedpkw-Pj+uQbWqdu_9FhXqJS5TuGUPoVv2x45-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Aug 01, 2021 at 02:40:40PM +0300, Andy Shevchenko wrote:
> On Sun, Aug 1, 2021 at 11:53 AM Len Baker <len.baker@gmx.com> wrote:
> >
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. So, this serie removes all strcpy uses
> > from the "staging/fbtft" subsystem.
> >
> > Also, refactor the code a bit to follow the kernel coding-style and
> > avoid unnecessary variable initialization.
> 
> I don't see patch 3 (even on lore.kernel.org).
> 
> Greg, Geert, does it make sense to move this driver outside of staging?

If you clean up everything that needs to be done, yes, please do.

thanks,

greg k-h
