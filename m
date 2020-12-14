Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD57C4361B
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Dec 2020 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A392222BB
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Dec 2020 14:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408153AbgLNOhR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392859AbgLNOhR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Dec 2020 09:37:17 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B4BC0613D3
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Dec 2020 06:36:36 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id y23so15496823wmi.1
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Dec 2020 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8/m/yG9nmWATf2pwpEbnHeaYaYLTTFSZowBrAhqsvOw=;
        b=NDcqoZd96wzFTaRwe+9H+XLXhCCJcYOv5EVsUhYk8m1j/nS/oVvP7qz4XCpnp4qD41
         i7DlLOUDaoOzBc6o96g2UfD9MjlfuJJUHNAKzjO2xhe/Odg/q7Aj41nKXQmISvvUKny5
         FWc/R+K1Jx/91m6Uxadrnjg6pitrNqb3/rwH+o7d7YST26CoJRSjiTS128/ZCGfl5ri2
         a+YbW0NOvF9bvKzw/d+gBhaOrCX+VwjogxOc+VHEhSvRY6M4yiPIaXrJfAK384VNSuA+
         CTB38q3FNFLC47BbxhAJCQHXre9jd65GZHKhv+DwMJ4tOaJRsbdd+u3umwxmgZQrhOqM
         p5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/m/yG9nmWATf2pwpEbnHeaYaYLTTFSZowBrAhqsvOw=;
        b=D08L8vOAd+MQQvS0hBkfwsNAhYmLZviLeHGQofYrzGlSSaLbyybnnpWmOrheaReIQe
         JANRRhEhmcSTbvm/8noLbmA3Ka4qcMmh0pK1vErIdzDEEmg2tLwgESOCsjlp/Dtcxyqr
         rnxSQUaF8z/If73m5vT79v8AQGODRluVHRzc6EPeHvbXXOKQD5seziurDw3LF+G1GLJ9
         Cg0DNoRQaG9VMiUlltNyBXUTWirwuQnOdjZGb7hA6W52KMLTqDI8B1NzlHQRLV/nWl2W
         i65vjwix08i2CWE4WBedDbRbj8y8dGJH4AsuxOE8f8Dp2KE0ygpt2ebObr1O3jfnedXY
         tGRg==
X-Gm-Message-State: AOAM533ukA++DfEhoyeRN6MGsJFi/UT4l/VlhkzDvCS540QlKtce9i3p
        ccmeXd7lQcYEajf7Eaoz9h25Pg==
X-Google-Smtp-Source: ABdhPJwu+cElapZXFY4A8uSyJOR+TrTmuMMBMIKgd17hiIKGGfvZB23aZNn8UqcZ7iK9v1o9eV2+wA==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr28276897wma.186.1607956595296;
        Mon, 14 Dec 2020 06:36:35 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w189sm19701366wmg.31.2020.12.14.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 06:36:34 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:36:32 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] backlight: sky81452-backlight: convert comma to
 semicolon
Message-ID: <20201214143632.oiqmvpkai7kurc2d@holly.lan>
References: <20201214133458.3729-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214133458.3729-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Dec 14, 2020 at 09:34:58PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Weird! I guess it was harmless but still seriously weird ;-)

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks!


> ---
>  drivers/video/backlight/sky81452-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index 8268ac43d54f..c95e0de7f4e7 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -291,7 +291,7 @@ static int sky81452_bl_probe(struct platform_device *pdev)
>  	}
>  
>  	memset(&props, 0, sizeof(props));
> -	props.max_brightness = SKY81452_MAX_BRIGHTNESS,
> +	props.max_brightness = SKY81452_MAX_BRIGHTNESS;
>  	name = pdata->name ? pdata->name : SKY81452_DEFAULT_NAME;
>  	bd = devm_backlight_device_register(dev, name, dev, regmap,
>  						&sky81452_bl_ops, &props);
> -- 
> 2.22.0
> 
