Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F28C433E6
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Jan 2021 10:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497AF221F9
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Jan 2021 10:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbhADKr0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Jan 2021 05:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbhADKrZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Jan 2021 05:47:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB24C061793
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Jan 2021 02:46:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d26so31629919wrb.12
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Jan 2021 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5cnKwGKMAW2uD7Mf320R7/SnXF3WX1LG6Qh3O1drZ/Q=;
        b=hmCCGppBxS67+7BXqQG7Lw+tVho3R1OcBqp3hz5toxuy0QJeDKHzxhOHn/OPB9LuaB
         TyRcrHvXbhdEl/+7VTeQDe1BX1fDZqTBfmYqeTSRNKfY8Iel4EnMnLHyDDkN8fNQTZtv
         qoS7n7uPI/VlCfls/vUHdmk8+niCQIE8MyIRw9AQTPN4XlxsFdX3SEVmmoWUZ6B2JsXX
         oPUpO1OI7PdcZphmKDlODxsyJmOXS6kmQx8Un4U4NBdwvlb7DtInP/gWNfpmZ3GTCCyu
         yR1UNiR2nUC8UDLCULzVX+XQX/zN9uGPjEAuBM07HcHQbZ/gd9AtQbYGnTUXxCHq7nqR
         zvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5cnKwGKMAW2uD7Mf320R7/SnXF3WX1LG6Qh3O1drZ/Q=;
        b=YtcDzXlfTU46ZTunMjoEX3wqcijZ31sSuS/3EIIS2ZX6RGB+rBr9SrlToaiAVloTFA
         3UkIng4il56Vt+xtsaKMoeDx25vhdrdBInXFdx2IuYIJ4h8/DHIeeeNwpKdhb10dlb4z
         1UzmLq7Z3E8JA9soMsvtuMnOV2eIdy5oDpW903p2YwxaLPdikJkIT/r9xi3ldRTVhBXY
         g8Iuxi3XHuexdj2KOtCsh52aCtobjPO+Ayq7OF+SF8aan8dUhb0CQ1oUBag71cwwZKto
         DTekKhmW0r5SsdwEk7K/1bB/q7IDoTmK2TO3fTVq7Yu3BC+Ihwg5jtnV0xtZz2khffMe
         TvTA==
X-Gm-Message-State: AOAM531nfwsq01YX59nGsqw/GXecRF9MmSA+UCSXF5B0Gl81uTX2x75h
        Pmdhp2WBINOJTFExp611IU4y/w==
X-Google-Smtp-Source: ABdhPJxLg9y2ii+HtYdwO5mHHkoRyLpzpRo5RBXbyYGGjZWmmsW9YQQWIhm9fV2y95zhm1wlI5iR0Q==
X-Received: by 2002:adf:e452:: with SMTP id t18mr76358986wrm.177.1609757203325;
        Mon, 04 Jan 2021 02:46:43 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o23sm95805633wro.57.2021.01.04.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 02:46:42 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:46:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] video: backlight: use DEFINE_MUTEX() for mutex
 lock
Message-ID: <20210104104640.2fe5lmi6hljb6rgr@holly.lan>
References: <20201224132601.31791-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132601.31791-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Dec 24, 2020 at 09:26:01PM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/video/backlight/backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 537fe1b376ad..d7a09c422547 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -64,7 +64,7 @@
>   */
>  
>  static struct list_head backlight_dev_list;
> -static struct mutex backlight_dev_list_mutex;
> +static DEFINE_MUTEX(backlight_dev_list_mutex);
>  static struct blocking_notifier_head backlight_notifier;

Why do we want to convert one of these variables to use a
static initializers but leave the other two unchanged? Surely they
should all be changed.


Daniel.


>  
>  static const char *const backlight_types[] = {
> @@ -757,7 +757,6 @@ static int __init backlight_class_init(void)
>  	backlight_class->dev_groups = bl_device_groups;
>  	backlight_class->pm = &backlight_class_dev_pm_ops;
>  	INIT_LIST_HEAD(&backlight_dev_list);
> -	mutex_init(&backlight_dev_list_mutex);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
>  
>  	return 0;
> -- 
> 2.22.0
> 
