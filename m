Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E40C433B4
	for <linux-fbdev@archiver.kernel.org>; Sat, 17 Apr 2021 07:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9136610FA
	for <linux-fbdev@archiver.kernel.org>; Sat, 17 Apr 2021 07:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhDQHTP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 17 Apr 2021 03:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhDQHTN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 17 Apr 2021 03:19:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4CC061574;
        Sat, 17 Apr 2021 00:18:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p6so22013282wrn.9;
        Sat, 17 Apr 2021 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzDESpnJwy8q2no0zZGoouoLNqh3tnmLEUrJ5GDonRs=;
        b=rzn2XdwumhMz3IMq2hTIY1ZtnZGekwQClLm2fRy8IPnOaGOBMFLf4aYOib1aCfHeqm
         1pAj2Gfd3TtRiRPgcWseBXWQVukxHfViduJLDUY2KjqKPNO/kTcjm589PqNe36Q7J3Wx
         wSdcPBGkmAPLMio+IZIFMTlN+eMTwScTkIboPUhj4Z7t07X1Hzk2UVN9Rxyjre7SW4lS
         aCsKzSysJz25T1yjzeAhtWKSHeLXUPb3ZSpi8RmzXKnbs56wmKjcw4LwoRe2GuQveYGH
         gte54cDVCR1OMW80mGjUnXdun3ldjiWz/whg8sNaNsGA60mp5GWKKLbfpUqmsd3DxaDT
         J0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzDESpnJwy8q2no0zZGoouoLNqh3tnmLEUrJ5GDonRs=;
        b=WABdsBapF1rDoWqVnFxksnKs2ikYwHqD6coDyF+2fVxJRl8b75/N6l3jVldlfSOoNV
         085R+A9r2ROQBIB2tfFmkzL28uqCO5t61GmFGsjXdjScGYqL4GEg4FlHXyRDELsTeB3h
         yn/2zYjmuvcKP4Wa/g3IoRHGPuc9P2jWCrpjeYVGQwom0t0Zx5UkRdf2VvnVLmFeYYP5
         GtKuRW0X1ROdYzdAP+WVJ+oSY7PqDU+LpyDW/tIjqRNi+Rnv9zTx6J5MLTgqXeu2RuD5
         JscliVz4BDUazR/0pHQ/KR8h6HvC6GfvtCkVB7lbMlukuIB7Fb2gQ5g78ZM7p3+j9vcP
         47Rw==
X-Gm-Message-State: AOAM533Cwg/64lVMU2pySx+AHgAG+DwluId5dPAcjxgVBQsq+gSyY7C0
        ZMtq55tfbdzFdeHih+HlbI4=
X-Google-Smtp-Source: ABdhPJz0+l+y4ld0p2Udvtz/O3KNkgh30U2n0VS6z7cZMwrLx+P+RCwDkaRBydqu+x37EBy5qZLJgw==
X-Received: by 2002:adf:e108:: with SMTP id t8mr2836394wrz.371.1618643924864;
        Sat, 17 Apr 2021 00:18:44 -0700 (PDT)
Received: from agape.jhs ([5.171.80.7])
        by smtp.gmail.com with ESMTPSA id a2sm6954216wmn.48.2021.04.17.00.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 00:18:44 -0700 (PDT)
Date:   Sat, 17 Apr 2021 09:18:41 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/4] fbtft: Replace custom ->reset() with generic one
Message-ID: <20210417071838.GA1401@agape.jhs>
References: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

'staging:' in mail subject is missing...

On Fri, Apr 16, 2021 at 05:20:41PM +0300, Andy Shevchenko wrote:
> The custom ->reset() repeats the generic one, replace it.
> 
> Note, in newer kernels the context of the function is a sleeping one,
> it's fine to switch over to the sleeping functions. Keeping the reset
> line asserted longer than 20 microseconds is also okay, it's an idling
> state of the hardware.
> 
> Fixes: b2ebd4be6fa1 ("staging: fbtft: add fb_agm1264k-fl driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch split from the bigger fix (Greg)
>  drivers/staging/fbtft/fb_agm1264k-fl.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> index eeeeec97ad27..4dfc22d05a40 100644
> --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> @@ -77,19 +77,6 @@ static int init_display(struct fbtft_par *par)
>  	return 0;
>  }
>  
> -static void reset(struct fbtft_par *par)
> -{
> -	if (!par->gpio.reset)
> -		return;
> -
> -	dev_dbg(par->info->device, "%s()\n", __func__);
> -
> -	gpiod_set_value(par->gpio.reset, 0);
> -	udelay(20);
> -	gpiod_set_value(par->gpio.reset, 1);
> -	mdelay(120);
> -}
> -
>  /* Check if all necessary GPIOS defined */
>  static int verify_gpios(struct fbtft_par *par)
>  {
> @@ -439,7 +426,6 @@ static struct fbtft_display display = {
>  		.set_addr_win = set_addr_win,
>  		.verify_gpios = verify_gpios,
>  		.request_gpios_match = request_gpios_match,
> -		.reset = reset,
>  		.write = write,
>  		.write_register = write_reg8_bus8,
>  		.write_vmem = write_vmem,
> -- 
> 2.30.2
> 
> 

thank you,

fabio
