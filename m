Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAC9C04A95
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Sep 2022 15:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiI1PpY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiI1PpT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Sep 2022 11:45:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3949A7E02A
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Sep 2022 08:45:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so1238694wms.3
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Sep 2022 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7G3PuyNs64T9+gNR4JUjnzY5lk+niLsGepAuneEIq0w=;
        b=ebxtewCKg6Aw7sEhbafCVh2tV7gW3FtInBneELrdjdkiu+dKVDa9YTB/6MHEVZ46Oi
         kHyWz7s6BtiC34kK39iVyuAuyY45+guJXEGy60rDx66FlnbjUwZ+mVaYbUcamCdMSWAz
         lr5ujmue0ikcfocE6hqZ7NCooyv/r5fpvjniaRJIZxGRwHpEzJNhwE9QFNRZpBfeSas4
         II1JAmZ2NLZxMNRT+nGjCGmEALid+B4J6FeerzYKpH0vjz362X62SwGckjzOkwPky3g4
         ZmFu5ghXCJNpwBhpWE1ZYRsaYXZQvvzg6Gfd/vywIzzgB1Wj720jx13ktCy/RhzxmWfm
         c/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7G3PuyNs64T9+gNR4JUjnzY5lk+niLsGepAuneEIq0w=;
        b=qyQ6jiYGqoUxZJ7IW0YJtqXKb2JGfbX9mW1TT9hZWhS+xICAilyXK2KwoG1oxx1syV
         u+FpCud9CIWxAfDRIBhyssA93ERAjKlo/pw14/W5QDxDNXoqRL1+Rsp2yXb/bHM+D+Yt
         ldXO0dOGSQHtO0it7qorhylNGtaRNx/fOjqp7IumpHaBHO052KFSLLGKl5ENPTPK8dlQ
         djlwOj1d6W0VQdYKHIADPQQXgfdkKuYbwIIuSx9GimmNaaDue+6a+3jmapjOk2QUylXK
         aLbuZYYHq8MShKnNDUo8mZOz9iat40XS1iPiAeacEZu4cB0KX2cdowKUSat23womDUVa
         aK7w==
X-Gm-Message-State: ACrzQf19OefOkOL/shqbacHGUaedWeiJ8t1CIZuNZfeuPL2dYBJrDSXX
        MvvtfbvEMlyvOSY18yelq2lNSA==
X-Google-Smtp-Source: AMsMyM5BZHRf8L6EwpVwJJ6b3Z3NoGDGct+cLKKAcKLtqvIEaEBwJztpMDX+I8JGUhpWU+dAsNt53Q==
X-Received: by 2002:a05:600c:20b:b0:3b4:86ff:cd with SMTP id 11-20020a05600c020b00b003b486ff00cdmr7484665wmi.35.1664379915320;
        Wed, 28 Sep 2022 08:45:15 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d410d000000b0022cbcfa8447sm4635006wrp.87.2022.09.28.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:45:14 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:45:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        lee@kernel.org, jingoohan1@gmail.com
Subject: Re: [PATCH -next v2] backlight: gpio_backlight: Switch to use
 dev_err_probe() helper
Message-ID: <YzRsCQcUfC+ClbSl@maple.lan>
References: <20220926142447.2296872-1-yangyingliang@huawei.com>
 <YzHGEAoodSoamUIM@maple.lan>
 <7d8cfce2-ba08-afc0-de2d-972ee15b5865@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8cfce2-ba08-afc0-de2d-972ee15b5865@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Sep 27, 2022 at 10:17:32AM +0800, Yang Yingliang wrote:
> Hi
>
> On 2022/9/26 23:32, Daniel Thompson wrote:
> > On Mon, Sep 26, 2022 at 10:24:47PM +0800, Yang Yingliang wrote:
> > > In the probe path, dev_err() can be replaced with dev_err_probe()
> > > which will check if error code is -EPROBE_DEFER and prints the
> > > error name. It also sets the defer probe reason which can be
> > > checked later through debugfs. It's more simple in error path.
> > >
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > > v2:
> > >    Remove "Error: " in error meassage
> > > ---
> > >   drivers/video/backlight/gpio_backlight.c | 10 +++-------
> > >   1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> > > index 6f78d928f054..4ff3939e5f7e 100644
> > > --- a/drivers/video/backlight/gpio_backlight.c
> > > +++ b/drivers/video/backlight/gpio_backlight.c
> > > @@ -64,13 +64,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
> > >   	def_value = device_property_read_bool(dev, "default-on");
> > >
> > >   	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> > > -	if (IS_ERR(gbl->gpiod)) {
> > > -		ret = PTR_ERR(gbl->gpiod);
> > > -		if (ret != -EPROBE_DEFER)
> > > -			dev_err(dev,
> > > -				"Error: The gpios parameter is missing or invalid.\n");
> > > -		return ret;
> > > -	}
> > > +	if (IS_ERR(gbl->gpiod))
> > > +		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
> > > +				     "The gpios parameter is missing or invalid.\n");
> > Why keep the leading "The " ?
> OK, I will remove it in v3.
>
> But you says "the resulting line will read better with a "The " at
> beginning" in your last mail,
> I am confused about this.

That's because my e-mail was confusing! Thanks for fixing it.


Daniel.
