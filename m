Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576DC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 Oct 2022 06:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJRGJA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJRGI7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 Oct 2022 02:08:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A95A4BA9
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Oct 2022 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666073330;
        bh=kESqtXRRLcVqNo+uVmQLLpTxRxMPzv6uWD15sm1Lquk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NfctetePm1dWzQS19zXlMfOLD7wurb1stLyzDgepWVy1cx+a+bQ9cy+aY+epVVwyh
         BsH9iwtpZJ1UBFqu9of4edHPUm0g+xkxr7vWYywZ0zoS1W4Y26AnAKg1VAFEJ1MX+8
         ElBpFpcJqxvPnxwBevFPxMPtDh+HF0rIYElfbjpw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.165.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1pI5n93K1J-00bsB0; Tue, 18
 Oct 2022 08:08:50 +0200
Message-ID: <7469c557-388a-4917-9810-90b1f341292d@gmx.de>
Date:   Tue, 18 Oct 2022 08:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] fbdev: da8xx-fb: Fix error handling in .remove()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de
References: <20221017195250.1425468-1-u.kleine-koenig@pengutronix.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221017195250.1425468-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:awWZJPGvbqmW8/zqxT1e/WMPKkQZeF2h6tWQtRUO7dczClotkl5
 MnZ7O5Isw78FqYYQXNpcK5vXD6K1DmCcIYX/zicwzwgunacxdYbhpmqmU1BNFrHZZp+Zt3M
 xY5K2CXtlQMtAOCW2BjnkuVzGkcF0jpAgHuoZO6FXvrgCDJWb+kJcWbL7BihUdIwHLjR2LX
 F30CvV3bjcNOYzyeTZbog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HOSt11eqSig=:1PBJ68qkJk1Qiwx2M0Ys6X
 /plPFTlmdeAvDGxN5O9rB58BtsH4p2mIM5lRrnDG9si5OB9ZsPgMpY+CoQ/I4G0fjhJug8tre
 UuTIGAP0hIN51xk2oTnTiXTOIgu2/F8MHOWXGIHJPfRlmpira5AVr4FnOUE0Fox1WFgHVbZee
 D6K18al1m+5vNeR9XdZzCrAhSbL6jhHaihueMbyC+oruLPaBqZeae7TLdhF5s3Fznyehc6uij
 r/zUdrnOfMeHCa6WDzkPS5ZBVnPekCT2qcNu5JN/GklcOCWAOSxDtXTGDvXs6CMUa2dmvwEyq
 9JdCuixu759BvpreUnrPk3zZ16j271yktQ82ESFuTCjGHK0mcPjphOZf0QQRsezzqd1QqMesK
 f8jFXLJPmhV+y8dk1PloNBeDwE5cAde3MqmcdbMc5U9IdP+RZ9hlcULrC407UFYR6CATV9L2q
 H7sGvrFT7FhTWIKvln3cEhMUtEfUwWj3FUVDnphesixhatcZrT8RGpmD7w90L5YZXjvIye8R0
 rEDIRkgXw5k7+b/j3eTzyYaMM/Ro+qiF8CQGMEnpaOhl3/G5zGbJmc+gxbMSEgkyqVU1gcbSK
 IjQGmy1LVkPdOtguYD7jPL/z6uGmeEW1wtLTGnXcIwLYfT6arQcV0IDClgOXT2CFpSnVYL7l7
 YzTpRApvebLhPOxhglfHiZMfSw1+3ozcBYWQaZc6lOF33jUMuVZ3aqwIdDiqUfPAjq7ow+B1O
 OC8B5DpSqQcEkTmSWdJCMAR6IgmZ3n/pxcl3bqkjD2+Nliznt6zrm6YoYWOS/63OMyyhYa1eW
 +SBSEYHaVthIw9JPWLv05/GOva2Ucs7d/9ZksX8fMyUnxS4izVN3aCbLmaDrpXofPh9bX/mzy
 F5z24TVQYTOZHHyYqpZCTosQk393x206YXD2NXQStRZD7NsEvzHpBAFdTqQvBwSWx4b6iTHsE
 UyCfE3vgF5J34XH/zXtnn4Unhbpl5jYUxTYnHLqWDbZoadLVqlfz12GXgycO8LXLaBHKJQ3Nj
 9N0EQOAIu4zeHRvb3A/v56aWnB5H3/hF27BkQr34nuPdE+Pl7iwTudsjtP+h8sHKdrvWA674J
 Vv/Iza+1F8BG5oDFw+LrY03vi46kbswDEyjHTGkj++VtI2yOFBhk5H63YCZoNIPsmhuSn8FTU
 T9Vj2fSnOejwf3UDyotcC0KpZ0eWWjuvrwBZCWhLWkFxH4EGN667kNkmZfXCCd3BbNwjzVgiJ
 2wkpz0USlulXUCuTlBkcZ365eaem8ukA7BkSKYTuxR/6bJ4lwxpv3LUcGRK4mOWH8MRC1bzvy
 pLDkFSAPdYDygLNyMujELA68aBcQzV09LIr0zXLpQoFi88y42iC9yXZTU1WdZQNv3SGLDq0TN
 gO0I+xE/9fWRx8N3dw3VQA4QnORmu60ZjyFtgu2un7nHOjgOHjlHjppxqpDhbE2KkI2gWLRnP
 6qpykmijOH/qdxbydQQA+IHbNr9OtDqG0Pde8KSJ0dpcIBGzwaN3HsRKdjHQNt6jW5cHoYa2S
 K5WQUMkD6uXwI9edKEm+SUor/WsoI5J2qkN/XdTwuIMjp
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 10/17/22 21:52, Uwe Kleine-K=C3=B6nig wrote:
> Even in the presence of problems (here: regulator_disable() might fail),
> it's important to unregister all resources acquired during .probe() and
> disable the device (i.e. DMA activity) because even if .remove() returns
> an error code, the device is removed and the .remove() callback is never
> called again later to catch up.
>
> This is a preparation for making platform remove callbacks return void.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/da8xx-fb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-=
fb.c
> index ae76a2111c77..11922b009ed7 100644
> --- a/drivers/video/fbdev/da8xx-fb.c
> +++ b/drivers/video/fbdev/da8xx-fb.c
> @@ -1076,7 +1076,8 @@ static int fb_remove(struct platform_device *dev)
>   	if (par->lcd_supply) {
>   		ret =3D regulator_disable(par->lcd_supply);
>   		if (ret)
> -			return ret;
> +			dev_warn(&dev->dev, "Failed to disable regulator (%pe)\n",
> +				 ERR_PTR(ret));
>   	}
>
>   	lcd_disable_raster(DA8XX_FRAME_WAIT);
>
> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f

