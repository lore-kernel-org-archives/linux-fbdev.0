Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FECDC5519F
	for <linux-fbdev@archiver.kernel.org>; Sat, 14 Nov 2020 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFCD22240
	for <linux-fbdev@archiver.kernel.org>; Sat, 14 Nov 2020 12:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHNGwpxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKNMRM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 14 Nov 2020 07:17:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgKNMRL (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 14 Nov 2020 07:17:11 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A419C22240;
        Sat, 14 Nov 2020 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605356231;
        bh=j0DSarFbsVLsjQPuCm5CwA5GVvdprYRqIia4pc4AM2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHNGwpxVYNZRVTkv4iQsYkQ+a2QRNhXlzj1AkXHhCLMHre7YcmLbMbBesS8g6jJF3
         oQpu7E+FSKKAiF6a+2OCxrEYI6BpgpRWgcX4zRWmKzPwbef3OUK1KXGe1+myDG2QW/
         FZhMp/J4wMiRpv796OfdoCXPm1LL/YO7R3M50Bvc=
Date:   Sat, 14 Nov 2020 13:18:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <X6/K/S9V7rj2hI5p@kroah.com>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
 <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com>
 <20201114081021.GA11811@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114081021.GA11811@PWN>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Nov 14, 2020 at 03:10:21AM -0500, Peilin Ye wrote:
> > On Fri, Nov 13, 2020 at 10:16:33PM +0100, Daniel Vetter wrote:
> > > On Thu, Nov 12, 2020 at 07:02:21AM -0500, Peilin Ye wrote:
> > > > Peilin Ye (5):
> > > >   console: Delete unused con_font_copy() callback implementations
> > > >   console: Delete dummy con_font_set() and con_font_default() callback implementations
> > > >   Fonts: Add charcount field to font_desc
> > > >   parisc/sticore: Avoid hard-coding built-in font charcount
> > > >   fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount
> > > 
> > > Patches all look good to me, if Greg is ok with me applying the entire
> > > pile to drm-misc-next I'll do that next week.
> 
> On Fri, Nov 13, 2020 at 11:47:51PM +0100, Greg Kroah-Hartman wrote:
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks for reviewing!  Questions about the last patch [5/5] though, it
> depends on the following assumption:
> 
> """
> For each console `idx`, `vc_cons[idx].d->vc_font.data` and
> `fb_display[idx].fontdata` always point to the same buffer.
> """
> 
> Is this true?  I think it is true by grepping for `fontdata`.  I also
> noticed that fbcon.c is using `vc->vc_font.data` and `p->fontdata`
> interchangeably, see fbcon_get_requirement():
> 
> 		vc = vc_cons[fg_console].d;
> 		[...]
> 			p = &fb_display[fg_console];
> 			caps->x = 1 << (vc->vc_font.width - 1);
> 					^^^^^^^^^^^
> 			caps->y = 1 << (vc->vc_font.height - 1);
> 					^^^^^^^^^^^
> 			caps->len = (p->userfont) ?
> 				FNTCHARCNT(p->fontdata) : 256;
> 					   ^^^^^^^^^^^
> 
> If it is true, then what is the point of using `fontdata` in `struct
> fbcon_display`?  Just for the `userfont` flag?  Should we delete
> `fontdata`, when we no longer need the `userfont` flag?

Yes, after a quick look, I think your analysis here is correct.  So if
you can delete that, it would be nice if possible.

> In this sense I think [5/5] needs more testing.  Do we have test files
> for fbcon, or should I try to write some tests from scratch?

I don't know of any direct tests, I usually just booted into that mode
and saw if everything looked like it did before.  There must be some
tool that you can use to change the current font, as it seems to happen
at boot time on some distros.  I can't remember what it's called at the
moment...

thanks,

greg k-h
