Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A11BC433E0
	for <linux-fbdev@archiver.kernel.org>; Tue, 29 Dec 2020 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0B6206DC
	for <linux-fbdev@archiver.kernel.org>; Tue, 29 Dec 2020 13:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgL2NED (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 29 Dec 2020 08:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725964AbgL2NEC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 29 Dec 2020 08:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609246955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vvm5MmduYfq+CeOMpnUQJhTQ4fWwSPJm0vCOaVoEwcg=;
        b=gXklRM9V0OEbtV9dbs87F/+KG39aRv1OzJn90zbooNMrI8rxsr4KUgQAzorYAzC2z6uq2q
        C0fH4nH88DSRdTFV35xuhVt5uCbjROuV21yDG8ONS6TIhu+lm0l6ta5IsocqqrPQ8j6VoD
        1ukCGBvYWFnBXSsZ7F0ZAabhrCzyL0U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-oWcrOnFgOBWs26PCUlpbFg-1; Tue, 29 Dec 2020 08:02:33 -0500
X-MC-Unique: oWcrOnFgOBWs26PCUlpbFg-1
Received: by mail-ej1-f71.google.com with SMTP id h17so4862769ejk.21
        for <linux-fbdev@vger.kernel.org>; Tue, 29 Dec 2020 05:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vvm5MmduYfq+CeOMpnUQJhTQ4fWwSPJm0vCOaVoEwcg=;
        b=q7UT+NzaIiGvoTkv+1GGPoHAxcacVlcdy7MJ5qts/TV6u8ScVyPJbt48YtBY+LnnZE
         7aOjcSorYIl6hRMPM8IddT0K9pCqnuitSedbE/cKqU9Yx7H/e4d4ClOS3sPK3dabY7jP
         E/KufW3PocmxyoJPOpmWlEBmn7Ui6gqwctn4xbKtxgZNpSPU9ccn7ssaX5kmXvCKxSZn
         H4YcYsJtNqw0luv89OvdqbQI/PYPHU9v09UhM56pXY1BUBoo0O+RbWY6kmcrJBxc9uol
         Ye60zok5ykWuNYLLGDUlF5iI8q3ly97a7n24yGXfyY7pif60HEe6x5DLDjiR4pebvcKg
         eYSg==
X-Gm-Message-State: AOAM533hDJsvyylnZNv/Wnk8B7h4H+NhzC4atUDQ0a/QHt9Bcl+bt3/L
        eZGUl9sTeFXadmmaDLvUSxW63TcJZqe25rTpaw3PeFBM6Urpe1DbTQ2ZE+1zrvGYo4VtzyL6fmo
        Rin5wOxrS6OZUvOP4N8NdCeQ=
X-Received: by 2002:a17:906:c2ca:: with SMTP id ch10mr38660489ejb.157.1609246952447;
        Tue, 29 Dec 2020 05:02:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZe+0PeumBo8opCh97Rc3CfxyGDfiSwAPK8JsBsk+c68ZL8v4jfHfLK2RtzlmhXt25G45uUQ==
X-Received: by 2002:a17:906:c2ca:: with SMTP id ch10mr38660475ejb.157.1609246952314;
        Tue, 29 Dec 2020 05:02:32 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id bm12sm4815794ejb.117.2020.12.29.05.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 05:02:31 -0800 (PST)
Subject: Re: [PATCH] video: fbdev: simplefb: Fix info message during probe
To:     Peter Robinson <pbrobinson@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20201228183934.1117012-1-pbrobinson@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b00bd27c-70b5-9ef1-85a1-11e733af78da@redhat.com>
Date:   Tue, 29 Dec 2020 14:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201228183934.1117012-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 12/28/20 7:39 PM, Peter Robinson wrote:
> The info message was showing the mapped address for the framebuffer. To avoid
> security problems, all virtual addresses are converted to __ptrval__, so
> the message has pointless information:
> 
> simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes, mapped to 0x(____ptrval____)
> 
> Drop the extraneous bits to clean up the message:
> 
> simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/video/fbdev/simplefb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 533a047d07a2..62f0ded70681 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -477,9 +477,8 @@ static int simplefb_probe(struct platform_device *pdev)
>  	simplefb_clocks_enable(par, pdev);
>  	simplefb_regulators_enable(par, pdev);
>  
> -	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
> -			     info->fix.smem_start, info->fix.smem_len,
> -			     info->screen_base);
> +	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes\n",
> +			     info->fix.smem_start, info->fix.smem_len);
>  	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
>  			     params.format->name,
>  			     info->var.xres, info->var.yres,
> 

