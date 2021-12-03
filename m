Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967AC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  3 Dec 2021 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381091AbhLCNeV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:34:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41282 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381161AbhLCNeQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 3 Dec 2021 08:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638538253; x=1670074253;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IVzJ6uRZKJICUulg8tUewqaz2kUK3rrMEjcvHyFkaFA=;
  b=ryKk5XllkOAVzx8HRWpybWU8f2RlC4KZ0T5IHrW4XcGMhErT/3PU7Bpu
   G32Wz7f4U15MApDekc0E/rmFB6TdgeU97/ANAslqzdeg1QtD43Bza7nUE
   amyPqe1Yx0qAmTO0Tqw6uSAPnbETgDlJGAf3aH0cTn2EvzoxZoj6hub+h
   QGIjk7X+859+h3wdUd7mutvnL2uJ92ZT5WxD4ui7Ri41Qbk+da5EGaGwy
   py52rczIscHWIlz+svR+dOWYUYi/9lkGtOqb/6vAn6W06iTjnnR460AbE
   bRxZa7/pS5oh9VxZHqLLoC5JOn12zN2wq/8XDc4zAETwBXRzEHWjE1c7G
   g==;
IronPort-SDR: A1LAoFzyfcnhi0uZIwbn8U+XV2yMea2jYd7ocZ8ThxWpi8kmngxwGaYG0KUHzGyJsyzopkIFs9
 xQ/kBAF1rfHSMYIipVk9BWzrbkgjGQlARx/OdUY1Io+Ct9tfdF7hnf+zemINw+Mydn3B1wT6cX
 Vrjocu1ZWVRQMS1pZ53nCtqPQxcYlAYjEX3bSQ1m84Ytnu8CMvaUUbj+j0hNns1qVxS+KK/JS6
 B3XhZIsGmBkHIVQT/Ztc41SDXV9FFEDgNvk8tiFny0RgZ4uB96zOEMNAlNWeiMRiXvf2Z3osr0
 Oz93s+Kg/pE3iZED4OJ8+mm1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="145433415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2021 06:30:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 06:30:51 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 3 Dec 2021 06:30:49 -0700
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: fix an error code in
 atmel_lcdfb_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <kernel-janitors@vger.kernel.org>
References: <20211203095808.GE2480@kili>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <b09117ad-40bb-4abb-1f40-c31c5ca5989b@microchip.com>
Date:   Fri, 3 Dec 2021 14:30:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211203095808.GE2480@kili>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 03/12/2021 at 10:58, Dan Carpenter wrote:
> If "sinfo->config" is not found, then return -ENODEV.  Don't
> return success.
> 
> Fixes: b985172b328a ("video: atmel_lcdfb: add device tree suport")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good to me: thanks Dan!

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   drivers/video/fbdev/atmel_lcdfb.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 355b6120dc4f..1fc8de4ecbeb 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1062,15 +1062,16 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
> 
>          INIT_LIST_HEAD(&info->modelist);
> 
> -       if (pdev->dev.of_node) {
> -               ret = atmel_lcdfb_of_init(sinfo);
> -               if (ret)
> -                       goto free_info;
> -       } else {
> +       if (!pdev->dev.of_node) {
>                  dev_err(dev, "cannot get default configuration\n");
>                  goto free_info;
>          }
> 
> +       ret = atmel_lcdfb_of_init(sinfo);
> +       if (ret)
> +               goto free_info;
> +
> +       ret = -ENODEV;
>          if (!sinfo->config)
>                  goto free_info;
> 
> --
> 2.20.1
> 


-- 
Nicolas Ferre
