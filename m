Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51D4C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 May 2021 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9684C613EC
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 May 2021 07:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhEGHMW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 May 2021 03:12:22 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:39244 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhEGHMV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 May 2021 03:12:21 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d51 with ME
        id 1jBK2500L21Fzsu03jBKw6; Fri, 07 May 2021 09:11:21 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 May 2021 09:11:21 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] video: fbdev: imxfb: Fix an error message
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, shawnguo@kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, j.beisert@pengutronix.de,
        krzysztof.h1@poczta.fm, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <d7b25026f82659da3c6f7159eea480faa9d738be.1620327302.git.christophe.jaillet@wanadoo.fr>
 <20210507050503.iwrcis2xzhjjthmp@pengutronix.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <5cd9c8de-acd9-9594-38a0-62ecf5734c10@wanadoo.fr>
Date:   Fri, 7 May 2021 09:11:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210507050503.iwrcis2xzhjjthmp@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Le 07/05/2021 à 07:05, Uwe Kleine-König a écrit :
> Hello Christophe,
> 
> On Thu, May 06, 2021 at 08:57:05PM +0200, Christophe JAILLET wrote:
>> 'ret' is known to be 0 here.
>> No error code is available, so just remove it from the error message.
>>
>> Fixes: 72330b0eeefc ("i.MX Framebuffer: Use readl/writel instead of direct pointer deref")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/video/fbdev/imxfb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
>> index 7f8debd2da06..ad598257ab38 100644
>> --- a/drivers/video/fbdev/imxfb.c
>> +++ b/drivers/video/fbdev/imxfb.c
>> @@ -992,7 +992,7 @@ static int imxfb_probe(struct platform_device *pdev)
>>   	info->screen_buffer = dma_alloc_wc(&pdev->dev, fbi->map_size,
>>   					   &fbi->map_dma, GFP_KERNEL);
>>   	if (!info->screen_buffer) {
>> -		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
>> +		dev_err(&pdev->dev, "Failed to allocate video RAM\n");
>>   		ret = -ENOMEM;
>>   		goto failed_map;
>>   	}
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Are you using this driver, or did you find that problem using some
> static checker?
> 

No, I'm not using this driver AFAIK.

It has been spotted by coccinelle with a hand-made script which tries to 
find places where error code is used before being initialized.

The script in it-self is not really interesting. It is easy to write and 
my own version trigger way to much false positives.

CJ

> Best regards
> Uwe
> 

