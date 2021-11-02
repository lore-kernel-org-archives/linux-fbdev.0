Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE8FC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Nov 2021 11:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB02F60EB8
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Nov 2021 11:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhKBL1x (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBL1x (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 2 Nov 2021 07:27:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687DC061714
        for <linux-fbdev@vger.kernel.org>; Tue,  2 Nov 2021 04:25:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u1so1134189wru.13
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Nov 2021 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kvwZwXYZNMaH47QodfleY8bbkp1N3IyDMKhN3HLkWDs=;
        b=WrLN1H1gli+0FAH4hIEVtQk4LFBbrTRdndrL6Qs1WNEayoub5ihVeo9+bxt8pBM2WC
         tR8lk4YMxRMaZDKI1JW7sLMTT+bgdQWVfmfGBq17p0GCIgJ0v1YT7cPSKrIMoIVAf5WO
         CTCpZEoPsVHZn12BR7v1FJ8jtR/iTm0EGLtwS1Hfbu9pRXcsj8TLCD1EMN24SLvJT9kN
         YxD2LNToi482xegZf0w59CPqAa/uhiXdUaCgSswjHKNwwzVtzOuAvrM3wyvyZ0lhL1hl
         ioiTwL9g39PxPIxG9vzotw/VBjq4cD70Uv7FFYGLr/Exrqi+2IVfwDJ+n3e4D4BgY54e
         Ae8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kvwZwXYZNMaH47QodfleY8bbkp1N3IyDMKhN3HLkWDs=;
        b=dCCrMPgfYSe6orOL5J7f87GiD/XXLljguCyb6ezZBDYRuuzTM4u2/dpdWg52ZDyHHY
         6AiUs/xOz7LLdWWt+VAA/H2sBQPA9j+7E8joQX0qf6QUmoRuWKR/DS5mncRCcKSAuTz2
         CDsY3ZBpi2BhO+9HTHlAFGr/irSIJXpMDW/5M/nmYOuVVb2k2HIpDtHKvDK8SSGwMv+f
         3vpq1B0/RWBvphw2wWtQnmMxcQUMw1X7PJpFQyV50HvX+ZrOaONtSAewx56L8CF/CSev
         YWn3IvlRWhhB50FhwPDz4WDYqoLfdcytv0fi4KrN8TnPhop6kwfF3bmNCUwhb376aKLY
         AiHQ==
X-Gm-Message-State: AOAM530WCpf5AjI1m2njp8DB6iPIOITeoyOGuOmzqqo1N2OgKX9kF4hz
        Ew30pS6VN5LiDeV9T7rNrlUTQw==
X-Google-Smtp-Source: ABdhPJwdN/kxMXerNBU6R+sPqACa1SYL/5CCOvDpJC9if51jTr5qzzFe45lGutl20K+r8bLSO6WptQ==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr28446450wrs.207.1635852316964;
        Tue, 02 Nov 2021 04:25:16 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c16sm5876323wrx.96.2021.11.02.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:25:16 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:25:14 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Corentin LABBE <clabbe@baylibre.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] backlight: led_bl: Add support for an "enable" GPIO
Message-ID: <20211102112514.75v7evbdp4ccyyt5@maple.lan>
References: <20211102100455.2016610-1-clabbe@baylibre.com>
 <20211102111942.xd7eqz2zrtb7zotc@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102111942.xd7eqz2zrtb7zotc@maple.lan>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Nov 02, 2021 at 11:19:42AM +0000, Daniel Thompson wrote:
> On Tue, Nov 02, 2021 at 10:04:55AM +0000, Corentin LABBE wrote:
> > From: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > 
> > This patch adds support for an "enable GPIO".
> 
> Before taking this kind of change is there a good reason why backlight
> should manage the GPIO? I thought that the LED subsystem was a sub
> system for LEDs (not LED controllers). In other words if you direct
> that the LED be lit up then isn't it the LED driver's job to manage
> the GPIO and ensure that it lights up?

Sorry... I should have paid more attention to my sense of déjà vu with
this patch.

This approach was discussed and rejected when we first introduced the
led_bl driver:
https://lore.kernel.org/linux-leds/20190705100851.zn2jkipj4fxq5we6@devuan/


Daniel.



> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > Signed-off-by: Corentin LABBE <clabbe@baylibre.com>
> > ---
> >  drivers/video/backlight/led_bl.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> > index f54d256e2d54..ebd7acc32980 100644
> > --- a/drivers/video/backlight/led_bl.c
> > +++ b/drivers/video/backlight/led_bl.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/backlight.h>
> >  #include <linux/leds.h>
> > +#include <linux/gpio.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  
> > @@ -15,6 +16,7 @@ struct led_bl_data {
> >  	struct device		*dev;
> >  	struct backlight_device	*bl_dev;
> >  	struct led_classdev	**leds;
> > +	struct gpio_desc        *enable_gpio;
> >  	bool			enabled;
> >  	int			nb_leds;
> >  	unsigned int		*levels;
> > @@ -35,6 +37,9 @@ static void led_bl_set_brightness(struct led_bl_data *priv, int level)
> >  	for (i = 0; i < priv->nb_leds; i++)
> >  		led_set_brightness(priv->leds[i], bkl_brightness);
> >  
> > +	if (!priv->enabled)
> > +		gpiod_set_value_cansleep(priv->enable_gpio, 1);
> > +
> >  	priv->enabled = true;
> >  }
> >  
> > @@ -48,6 +53,9 @@ static void led_bl_power_off(struct led_bl_data *priv)
> >  	for (i = 0; i < priv->nb_leds; i++)
> >  		led_set_brightness(priv->leds[i], LED_OFF);
> >  
> > +	if (priv->enabled)
> > +		gpiod_set_value_cansleep(priv->enable_gpio, 0);
> > +
> >  	priv->enabled = false;
> >  }
> >  
> > @@ -209,6 +217,11 @@ static int led_bl_probe(struct platform_device *pdev)
> >  		return PTR_ERR(priv->bl_dev);
> >  	}
> >  
> > +	priv->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> > +						    GPIOD_OUT_LOW);
> > +	if (IS_ERR(priv->enable_gpio))
> > +		return PTR_ERR(priv->enable_gpio);
> > +
> >  	for (i = 0; i < priv->nb_leds; i++)
> >  		led_sysfs_disable(priv->leds[i]);
> >  
> > -- 
> > 2.25.1
> > 
