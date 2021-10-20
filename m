Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E4C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Oct 2021 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F5960F22
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Oct 2021 13:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhJTNfD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTNfD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Oct 2021 09:35:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFDFC06161C
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Oct 2021 06:32:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso10302033wmb.3
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Oct 2021 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oWCJF6rhe2I9hOgbUALLKjtRkruY4fZSPu81SsXFaiI=;
        b=mKtY4XSFeflcnXaHsglmWP6tv019zlxrDWugzmIq5wgIssTL3BYT8DXbtOFoaWBW/i
         xI0nVs0+tFg5A2Jd3FtehD0JOP0CvL+bEVlDvclYx87gtPiZm8T+b8bMpTj3zh5JOpcS
         0ESuXxPBHBJeCTL7UYTQc7rvtoFTLewavSPLWji3YVFAuMH17WLJBkBAQ2IP48Ax1GxN
         zBv8dXcGaiViq84LxnnGsWpWwZUMmQf+gi2hUuVpcXzR51MknQCfHTZazt/63YRrhKJ3
         AxpZkqemkot2Ocroa2z41r/ypOuOt/euX6ZUE2SqAcu/THoi48V24ZdcauzsDM2+QrUP
         2SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oWCJF6rhe2I9hOgbUALLKjtRkruY4fZSPu81SsXFaiI=;
        b=Xxk8maMJ2KDJdkB9JbDsXH91uXmR98Funn6htlYi1EN4RhFjeMk6JqNIR6Gvu/hOUw
         sgx+Y60ls1GJcDgmMVAiUPC8dyiRm8sRBWUdF2B6tc8/tIsO10HPTjLoLl+otovNlYl1
         seuvzQOk1H4xLSWh5tLEINMdNsVj0ThMbmmBdq0OJ9jxHDXtx5mIey+bcQhQ2mZpzp2U
         jaMPZO1BZi6GmuRYbrPyB8HinkOslg4O1xv3qJCpMYAghEkOCPaVyKc0CUItlWaUfhcN
         HbSg/MaFI7fQoax/uX5/9J3b84KPbQWjbgUQ8cjHR4B29f0TXm/N69aPJVn5n5q0K6jp
         Nk0A==
X-Gm-Message-State: AOAM532pMM0MB/53i+vKYVtGtDpQZPn/LGVDXsBtPU6bJTUXdjnOF4rn
        7SA6jXpw6zM6bPeD6oxTvHDHgg==
X-Google-Smtp-Source: ABdhPJxWEQe/hXvTU7vEDfcsYTY/EwWqkEwjErIUFngjS/YLmNCPfbEV90xhF84DSxo6dzkKqhdIqA==
X-Received: by 2002:a05:600c:1c8e:: with SMTP id k14mr13428013wms.27.1634736767287;
        Wed, 20 Oct 2021 06:32:47 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m14sm2558607wms.25.2021.10.20.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:32:46 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:32:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] video: backlight: ili9320: Make ili9320_remove() return
 void
Message-ID: <20211020133244.2yc3o34grk73lzdq@maple.lan>
References: <20211019120927.3822792-1-u.kleine-koenig@pengutronix.de>
 <20211019153037.5uwqixmg7k4m3api@maple.lan>
 <20211019163621.bzgwufqkp7hcin4m@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019163621.bzgwufqkp7hcin4m@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 19, 2021 at 06:36:21PM +0200, Uwe Kleine-König wrote:
> On Tue, Oct 19, 2021 at 04:30:37PM +0100, Daniel Thompson wrote:
> > On Tue, Oct 19, 2021 at 02:09:27PM +0200, Uwe Kleine-König wrote:
> > > Up to now ili9320_remove() returns zero unconditionally. Make it return
> > > void instead which makes it easier to see in the callers that there is
> > > no error to handle.
> > 
> > Ultimately the actions here boil down to an SPI write which could fail
> > so we could make an attempt to correct the broken error propagation
> > inside ili9320.c instead...
> > 
> > > Also the return value of spi remove callbacks is ignored anyway.
> > 
> > ... which does inform the above question.
> > 
> > Is this patch a local fix or part of a larger plan to eventually change
> > the return value of the spi_remove to void?
> 
> This is the motivation yes, so there isn't any sane way to propagate an
> error. The only thing you could sensibly do is to print an error
> message. But the device will go away no matter what you do. (Well, you
> could do an endless-loop to "delay" removing, but ...)

Great. Thanks for confirming... and in that case:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
