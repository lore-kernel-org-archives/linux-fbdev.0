Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED3C07E9D
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 15:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiIZPGl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiIZPF3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 11:05:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69EA4B27
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:37:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n15so10289419wrq.5
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KmT8737fPacCpbfR4MFMQYGBKsGn/TS8+soZ+8lgu8A=;
        b=clbYS2trrlEmEU5PvY7GzPsFpNhx42e6ugi0cebf+mDl7GN0ScQiuWEWx9oI//xRW3
         FTsIkMUYWsosA6ETER1iOAZBFulSPna7QojcudDzV9Gjh6ZXF7wC4rGSegNcRu5Ft1Ph
         BS6EkAyFfofpLQODvC8UOkGzOjiBE8Yy9RhewoiXrazdtQ66dWSPD0UTCdZ7tMxEGtpm
         I0Nzso8+fmeqOPEcJjAJbcee0EBTKVECyF0ypE7k8ssYF55yfuv05pqxHCCE502HYHIV
         otu9flHASZ3pJZp9q8hAk/btIyXiBMmqy1X8bMDp2FfG2NTKuhiguBJbMQWww47+H0Yz
         AXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KmT8737fPacCpbfR4MFMQYGBKsGn/TS8+soZ+8lgu8A=;
        b=m27KVB0Gd8BZIqKFjIsiSGYTXweqvPlPzY30oNsvihj1BYs5gj5nRhwINoKEOb/N04
         IE591/UINxFBDRvbKEibPW8mOuMdKnxZboy65PG7uFFo1TeMrsDFrtWzvpFZBNUFYd/R
         AQkIFk5sQArg4sLSU0IruuobG3AzFa6XxymZfCy9T5ZO/QFQrcDzUWBLGYh90jD9zljv
         gJJPqaPozX6bqSXycWX4P5tq6G12XUnz1X++LKCUOHf/B6ybzSQoZLSoaoyAq8Ct4p73
         YN9mZLWzaQCg7KUAaG4ZVIf6aZJ0Nsyedmc1LTqQdBTcO+BZ3aHi82Ys98E5a8RXpG0w
         aYiQ==
X-Gm-Message-State: ACrzQf3ANlmlsxcAeojTXw2TxqhoAHN0wHw/WSFkk0g0HmYwhwrdlLyD
        Irvxl3NKOee5NQ/JP9u4obvfaw==
X-Google-Smtp-Source: AMsMyM7qingDZgfmrbprEPmbkWZZkb8lMYITqDwe2EjvcBMstJgtHXpux5BlMKdCH7An7nEK+yxidg==
X-Received: by 2002:a05:6000:178d:b0:226:ffe8:72df with SMTP id e13-20020a056000178d00b00226ffe872dfmr13301991wrg.496.1664199473455;
        Mon, 26 Sep 2022 06:37:53 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b003a5c244fc13sm11536200wms.2.2022.09.26.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:37:52 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:37:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee@kernel.org
Subject: Re: [PATCH -next] backlight: pwm_bl: Switch to use dev_err_probe()
 helper
Message-ID: <YzGrLsNrwEyL98nP@maple.lan>
References: <20220926133258.1104850-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926133258.1104850-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 26, 2022 at 09:32:58PM +0800, Yang Yingliang wrote:
> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.

I'd prefer to have received these patches as a patchset rather than
individual patches... but it is a good change so:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
