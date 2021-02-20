Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD9FC433DB
	for <linux-fbdev@archiver.kernel.org>; Sat, 20 Feb 2021 23:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A1764E54
	for <linux-fbdev@archiver.kernel.org>; Sat, 20 Feb 2021 23:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBTXd4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 20 Feb 2021 18:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhBTXdr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 20 Feb 2021 18:33:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404FC061574;
        Sat, 20 Feb 2021 15:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=oMktDWRKXyoBFa7CtiuawGTrjQqJNKUNw1j4Qpf7tLQ=; b=KrW9CdHrNeeaD0CH7+mhlWCYHf
        RHtbrBLi0NpdCZ2uUDqeblPvzZRxHCqjFKNewXGfpM8R0LeLCpyE9TmWC/JQKSNBSpVkfJVSr1pMz
        lsPGkv7QyPeM/Ifw/KmCpTeEpm7Dghjp1WutT+ILL0nWyPHqfo+wi2y20Gem3JQw28PbjaGsArQ04
        bjO2BYQvTKeOFNofeJnFSd3zpXYL2WdvJkQqBcn30ez9HWB3ySBOZn91kklXWCSFlR4V3glxiNl5Y
        nrzLiOhKczeLrtf3xnwcu+T3UEQa93XKNot2+DY0iUjxaEPZkhGTA13BQl9Ka9xK8oOM2jUPx+UQ5
        HinEZHog==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDbkE-0004ZU-3j; Sat, 20 Feb 2021 23:33:02 +0000
Subject: Re: [PATCH] video: fbdev: pm2fb: avoid stall on fb_sync
To:     Tong Zhang <ztong0001@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210220230248.320870-1-ztong0001@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ea1c5ff3-0b24-71c9-7a44-08b184c4854d@infradead.org>
Date:   Sat, 20 Feb 2021 15:32:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210220230248.320870-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi--

On 2/20/21 3:02 PM, Tong Zhang wrote:
> pm2fb_sync is called when doing /dev/fb read or write.
> The original pm2fb_sync wait indefinitely on hardware flags which can
> possibly stall kernel and make everything unresponsive.
> Instead of waiting indefinitely, we can timeout to give user a chance to
> get back control.

Is this a real problem or theoretical?
Does someone still use this driver?


> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/video/fbdev/pm2fb.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
> index 27893fa139b0..8578c64a0c54 100644
> --- a/drivers/video/fbdev/pm2fb.c
> +++ b/drivers/video/fbdev/pm2fb.c
> @@ -183,12 +183,23 @@ static inline void pm2v_RDAC_WR(struct pm2fb_par *p, s32 idx, u32 v)
>  
>  #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
>  #define WAIT_FIFO(p, a)
> +#define WAIT_FIFO_TIMEOUT(p, a) (0)
>  #else
>  static inline void WAIT_FIFO(struct pm2fb_par *p, u32 a)
>  {
>  	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a)
>  		cpu_relax();
>  }
> +static int inline void WAIT_FIFO_TIMEOUT(struct pm2fb_par *p, u32 a)

drop      void       ^^^
It's already "int".
Did you compile this?

> +{
> +	int timeout = 10000;
> +	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a) {
> +		cpu_relax();
> +		if (--timeout==0)

spaces around ==

> +			return 1;
> +	}
> +	return 0;
> +}
>  #endif
>  
>  /*
> @@ -1031,15 +1042,27 @@ static int pm2fb_blank(int blank_mode, struct fb_info *info)
>  static int pm2fb_sync(struct fb_info *info)
>  {
>  	struct pm2fb_par *par = info->par;
> +	int timeout_sync = 10000;
> +	int timeout_fifo;
>  
> -	WAIT_FIFO(par, 1);
> +	if (WAIT_FIFO_TIMEOUT(par, 1))
> +		goto end;
>  	pm2_WR(par, PM2R_SYNC, 0);
>  	mb();
>  	do {
> -		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0)
> +		timeout_fifo = 10000;
> +		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0) {
>  			cpu_relax();
> -	} while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
> +			if (--timeout_fifo==0)

spaces around ==

> +				goto end;
> +		}
> +		if (pm2_RD(par, PM2R_OUT_FIFO) == PM2TAG(PM2R_SYNC))
> +			break;
> +	} while (--timeout_sync>0);

spaces around >

>  
> +end:
> +	if ((!timeout_sync) || (!timeout_fifo))
> +		printk_ratelimited(KERN_WARNING "pm2fb: sync timeout!\n");
>  	return 0;
>  }
>  
> 


thanks.
-- 
~Randy
