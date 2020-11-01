Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E979AC2D0A3
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 06:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A5F2222F
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 06:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qi/OP1CX";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMHJDuYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgKAGjy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 01:39:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50417 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgKAGjy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 1 Nov 2020 01:39:54 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 657205C00D2;
        Sun,  1 Nov 2020 01:39:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 01 Nov 2020 01:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7Zy0X9cj7Iuwxadae5N9eX4bb1H
        i9Y8mnSqXOcU/JUk=; b=qi/OP1CXEcnqt48j+cMmSklPmbsXQ9Lc+7KQ3yaLluh
        z95VcVTsbXMgDCMF1pGz5nQPEyD5x21tsHMaQwv+FkHySGW9mOd0HH5zUwqpxG1N
        GXs6LVzjpwFPrQ2KuFYoW0AjYsQvC6H4cLoAasNGBsjPOJ73IY6cDUNYRMyAP46x
        feJcnPf9krddAndxwAWzabn1pgoQbf5K2dkurDxy8qlewPT/ebvM62KdN+ot+N1H
        whVo0ipOsTchQWXgLOdQAvFt/U55TGunAYfixVUvxHXGhpoQhUvDViQR8Zc9mM0M
        g7giKmjjoe+fb5GaMbuBw0ssMrMfdgTbHrX8GR6+b2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7Zy0X9
        cj7Iuwxadae5N9eX4bb1Hi9Y8mnSqXOcU/JUk=; b=oMHJDuYDI618yXvuYWeUbh
        NRSpJm/JZTExp8Ldc9f1DVK54AGxsPN5OR8gykt3GO64tCw7U4QapbRAK9g6FZHv
        J7SoS75pWkdy4tVJg7Nb/eoCErPhoZI6Ix4FXJI+lxi3+yPWgswl5/1X6BccYRzq
        RuTtzfh8LF22peFtiig86cVrB2W0bTh1MbfmXZUa/RcnYlWvG9j++YkI7vgWpOWw
        FneXFITo5bPzd/hRFDIiNNF2+UcjfFJLgMTBw9/rzjltnnYCJPGrPkbhXAbOxCYa
        J1t2dGx2mMysK6NVEd9iaadPNxJyusi+lJ2K2IvImc60XIKnwJihxthFuaTZZWZQ
        ==
X-ME-Sender: <xms:NlieX_pLMI9e84s7pWZYL6oQxr77CJ22cOyr3tFp9A8u-J83lC54fw>
    <xme:NlieX5oRQXoEtVdaBLXff3hewe8gcyidDe00V8CLGP_03ITcpdO8StBS42t2zFogG
    uV2YwT1gr54Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleekgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:NlieX8My3UDK1FU4lESxjYtH74C_B9C2Fqw20PzJRIdl0zo5qALhuw>
    <xmx:NlieXy47cYTTolVAmk8P28r46e-HN-CI-P-wuwzmQU_HY09BVGnsFg>
    <xmx:NlieX-5KDc5UkSqK3AbTH0cInFmtBjKDhr9xbbrIVBJigQXJyLprQg>
    <xmx:OVieX52WP77hziVEKRQYWkOGSx3H-eYTp1l2y_OlDxBLb5sUkTPG2w>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 441463064680;
        Sun,  1 Nov 2020 01:39:50 -0500 (EST)
Date:   Sun, 1 Nov 2020 07:39:48 +0100
From:   Greg KH <greg@kroah.com>
To:     Hassan Shahbazi <hassan.shahbazi@somia.fi>
Cc:     linus.walleij@linaro.org, devel@driverdev.osuosl.org,
        Hassan Shahbazi <hassan@ninchat.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: fbtft: fb_watterott: fix usleep_range is
 preferred over udelay
Message-ID: <20201101063948.GB432418@kroah.com>
References: <20201101002010.278537-1-hassan@ninchat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101002010.278537-1-hassan@ninchat.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Nov 01, 2020 at 02:20:10AM +0200, Hassan Shahbazi wrote:
> Fix the checkpath.pl issue on fb_watterott.c. write_vmem and
> write_vmem_8bit functions are within non-atomic context and can
> safely use usleep_range.
> see Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Hassan Shahbazi <hassan@ninchat.com>
> ---
>  drivers/staging/fbtft/fb_watterott.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
> index 76b25df376b8..afcc86a17995 100644
> --- a/drivers/staging/fbtft/fb_watterott.c
> +++ b/drivers/staging/fbtft/fb_watterott.c
> @@ -84,7 +84,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
>  			par->txbuf.buf, 10 + par->info->fix.line_length);
>  		if (ret < 0)
>  			return ret;
> -		udelay(300);
> +		usleep_range(300, 310);
>  	}
>  
>  	return 0;
> @@ -124,7 +124,7 @@ static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
>  			par->txbuf.buf, 10 + par->info->var.xres);
>  		if (ret < 0)
>  			return ret;
> -		udelay(700);
> +		usleep_range(700, 710);

How do you know that these ranges are ok?  Are you able to test these
changes with real hardware?

thanks,

greg k-h
