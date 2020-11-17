Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8135DC5519F
	for <linux-fbdev@archiver.kernel.org>; Tue, 17 Nov 2020 07:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29460223AB
	for <linux-fbdev@archiver.kernel.org>; Tue, 17 Nov 2020 07:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKQHl1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 17 Nov 2020 02:41:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQHl1 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 17 Nov 2020 02:41:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 068ACAC23;
        Tue, 17 Nov 2020 07:41:26 +0000 (UTC)
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: fixe return error code in
 atmel_lcdfb_of_init()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com
References: <20201117061350.3453742-1-yangyingliang@huawei.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <314d2531-5d9c-fa9d-82cd-cf0a35488a38@suse.de>
Date:   Tue, 17 Nov 2020 08:41:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117061350.3453742-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi

Am 17.11.20 um 07:13 schrieb Yang Yingliang:
> If devm_kzalloc() failed after first time, atmel_lcdfb_of_init()
> cann't return -ENOMEM, fix this by putting the error code in loop.
> 
> Fixes: b985172b328a ("video: atmel_lcdfb: add device tree suport")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 8c1d47e52b1a..355b6120dc4f 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -987,8 +987,8 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  	}
>  
>  	INIT_LIST_HEAD(&pdata->pwr_gpios);
> -	ret = -ENOMEM;
>  	for (i = 0; i < gpiod_count(dev, "atmel,power-control"); i++) {
> +		ret = -ENOMEM;

I think that a better fix would have been to put it into the alloc's
error branch. But anyway

  Reviewed-by: Thomas Zimmermann <tzimmremann@suse.de>

Thanks for your patch. I'll add it to drm-misc-next.

Best regards
Thomas

>  		gpiod = devm_gpiod_get_index(dev, "atmel,power-control",
>  					     i, GPIOD_ASIS);
>  		if (IS_ERR(gpiod))
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
