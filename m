Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A429C433E0
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Jan 2021 10:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4978320780
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Jan 2021 10:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbhADKIl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Jan 2021 05:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhADKIk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Jan 2021 05:08:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0EC061794
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Jan 2021 02:08:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c124so17907716wma.5
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Jan 2021 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=miG7CO4g5j20n9mrQMJx+RS21ZtCLqOgtOcLQw9KSDs=;
        b=Lg7fUwr3AMMbu21IW1G8pugaRA5SNCJaW71dzVrsNi0eLfCFI6DLso9TPduv3Fwl+d
         F8LBc9rpDsiZlgcDymsDqFXHeGQ9r79AQg0D8eJtYMk+fRn4gqtUSNEW4zSUb4/s4UjB
         orcsSCCOenu3XQzjy1ErOHJIZAOdGEJ0t7uSFKz65w56ete2sthEifuLASHttKbuRRma
         paMnaDaig0mM0Qmd536zabVBAHcl9UN2JmSKpMU5UGtvh/aQGTcL7X24uRO6mYjwJdwW
         LQwH9V1M3c7Ky/qU9v0QCX1PAOJPuRZolAzh7zseO9iVcUu0SIVFcSPqQsWkkpbxubSu
         Rzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=miG7CO4g5j20n9mrQMJx+RS21ZtCLqOgtOcLQw9KSDs=;
        b=sxCMylHI4oym6u/cdXY3pnrMf3x71uhaOKGrFlrFq+krjH+lZjFXHdxv3jJAP0bPcm
         CcXb5w5lr7b/3DN8iTbzPhGUjhVGOYufYrKLNLTDH7PBteDS26/4mXfKIoHcNFtqSvgR
         J0Mx6PGI2iY2Vqy1q48XoZGYqRkckXv+Rps4peCIU1LhVk3vyi0N8GbiGonsA4Ocfjf3
         IgdY40vLgbpfKphy49NrBEz7qNbBc7gmkgzxNzlhh6dOgrfZro2eWw8+f21S/wAIQfSj
         5ROyKqo7LpPZDS6n/YTUsbSCa5drLxvaQTXxx2PDUzsbBVtfJZd6BMRtAk0Pkc/Pwt6p
         acOw==
X-Gm-Message-State: AOAM531IEG8EaX7qY+BUqRyI8fWP+fC2UbRmexqM5KZnZ3O/yzi5icVv
        7KKsiy7/lUudYJVqeOjDPCDJwA==
X-Google-Smtp-Source: ABdhPJzf1aX815VmR6wjjt7zvuM5RGyRKlwUh6d84TKCy6s8zu4m42oY9tKbexlZo9VISvD5GidvuQ==
X-Received: by 2002:a1c:7d58:: with SMTP id y85mr26041528wmc.50.1609754878758;
        Mon, 04 Jan 2021 02:07:58 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o23sm95611006wro.57.2021.01.04.02.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 02:07:58 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:07:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] video: backlight: use DEFINE_MUTEX (and
 mutex_init() had been too late)
Message-ID: <20210104100756.sjpzzchy4tklt2rd@holly.lan>
References: <20201223141035.32178-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223141035.32178-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Dec 23, 2020 at 10:10:35PM +0800, Zheng Yongjun wrote:
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Can you explain the Subject for this patch in more detail?

If this patch is required to correct a bug then it looks to me like it
is incomplete.


Daniel.


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
