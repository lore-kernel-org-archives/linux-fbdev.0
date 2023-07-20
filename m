Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972CDEB64DA
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 Jul 2023 05:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGTFyX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 20 Jul 2023 01:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGTFyW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 20 Jul 2023 01:54:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBACC92
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 22:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689832440; x=1690437240; i=deller@gmx.de;
 bh=AvQNFEONT4fShfNrurkw1pgA7akClloidKtqIx3Adr4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=UN7ztb6CjF5S7nn5QyxwWPT7vv6BQsns8/sCRU3JVzOaJ8Qy+UHmtPy5/DZyaSIW4s/NJQk
 e5FkiajNw/U9wbeLAeaw8P10zoS9TndtMUVNLOqv5XW2sx9YNtYQ4qhxoWvsh7oR2fUHdbftS
 PiK0wdqc7mdJtmb66Az5OjFyb7z+67bM0RtXJMjQxLtSvKrjLJwiqff71PjujYxWJUOeYuKWH
 9rMb6WEdY9GH6G85rMuCDvY+jXYoACNIm9NF6xfFnrIz2jKEQoxevb110DrrhjXJCIt1yXt5N
 uso7JVT7ywvCmLJSTfcuSdGdBY5OIvNe2Uj5PlPsOOwcEd5tDH7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.9]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1qcVU31rUx-00KhLV; Thu, 20
 Jul 2023 07:54:00 +0200
Message-ID: <802fdabc-dac5-8fc2-a39d-cba833b10439@gmx.de>
Date:   Thu, 20 Jul 2023 07:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] drivers:video: fix return value check in
 ep93xxfb_probe
Content-Language: en-US
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fbdev@vger.kernel.org
References: <20230717144809.24895-1-ruc_gongyuanjun@163.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230717144809.24895-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Y8Hd8CEWoINVS/z0zJqGThiC9VIaRAEsjfY3oTBunvWinu/T0H
 gEUPcsZKrgaCTapynfxS3MlXNSrQiy3g9d+y7eVxoaoK7i8rsBSNe2PGbEIY28Kzdref0bm
 swxHMuZpkGhdEnorpV+dau9YWPe/CYHcnUaX84tL2ymxTULBkKZR72kcC6YGpDHr2+cimX9
 hkqdc5bjcAsTff0AimwoQ==
UI-OutboundReport: notjunk:1;M01:P0:edAQC44nC8g=;4gRDMwQTvFsiPA0ZQ/ilWY763Jy
 BFG2LgzOW1Snq3W7p774iR1/uJvnaxIwUlec8gCm6ILzmMsueLDQGFDHgPQ/wJ02Viwz8exfe
 NyM/8zZJa+VNl8FuzoWvNzqdGrS+TlM7L4znyipJrlrs1Pgnh0OPfgKGb4CzQZJXwg43rzcZQ
 t2ePMx5Hgsczt5l3wva5kI+dSHKVZbthIplhsa2eyM4wqE74zZriR78Qko1MQtW263rpgWvCN
 XWfAzEI4/hntl93a8NXw8h0Zt63JtTyjs+9Edg05hm3cNIMtXC28o6r0HXHa85VUnCLWF3Lh6
 7oHUjNqMfHltfFaB8wF0hZDT/ZmHH2YehGA/ZVNB9jalWc0mDFMJu5q6emfgfdPWoOwBCOeeA
 Tw8ODPI6lO2W7T1A/dzdJjoVsiUKvnEEj6XMLs8af+vredv22kP5I/nsSZ//qA9ZmT6vzTJGv
 FLbc0oU4CIhremdazlR8hw7Obolr+q87A1lB/G9mlWNRSa4md8/mBLDfY9sKq6PgvDpra+O5b
 DgtyL0xVKiwXwz6KNzt6TlocAjdwtEGSaboYWSRuI7EJOypyr/1D8esvrNi1aRtmPmWkY8y67
 MK19QR0d1gNuY2J0bqG+0/L3lledg499cWjRsaNUqD7nanOloFFeBCTctA1oukO9b9zzv9G3l
 bb82IeX82LTfcU/TbixMhBvwtvUXmTz34S9E9CdpAShn2Eaikl9m1Zbi/N7HBlyPJQTI6gxrR
 xK6iYFKfWfRqvGLgPzGn2MawOlQGBij9tqNWe6nma6iLZ0mEdUZaMDCrBsLo4zW6huG4A4w+W
 h8WNU7qTYeCAHLAgYVpeYADJ6TFo2fh+4NV/B7/iu5aV5heOFEkt1elxMTwd/gvXJtGrgJNC5
 zsJEumIfhJe3L7kC8IwQEup/oH2SyrELamcEdzamUINgINmNqXuBZYOCbe2ADpTjPBuvq5Z2Q
 g0k2hg==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/17/23 16:48, Yuanjun Gong wrote:
> function clk_prepare_enable may fail in ep93xxfb_probe, therefore,
> add a return value check to clk_prepare_enable and handle the
> error.
>
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

applied.
Thanks!
Helge

> ---
>   drivers/video/fbdev/ep93xx-fb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93x=
x-fb.c
> index 94fe52928be2..22158d9ca8dd 100644
> --- a/drivers/video/fbdev/ep93xx-fb.c
> +++ b/drivers/video/fbdev/ep93xx-fb.c
> @@ -548,7 +548,9 @@ static int ep93xxfb_probe(struct platform_device *pd=
ev)
>   	}
>
>   	ep93xxfb_set_par(info);
> -	clk_prepare_enable(fbi->clk);
> +	err =3D clk_prepare_enable(fbi->clk);
> +	if (err)
> +		goto failed_check;
>
>   	err =3D register_framebuffer(info);
>   	if (err)

