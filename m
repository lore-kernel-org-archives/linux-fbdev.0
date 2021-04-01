Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AB7C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Apr 2021 06:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E919610CA
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Apr 2021 06:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhDAGy4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233774AbhDAGye (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 1 Apr 2021 02:54:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 038B661057;
        Thu,  1 Apr 2021 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617260074;
        bh=olBbX+eEb1nBYZbDd0ck5A12mgL8uVtqeDAVawW24dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sc1VRMiQyANJhKGyqJErYjYUOSRK1lkiI9lw0K9FTavjnfuy1uzHTRrEVy9ULzQ8s
         nWSBhJvWwfa2oAH8glI+AxZ7UtgSS5n+aHny8NhuSW4QQ0iaoycw+OvekaV6K3+KFA
         Zpag93h+B/WpiFCFRzWt8RXH9IrGJTEFUWbsbjB4=
Date:   Thu, 1 Apr 2021 08:54:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hassan Shahbazi <h.shahbazi.git@gmail.com>
Cc:     daniel.vetter@ffwll.ch, jirislaby@kernel.org,
        yepeilin.cs@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix NULL pointer deference crash
Message-ID: <YGVuJ1R02GdYdM5p@kroah.com>
References: <20210331163425.8092-1-h.shahbazi.git@gmail.com>
 <YGSyFgeNd7gfsbR6@kroah.com>
 <20210401062154.5evjajj64r4tjseh@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401062154.5evjajj64r4tjseh@gentoo>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 01, 2021 at 09:21:54AM +0300, Hassan Shahbazi wrote:
> On Wed, Mar 31, 2021 at 07:32:06PM +0200, Greg KH wrote:
> > On Wed, Mar 31, 2021 at 07:34:29PM +0300, Hassan Shahbazi wrote:
> > > The patch has fixed a NULL pointer deference crash in hiding the cursor. It 
> > > is verified by syzbot patch tester.
> > > 
> > > Reported by: syzbot
> > > https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b
> > > 
> > > Signed-off-by: Hassan Shahbazi <h.shahbazi.git@gmail.com>
> > > ---
> > >  drivers/video/fbdev/core/fbcon.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > > index 44a5cd2f54cc..ee252d1c43c6 100644
> > > --- a/drivers/video/fbdev/core/fbcon.c
> > > +++ b/drivers/video/fbdev/core/fbcon.c
> > > @@ -1333,8 +1333,9 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
> > >  
> > >  	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
> > >  
> > > -	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
> > > -		    get_color(vc, info, c, 0));
> > > +	if (ops && ops->cursor)
> > 
> > As ops obviously is not NULL here (you just used it on the line above),
> > why are you checking it again?
> 
> Yes, that's right. I will remove that check and will submit a new patch.
> 
> 
> > And what makes curser be NULL here?  How can that happen?
> 
> Honestly, I don't know. I reproduced the crash on my local, followed the
> stack trace, and then changed the line to avoid the crash. If you think this
> patch is not the best solution, I can drop it and investigate more to find
> the root cause.

Finding the root cause would be good to do here, so that we can
potentially fix that if it is needed.

thanks,

greg k-h
