Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB8C2B9F4
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Jun 2021 02:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25729613F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Jun 2021 02:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFOChA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:37:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6489 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhFOCg7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Jun 2021 22:36:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3rxp00n6zZhKV;
        Tue, 15 Jun 2021 09:55:41 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:58:36 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:58:35 +0800
Subject: Re: [PATCH -next] video: fbdev: intelfb: Remove set but not used
 variable 'val'
To:     <mbroemme@libmpq.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210527085904.3861173-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <253d3e4d-c843-df88-5299-7b7b3dfd3c5b@huawei.com>
Date:   Tue, 15 Jun 2021 09:58:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210527085904.3861173-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

ping

在 2021/5/27 16:59, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/video/fbdev/intelfb/intelfb_i2c.c: In function 'intelfb_gpio_setscl':
> drivers/video/fbdev/intelfb/intelfb_i2c.c:58:6: warning:
>   variable ‘val’ set but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/intelfb/intelfb_i2c.c: In function 'intelfb_gpio_setsda':
> drivers/video/fbdev/intelfb/intelfb_i2c.c:69:6: warning:
>   variable ‘val’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   drivers/video/fbdev/intelfb/intelfb_i2c.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/intelfb/intelfb_i2c.c b/drivers/video/fbdev/intelfb/intelfb_i2c.c
> index 3300bd31d9d7..4df2f1f8a18e 100644
> --- a/drivers/video/fbdev/intelfb/intelfb_i2c.c
> +++ b/drivers/video/fbdev/intelfb/intelfb_i2c.c
> @@ -55,22 +55,20 @@ static void intelfb_gpio_setscl(void *data, int state)
>   {
>   	struct intelfb_i2c_chan *chan = data;
>   	struct intelfb_info *dinfo = chan->dinfo;
> -	u32 val;
>   
>   	OUTREG(chan->reg, (state ? SCL_VAL_OUT : 0) |
>   	       SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK);
> -	val = INREG(chan->reg);
> +	INREG(chan->reg);
>   }
>   
>   static void intelfb_gpio_setsda(void *data, int state)
>   {
>   	struct intelfb_i2c_chan *chan = data;
>   	struct intelfb_info *dinfo = chan->dinfo;
> -	u32 val;
>   
>   	OUTREG(chan->reg, (state ? SDA_VAL_OUT : 0) |
>   	       SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK);
> -	val = INREG(chan->reg);
> +	INREG(chan->reg);
>   }
>   
>   static int intelfb_gpio_getscl(void *data)
