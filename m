Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A8C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Apr 2021 06:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8688A61055
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Apr 2021 06:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhDAGWY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhDAGWE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 1 Apr 2021 02:22:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1BAC0613E6;
        Wed, 31 Mar 2021 23:22:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y1so976461ljm.10;
        Wed, 31 Mar 2021 23:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J4Zq0HjOinbfHP5aBY53rgZkCipWhKts2kh7ZSzk5ms=;
        b=nNPmQoBz383rd79jRE8PX7JDh4GxKdLSr5KrqmQXgAH+JEHkkKVh+wcRLB3w3gqxhp
         28YVmMzbcwbyWxNsh81zFdYCp8Mi4IPrrP4QRHqbVgsJIXssB/XGuhKKiLNoaTWimTF9
         59E2s+ADMs6oibIMXI09iVb9oxOLD+UhcqK+368KZ+My8/sVdP7+LC6603ja66WWd3BD
         MvNdHtPOElIXY08uoXD1HtRUgF0wIVWa1AEE5YlBO6wyuMI2FTRqONNuDqkNyrvw5RYz
         6k3c8F7CCDUzP7OluS6uOypQtDIRo7qaoDTof32sFi1jitSLnXP7VHbvKsf8j7PGzzG2
         gCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4Zq0HjOinbfHP5aBY53rgZkCipWhKts2kh7ZSzk5ms=;
        b=Naw1JsV7z1YOcgOQa1RbJbEJqg7J0om4Rz4/sZjDnlfaY55zsR2EToPWRik7IBvyZu
         4KCJEGbVWfsg0lMzdfH7KPz1+/ytXrjkd6QeorQ5R4UfZqtb2YCuK4G79r1WSX2pa7Jy
         V7ISULEpgKsCFWM458BuuUSL6d8sRBBwqFQHi5dZkajCmDdmwCMduCMtvnbI90/QeAFy
         WHWbEHywiILhHV89eGzceRdtva4HqYeJZj7C8ZcfbRU0/Xwh5DPe1KJvRugDdxVcafyl
         x99w570eudRjDhKoB76iMnRClpfx3fgxTo3zuz8xaEBrCKghGkctvk8UaO9h0/hbswNr
         k6rg==
X-Gm-Message-State: AOAM531vb4vGH1s7n7L+njafgfF18J7b/ZVCkuHxh+O3NpLpDISvmm9A
        0x2Ss4krBWpn8E89Uux/j04=
X-Google-Smtp-Source: ABdhPJxogPj7Otl1m3M2d2zKHtaf0HLq3zXFlpS4kjvFTAT4v1rDHDTNPvgGvOV5uDOSFCbkMD9wYA==
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr4477993ljk.169.1617258122518;
        Wed, 31 Mar 2021 23:22:02 -0700 (PDT)
Received: from gentoo (cable-hki-50dc2f-26.dhcp.inet.fi. [80.220.47.26])
        by smtp.gmail.com with ESMTPSA id l6sm442160lfp.13.2021.03.31.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:22:02 -0700 (PDT)
Date:   Thu, 1 Apr 2021 09:21:54 +0300
From:   Hassan Shahbazi <h.shahbazi.git@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     daniel.vetter@ffwll.ch, jirislaby@kernel.org,
        yepeilin.cs@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        h.shahbazi.git@gmail.com
Subject: Re: [PATCH] fix NULL pointer deference crash
Message-ID: <20210401062154.5evjajj64r4tjseh@gentoo>
References: <20210331163425.8092-1-h.shahbazi.git@gmail.com>
 <YGSyFgeNd7gfsbR6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGSyFgeNd7gfsbR6@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Mar 31, 2021 at 07:32:06PM +0200, Greg KH wrote:
> On Wed, Mar 31, 2021 at 07:34:29PM +0300, Hassan Shahbazi wrote:
> > The patch has fixed a NULL pointer deference crash in hiding the cursor. It 
> > is verified by syzbot patch tester.
> > 
> > Reported by: syzbot
> > https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b
> > 
> > Signed-off-by: Hassan Shahbazi <h.shahbazi.git@gmail.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index 44a5cd2f54cc..ee252d1c43c6 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -1333,8 +1333,9 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
> >  
> >  	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
> >  
> > -	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
> > -		    get_color(vc, info, c, 0));
> > +	if (ops && ops->cursor)
> 
> As ops obviously is not NULL here (you just used it on the line above),
> why are you checking it again?

Yes, that's right. I will remove that check and will submit a new patch.


> And what makes curser be NULL here?  How can that happen?

Honestly, I don't know. I reproduced the crash on my local, followed the
stack trace, and then changed the line to avoid the crash. If you think this
patch is not the best solution, I can drop it and investigate more to find
the root cause.


> Also your subject line can use some work, please make it reflect the
> driver subsystem you are looking at.
 
This was a mistake, I did not intend to change the subject. I will ensure
the next patch reflects the subsystem.

> thanks,
> 
> greg k-h

Best,
Hassan Shahbazi
