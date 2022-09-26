Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA80C32771
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 15:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiIZPL3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiIZPLK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 11:11:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1269A4BB0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:46:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n10so10260089wrw.12
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wDQyQ3S0noabZCtBYiSEuTtioa8Tv5/nq3tQQLE9mKc=;
        b=HmMw8Wwy5JCjR+G3NafWR1FccJnh/abIUElXkN8PqAMd8eYqr4DOabI/1FP++8LzTX
         EZklm3RPUCHlTp0AiLRF8O2jD4n0mGtwN/os3mtdL6JV6RiqcQ/Aq4G+y/m09T3uoj4C
         PTO8+C00QybJdTvT3r6f64nxZxG88Q9Kl34VaKIXdp9T7shJhI/sphgADxXcUajnirlj
         0ftM7Oyk0H1vnAiLq0QAnc1bZht44AYy3TzGu6Dzl5kNMCsBAKm6ZqezQ76Mhy1sPwpa
         c5t1VLQohKo/3Cf64X8exMLjttJg7TLAgGZQ2ohv9AC6RVzr4AQ6zbNu/eNtXXoRE61M
         +xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wDQyQ3S0noabZCtBYiSEuTtioa8Tv5/nq3tQQLE9mKc=;
        b=gqqFkddoA9ajMk2NsAQnCpWJQeGBjIm546KDW5nz7XK09BJUsJ6PNEXWeuAgq9XGzh
         jhffUhR4SxQQZzM5NacD8mWR941CCmY7XwUgIWPkXSZoffVLhRt+Wn3wgSYNc0u5+8yQ
         oslKNn/NtpoOqmQVM4yJIpCYviF47K2A5rB2yh1es371Z9ne8qdIDaymkVdCKdlbbjbj
         66lUiQRtiuIGpF7lAJzzdvSOYhq6j8j8R+nLnIgtVEW2osaBAl4gkRuS1mwjW64hRmvH
         sNSs3xBU8Hyu14N6EuncYUSMcB3027GA8cqOpxTsey+ShPAIR0w9k2HbU0rsolS0ttR5
         faQA==
X-Gm-Message-State: ACrzQf2WvlmzEPVz0IEtbLtNAqGgaXJBKVu8lnlodinoWa6TAHWXp/rm
        0X24uSJZ/BqpaTY98YqMlhcCCA==
X-Google-Smtp-Source: AMsMyM6vGVKMMO0iJnizEQFuXAHVtiSiwAqIlwKS4/L7rIE6+LpojI+p45OCYJeOgJsaHzmDYHzYng==
X-Received: by 2002:a05:6000:984:b0:228:60fb:e364 with SMTP id by4-20020a056000098400b0022860fbe364mr13404183wrb.66.1664200010433;
        Mon, 26 Sep 2022 06:46:50 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b00228cbac7a25sm14499606wru.64.2022.09.26.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:46:49 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:46:48 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        lee@kernel.org, jingoohan1@gmail.com
Subject: Re: [PATCH -next] backlight: gpio_backlight: Switch to use
 dev_err_probe() helper
Message-ID: <YzGtSPDMQNUf41Z9@maple.lan>
References: <20220926133819.1298856-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926133819.1298856-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 26, 2022 at 09:38:19PM +0800, Yang Yingliang wrote:
> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.

Needs an SoB.


> ---
>  drivers/video/backlight/gpio_backlight.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 6f78d928f054..4ff3939e5f7e 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -64,13 +64,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	def_value = device_property_read_bool(dev, "default-on");
>
>  	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> -	if (IS_ERR(gbl->gpiod)) {
> -		ret = PTR_ERR(gbl->gpiod);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev,
> -				"Error: The gpios parameter is missing or invalid.\n");
> -		return ret;
> -	}
> +	if (IS_ERR(gbl->gpiod))
> +		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
> +				     "Error: The gpios parameter is missing or invalid.\n");

Remove the "Error: The " from the beginning of the string:
dev_err_probe() adds an error tag and the resulting line will read
better with a "The " at the beginning.


Daniel.
