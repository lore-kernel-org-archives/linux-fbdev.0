Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D821EC5519F
	for <linux-fbdev@archiver.kernel.org>; Sat, 14 Nov 2020 12:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED532222C
	for <linux-fbdev@archiver.kernel.org>; Sat, 14 Nov 2020 12:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZZUKtrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKNMrY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 14 Nov 2020 07:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNMrX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 14 Nov 2020 07:47:23 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85878C0613D1;
        Sat, 14 Nov 2020 04:47:23 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id f12so1595249pjp.4;
        Sat, 14 Nov 2020 04:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/alDDGu77kr1jyJS2Dgo0f8lEWMLifOcaqhyEonywU8=;
        b=aZZUKtrUI7FUZgNGTm6DhtaXCamioS0bcVM4yFOgeZ+hB3mXPddqxnr31T1x6L9cUR
         MWquPRrsz+r8KdnHNpo23GDU1SPGYQ+vxFD3gzNIm15BlwfVU7/+Q/Hqt6qG1jgRGplg
         R75u0DD9C2uGSJj+wOvc8R9h97myHYN0cywbq8d0Wg1qglgQ6ELvlpKqYORyUQOW/Y7o
         G5zBMMdU2blRUi2RtuFa4x/SW6tllf97FApPk2ItQlc9+UQdy1ljwxYr/STw5eW9g4a8
         WFmU+f13dm0rNIwTUURrUGfbfVZpqQOm6rHy0nJdoFYUWBQvIXMSwaFo0wBQSs/X6hAD
         Xi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/alDDGu77kr1jyJS2Dgo0f8lEWMLifOcaqhyEonywU8=;
        b=fTeADznYJ5MBJ9jVt4DkYtQTNO6ulag8v7h27NnTTuFXErPeg9fb/zD4/ORH5lBh/r
         bNH/M2hJrtuYgzOFPbRphbSSOJgqsyeC03i14gTqoBkdQIPMhyHhLUcfJYgsR0Gy7K+l
         /CfNu2kw07wVQ5ZWgNvMcQqQ3BqW+rdpvLy4uHvn7J79t2qWgcoUJZqVzektUJNfr1he
         snxefKtzmOs6iNHEcZ4E3EwBpeFl3u/Z8xkBX9FyXJ3g1QeBWK03qQYNzA0RV9QsOewW
         pbjFaGLiBSDoooOemIvdEhQUTB+U7WHlQUKHNTy5QHaePLYMvzQESLSl/ENtbBptxP/W
         iXuw==
X-Gm-Message-State: AOAM531Hj9r7PM2YhtczQ9kpYwk/z+RbGIXrGzS68FMRA6Lz3GxGusWz
        XDN84S3syWZJmZs9DUBv2SQkur/SNUrTDsQ=
X-Google-Smtp-Source: ABdhPJxSMdYyDAOZ38fW7UFYncbtCKRMWFct9sclLFI+IJLblPh6HQkyy4+V8bEkfe5qfFkLISAaeA==
X-Received: by 2002:a17:90a:5884:: with SMTP id j4mr7589631pji.7.1605358043132;
        Sat, 14 Nov 2020 04:47:23 -0800 (PST)
Received: from PWN ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id s9sm12522743pfs.89.2020.11.14.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 04:47:22 -0800 (PST)
Date:   Sat, 14 Nov 2020 07:47:16 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <20201114124716.GA12895@PWN>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
 <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com>
 <20201114081021.GA11811@PWN>
 <X6/K/S9V7rj2hI5p@kroah.com>
 <X6/L/lE2pA7csBwd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6/L/lE2pA7csBwd@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Nov 14, 2020 at 01:22:22PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 14, 2020 at 01:18:06PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Nov 14, 2020 at 03:10:21AM -0500, Peilin Ye wrote:
> > > Thanks for reviewing!  Questions about the last patch [5/5] though, it
> > > depends on the following assumption:
> > > 
> > > """
> > > For each console `idx`, `vc_cons[idx].d->vc_font.data` and
> > > `fb_display[idx].fontdata` always point to the same buffer.
> > > """
> > > 
> > > Is this true?  I think it is true by grepping for `fontdata`.  I also
> > > noticed that fbcon.c is using `vc->vc_font.data` and `p->fontdata`
> > > interchangeably, see fbcon_get_requirement():
> > > 
> > > 		vc = vc_cons[fg_console].d;
> > > 		[...]
> > > 			p = &fb_display[fg_console];
> > > 			caps->x = 1 << (vc->vc_font.width - 1);
> > > 					^^^^^^^^^^^
> > > 			caps->y = 1 << (vc->vc_font.height - 1);
> > > 					^^^^^^^^^^^
> > > 			caps->len = (p->userfont) ?
> > > 				FNTCHARCNT(p->fontdata) : 256;
> > > 					   ^^^^^^^^^^^
> > > 
> > > If it is true, then what is the point of using `fontdata` in `struct
> > > fbcon_display`?  Just for the `userfont` flag?  Should we delete
> > > `fontdata`, when we no longer need the `userfont` flag?
> > 
> > Yes, after a quick look, I think your analysis here is correct.  So if
> > you can delete that, it would be nice if possible.

I see, at the moment we still need `userfont` for refcount handling, I
will try to delete both `fontdata` and `userfont` after refcount is
taken care of.

> > > In this sense I think [5/5] needs more testing.  Do we have test files
> > > for fbcon, or should I try to write some tests from scratch?
> > 
> > I don't know of any direct tests, I usually just booted into that mode
> > and saw if everything looked like it did before.  There must be some
> > tool that you can use to change the current font, as it seems to happen
> > at boot time on some distros.  I can't remember what it's called at the
> > moment...
> 
> Ah, here's a hint:
> 	https://wiki.archlinux.org/index.php/Linux_console#Fonts
> 
> The setfont tool should help you out here.

Oh, I didn't know about this one.  I'll go experimenting with it,
thank you!

Peilin Ye

