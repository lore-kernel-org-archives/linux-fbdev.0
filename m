Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F25C2D0A3
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E382071A
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 10:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=somia-fi.20150623.gappssmtp.com header.i=@somia-fi.20150623.gappssmtp.com header.b="WwwV+CZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgKAKc4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 05:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgKAKcz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 05:32:55 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE8C0617A6
        for <linux-fbdev@vger.kernel.org>; Sun,  1 Nov 2020 02:32:55 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id b1so13541316lfp.11
        for <linux-fbdev@vger.kernel.org>; Sun, 01 Nov 2020 02:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=somia-fi.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XccLLBP9fbRYIFzEXKVSu/gBJa6cdMsyr2qn7Nbznok=;
        b=WwwV+CZl0NVtbCCh/l8XgYPXAFhUHgNsHltaOXJGKtTvTglrbNZbWRtUuEwc0hbGdt
         qsCJSM5z2o+axm2vx0NKfKdx7cu9JsH8ZWbxdiSN1fmmTEiTLdtxcaC7iQ33gcBBGdlb
         Kz7Ua5HmTR1xDMN4qaohI/9TqjGHd0YJ6WDwTBQSwpm4UKTPZLXv3avbi/RJTbpuKgx2
         U41eXekBeFPjVKQdCQW4G93sMykidUcnfcLKXpRXTCQ7bMIFxHfPoQdClUHyXSYrQlTt
         gJt3zKO4ml5cAaoa3b1vk+l6KwQsqOBrhSrz/hN1WumVQoSjzkVtvsHVJn5oBaGZS2y6
         w0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XccLLBP9fbRYIFzEXKVSu/gBJa6cdMsyr2qn7Nbznok=;
        b=W3L3SMVtkHoV/QCBahDZW801NiGk0rwUCZG3TdMqeHz3f7YBO3hYsT+7a16So7yQmD
         Lo2lguFcQ0NproWdFEUb93GZxiZASbchJ03DxZU04sPC2tkvQtKwFok+Yl6waoG+pXxv
         +LOaDsQibmIcChuZ2d0T841XSs5AScRXawgf4qIOt3Ki7Z8gEm82piJRr51aUH+PgGb6
         4cvG8tXaKBuKVU8VX6V/K0PXskqGsnjf+zsHKhFdRM104J9pP3tGbtbG0tekyRN+6KpQ
         HDL6FtNer5FZqTbifj7qA3US+CElPT1OHz4GcsFq0Q72wI3OHPTOtZfr7lgYufQr2Ia4
         qZLw==
X-Gm-Message-State: AOAM531pK61EvGBBqGa+chmN9zrpv1WY6fj1AxBdGTGb/yRGh3ROMnhl
        luwn4bIr32bny0qeF/4Pg7Xf9UKiAmAoofQsxOTZxA==
X-Google-Smtp-Source: ABdhPJzVLNrNcDLn6wEEouuMkd8Z++tSxcYxH3ylGbIuf4MrUF2yQHmMz/+jFeFirOfZDR+sMtJdjA==
X-Received: by 2002:a19:83c9:: with SMTP id f192mr3746517lfd.148.1604226773613;
        Sun, 01 Nov 2020 02:32:53 -0800 (PST)
Received: from ubuntu (cable-hki-50dc37-152.dhcp.inet.fi. [80.220.55.152])
        by smtp.gmail.com with ESMTPSA id s7sm1628612ljc.10.2020.11.01.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 02:32:53 -0800 (PST)
From:   Hassan Shahbazi <hassan.shahbazi@somia.fi>
X-Google-Original-From: Hassan Shahbazi <hassan@ninchat.com>
Date:   Sun, 1 Nov 2020 12:32:44 +0200
To:     Greg KH <greg@kroah.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_watterott: fix usleep_range is
 preferred over udelay
Message-ID: <20201101103244.GA284952@ubuntu>
References: <20201101002010.278537-1-hassan@ninchat.com>
 <20201101063948.GB432418@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101063948.GB432418@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Nov 01, 2020 at 07:39:48AM +0100, Greg KH wrote:
> On Sun, Nov 01, 2020 at 02:20:10AM +0200, Hassan Shahbazi wrote:
> > Fix the checkpath.pl issue on fb_watterott.c. write_vmem and
> > write_vmem_8bit functions are within non-atomic context and can
> > safely use usleep_range.
> > see Documentation/timers/timers-howto.txt
> > 
> > Signed-off-by: Hassan Shahbazi <hassan@ninchat.com>
> > ---
> >  drivers/staging/fbtft/fb_watterott.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
> > index 76b25df376b8..afcc86a17995 100644
> > --- a/drivers/staging/fbtft/fb_watterott.c
> > +++ b/drivers/staging/fbtft/fb_watterott.c
> > @@ -84,7 +84,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
> >  			par->txbuf.buf, 10 + par->info->fix.line_length);
> >  		if (ret < 0)
> >  			return ret;
> > -		udelay(300);
> > +		usleep_range(300, 310);
> >  	}
> >  
> >  	return 0;
> > @@ -124,7 +124,7 @@ static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
> >  			par->txbuf.buf, 10 + par->info->var.xres);
> >  		if (ret < 0)
> >  			return ret;
> > -		udelay(700);
> > +		usleep_range(700, 710);
> 
> How do you know that these ranges are ok?  Are you able to test these
> changes with real hardware?
> 
> thanks,
> 
> greg k-h

No, I don't have the hardware to test with. I just used the current
value as the minimum and added an epsilon to it for the maximum
param.

best, hassan shahbazi
