Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4DC5519F
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 10:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2772068D
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 10:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a6i4D5Y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgKPKJy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgKPKJy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 16 Nov 2020 05:09:54 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE906C0613CF
        for <linux-fbdev@vger.kernel.org>; Mon, 16 Nov 2020 02:09:53 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a65so23080875wme.1
        for <linux-fbdev@vger.kernel.org>; Mon, 16 Nov 2020 02:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MLjK6J0k3buFVe3tEUAsMN0q98BNbXOGLlBrDEbH84=;
        b=a6i4D5Y+4nk3y2ls3YB96MU9fUh3mrXTMUe7VWAWUO3gFEHiRJQkOBB1u+DeDeRvx1
         eHxFOkkp52v2pmkNR/GLFPHURXZW/zkqIWmLE4cb76mndPZDbjTiwpngE6kr21lARrEO
         GxzLEG61dbv150CtbZBkFr0qmeEUf0PnoJx+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4MLjK6J0k3buFVe3tEUAsMN0q98BNbXOGLlBrDEbH84=;
        b=G5iOF42YzkRbIl9zCRI1yVtJ5Uu87SZKy6puhLi3oXGb41upTzqxBaaKvhce+iaxfx
         4S3nOVfO8wALFg5WJKOxG38BUiaae60EYhiG6Uy8Sz95UC1pwrU2mUWOJmla13LrhBXp
         QJxmj9Wkhsz7Bz29Sl3bd5y4aJuVXhucNJnZm/D9aRs9xBJORdUAZEu8mbAALmVLYXPa
         If9Ry2i6ScmQREj+TgTGekVr7FASVDuq0xU8s/35P052FJnDcgldA1xP+1+ezzpq5yV6
         nNpfH8Z1VLF1a9WgjE4ujnXhFj1b6UKDf9R+0aWIZeL6nDRGgZLArPfPehnfq5ozxgV+
         Lehw==
X-Gm-Message-State: AOAM5336sOghb4vuAHE/ryvvh1/yn0PdZk9FeRo3Kr4Bghm6MqwoeJtC
        PcTbs+VkecSn9o9qXWnLJzhVjw==
X-Google-Smtp-Source: ABdhPJwONcExmyTYHidHN0GxV7kDjejfxFlk6aedYSxZdK1kyQtA0Gq67bmGzc2T92ICVkGj4qFCXw==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr14508609wmg.3.1605521392276;
        Mon, 16 Nov 2020 02:09:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u23sm20369149wmc.32.2020.11.16.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:09:51 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:09:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <20201116100949.GA401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
 <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com>
 <20201114081021.GA11811@PWN>
 <X6/K/S9V7rj2hI5p@kroah.com>
 <X6/L/lE2pA7csBwd@kroah.com>
 <20201114124716.GA12895@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114124716.GA12895@PWN>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Nov 14, 2020 at 07:47:16AM -0500, Peilin Ye wrote:
> On Sat, Nov 14, 2020 at 01:22:22PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Nov 14, 2020 at 01:18:06PM +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Nov 14, 2020 at 03:10:21AM -0500, Peilin Ye wrote:
> > > > Thanks for reviewing!  Questions about the last patch [5/5] though, it
> > > > depends on the following assumption:
> > > > 
> > > > """
> > > > For each console `idx`, `vc_cons[idx].d->vc_font.data` and
> > > > `fb_display[idx].fontdata` always point to the same buffer.
> > > > """
> > > > 
> > > > Is this true?  I think it is true by grepping for `fontdata`.  I also
> > > > noticed that fbcon.c is using `vc->vc_font.data` and `p->fontdata`
> > > > interchangeably, see fbcon_get_requirement():
> > > > 
> > > > 		vc = vc_cons[fg_console].d;
> > > > 		[...]
> > > > 			p = &fb_display[fg_console];
> > > > 			caps->x = 1 << (vc->vc_font.width - 1);
> > > > 					^^^^^^^^^^^
> > > > 			caps->y = 1 << (vc->vc_font.height - 1);
> > > > 					^^^^^^^^^^^
> > > > 			caps->len = (p->userfont) ?
> > > > 				FNTCHARCNT(p->fontdata) : 256;
> > > > 					   ^^^^^^^^^^^
> > > > 
> > > > If it is true, then what is the point of using `fontdata` in `struct
> > > > fbcon_display`?  Just for the `userfont` flag?  Should we delete
> > > > `fontdata`, when we no longer need the `userfont` flag?
> > > 
> > > Yes, after a quick look, I think your analysis here is correct.  So if
> > > you can delete that, it would be nice if possible.
> 
> I see, at the moment we still need `userfont` for refcount handling, I
> will try to delete both `fontdata` and `userfont` after refcount is
> taken care of.

+1 on sunsetting fondata. I think there's a bunch of these in fbcon code,
because the console subsystem is older than the standard "allow drivers to
embed the subsystem struct into their own private struct" subclassing
model. So lots of global arrays indexed by the console id :-/

> > > > In this sense I think [5/5] needs more testing.  Do we have test files
> > > > for fbcon, or should I try to write some tests from scratch?
> > > 
> > > I don't know of any direct tests, I usually just booted into that mode
> > > and saw if everything looked like it did before.  There must be some
> > > tool that you can use to change the current font, as it seems to happen
> > > at boot time on some distros.  I can't remember what it's called at the
> > > moment...
> > 
> > Ah, here's a hint:
> > 	https://wiki.archlinux.org/index.php/Linux_console#Fonts
> > 
> > The setfont tool should help you out here.
> 
> Oh, I didn't know about this one.  I'll go experimenting with it,
> thank you!

We're also trying to start some kind of test suite for fbdev chardev ioctl
interface in the gpu test suite. fbcon tests are maybe more related to
tty/vt, and I have no idea whether anything exists there already.

But if you want to do some automated testcases for fbcon and there's
absolutely no other home for them, the gpu test suite might be an option
of last resort too:

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#testing-and-validation

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
