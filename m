Return-Path: <SRS0=rtSR=EM=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3E8C388F2
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Nov 2020 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766A122201
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Nov 2020 10:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="4sX5WLB/";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4ubWlI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgKFKBG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:01:06 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42823 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbgKFKBG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 6 Nov 2020 05:01:06 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3052DD4A;
        Fri,  6 Nov 2020 05:01:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 06 Nov 2020 05:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=szcaW1ToeyMxKGu7yk8Mf0GSWRD
        agbG3DtAqq9F1Iyg=; b=4sX5WLB/R+Jl+VsHSdfpSyDxymjmv8bdL79JJAZNVht
        HQq+M4D+pE0srvxQ6ejqsEYWSmB54qFJ1KoTvP4a4SEbDGAZ3r1JjigbbCtKvYNm
        QSH/6k84cWd5fh0aE4jPsy7DGifwvDmn6z2NlyrSbWmJ4Ip3R90avVdAIHXGFi4g
        QZXsE+kJt8kP2nt9yb5QwAQZVEhPNIJMmUtf+bG1W9mSknwr2heFXKd8BNvTjz68
        yOU/K0M5m60rR+TiVYzAtv9ckQ5T4GSkBtPmUF9VGG+UxSq5wGXIXCXwpvFwMUkS
        QWcj1dtGUYBAZcA3t9/1O1DZe6cPYnsd/51sy03B3yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=szcaW1
        ToeyMxKGu7yk8Mf0GSWRDagbG3DtAqq9F1Iyg=; b=X4ubWlI9r+eZZFCf6nLhjz
        hIUmw66Vjl++mvFIGrlZSqlAJRVwxSl9nMzMQupMtGzuDLNji8nPdU/5CEa5Z+bB
        jeobGpIzGUehwzUonWcM/NxA1vMULWSPIf9JU1OxXaUejHvrGlbEdw0RGFOSFtAK
        Dv6yrikobKuBz4mnDacPijIkdyKKuYgtAM8usRT02TTGDvFv9QrZ0XlPQ4GTNv0T
        VKvGp5/p5k3P+VfC91UqQ0IpJy/Ukj1Gmxbv8usZa8+izw2UsrhUWXXAAtXnalu2
        LRNUZ+9bY1ruPsfsRXQnsGrfYZsdkMJMKR7//i6RV0owcOKUEWo5AxSUWNuNYVuw
        ==
X-ME-Sender: <xms:3x6lXxyp-3Y1gKDK8tJCHRSpuu7Vs7pU2dRZg_6N8fYrnTBwlxStMw>
    <xme:3x6lXxRF3DiNf4tnVRXPsulHAHBSbVVTCHysWyeTQYk3Sw34K7tMMx46-hIta3WUf
    hdaNBNznVGY_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:3x6lX7W5qRlyLieuL3Iy97EByRmQm8uJnsEkOx3mHNPdPEQIK8_2jA>
    <xmx:3x6lXzgc3Nde2GU_p__eBXmVUXvZaHtAwBqo4gcdjJrlEBPLZs9sSg>
    <xmx:3x6lXzAY9nkPPem6EBylH9ECjiU26w19DoVSwmcrGA4ZH3gnmWAJ5A>
    <xmx:4B6lX2P7eZ170otgRg7J_fwn8mW2T1jjrrwMXLIruPgPYOs5A7VnIw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59BB53060065;
        Fri,  6 Nov 2020 05:01:03 -0500 (EST)
Date:   Fri, 6 Nov 2020 11:01:49 +0100
From:   Greg KH <greg@kroah.com>
To:     Hassan Shahbazi <hassan.shahbazi@somia.fi>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_watterott: fix usleep_range is
 preferred over udelay
Message-ID: <20201106100149.GA2705820@kroah.com>
References: <20201101002010.278537-1-hassan@ninchat.com>
 <20201101063948.GB432418@kroah.com>
 <20201101103244.GA284952@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101103244.GA284952@ubuntu>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Nov 01, 2020 at 12:32:44PM +0200, Hassan Shahbazi wrote:
> On Sun, Nov 01, 2020 at 07:39:48AM +0100, Greg KH wrote:
> > On Sun, Nov 01, 2020 at 02:20:10AM +0200, Hassan Shahbazi wrote:
> > > Fix the checkpath.pl issue on fb_watterott.c. write_vmem and
> > > write_vmem_8bit functions are within non-atomic context and can
> > > safely use usleep_range.
> > > see Documentation/timers/timers-howto.txt
> > > 
> > > Signed-off-by: Hassan Shahbazi <hassan@ninchat.com>
> > > ---
> > >  drivers/staging/fbtft/fb_watterott.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
> > > index 76b25df376b8..afcc86a17995 100644
> > > --- a/drivers/staging/fbtft/fb_watterott.c
> > > +++ b/drivers/staging/fbtft/fb_watterott.c
> > > @@ -84,7 +84,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
> > >  			par->txbuf.buf, 10 + par->info->fix.line_length);
> > >  		if (ret < 0)
> > >  			return ret;
> > > -		udelay(300);
> > > +		usleep_range(300, 310);
> > >  	}
> > >  
> > >  	return 0;
> > > @@ -124,7 +124,7 @@ static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
> > >  			par->txbuf.buf, 10 + par->info->var.xres);
> > >  		if (ret < 0)
> > >  			return ret;
> > > -		udelay(700);
> > > +		usleep_range(700, 710);
> > 
> > How do you know that these ranges are ok?  Are you able to test these
> > changes with real hardware?
> > 
> > thanks,
> > 
> > greg k-h
> 
> No, I don't have the hardware to test with. I just used the current
> value as the minimum and added an epsilon to it for the maximum
> param.

It's best not to guess about this, sorry, you should have the hardware
to test this type of change.

thanks,

greg k-h
