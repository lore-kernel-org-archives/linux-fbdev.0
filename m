Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50913C433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 08:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DE16198C
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 08:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWIj6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 23 Mar 2021 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCWIjk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 23 Mar 2021 04:39:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331FC0613D8
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 01:39:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so25696641ejr.5
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vOdKWnp3rkpIGMt87ZNlf2cZf53/gDQXm8BtihNuwrY=;
        b=awC7OJCja/vDjs8UM3Q2cV7cH4nuw99ReUsihpNF+0rbb/GYsXuZl+yoz8gQu8xn4B
         hTALcZCKLmRhR6rGBx5oe19l9xnWJ31Ch53+rY2CpZSSvH55LYyJp+91113PSVJNIS00
         yFWPcW99/D9lZFnQZlpOHcfmEI5dxY6BBarjNauuYBRpKnAvbIeobKullrS6/F+GabEX
         RLIqR2rCthAonYJaBQByTJodXq+ZjqYwTvE5UiCKMUxKQmKPupfoBqFqkV0eDKW7SzPm
         0+ul8XGZKTS40YtkXqZCXjiN7E6EnNaZwrf+8JXCI2s9pdm7CQckxordKve2k8LhNwLb
         jcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vOdKWnp3rkpIGMt87ZNlf2cZf53/gDQXm8BtihNuwrY=;
        b=eoGzcjDCr+tqFrNNtk//AIoEGodo0kyGFp+S8k5c2W40UpAskeWqneAcYWc49GNat8
         uy5dqFHTLFDBr1q6zO1swLao2KlSsCmlis51eQGiDzPBP8Z4KnoSKsGZ9lq9KWASZOFn
         D6xgjMLjXXgbOqi+iO2il7z9u9/GST9pKRiQZfGf1snH6ez3rbdyI4DKpv3iOXVhO8dQ
         kJ0Slzj2GQgPTHdwJF7B/n1QadKdrXseHw+HZghav5mJaVX/KQo+GRgd/drgOh4xqIw5
         WQTkpsnkehoxsZTE5XbDx8spuuF6XLYuE+kmLjpVn0MTds5zJkH2bVkvYEbDRt9SUP3T
         MANw==
X-Gm-Message-State: AOAM5334rnWxkKcKLgM9Kl8x8lIPfJVSOvLOmiZn0zYfX7d9WsvO3Wvd
        8XmdhL8hJINnWXpw2TcQ5zuBTQ==
X-Google-Smtp-Source: ABdhPJztz2rpnHmS0vjtxAqb+sjwT+S9UIOX/8oNcIG+D+p3IjWse50o3nha+gQW7cNBnqWhjOEJGw==
X-Received: by 2002:a17:906:d153:: with SMTP id br19mr3749846ejb.360.1616488777820;
        Tue, 23 Mar 2021 01:39:37 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id h13sm12649939edz.71.2021.03.23.01.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 01:39:37 -0700 (PDT)
Date:   Tue, 23 Mar 2021 08:39:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] video: backlight: qcom-wled: Add PMI8994 compatible
Message-ID: <20210323083935.GF2916463@dell>
References: <20210228124106.135812-1-konrad.dybcio@somainline.org>
 <20210228124106.135812-2-konrad.dybcio@somainline.org>
 <20210322161810.biagj2qro66rv4gt@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322161810.biagj2qro66rv4gt@maple.lan>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 22 Mar 2021, Daniel Thompson wrote:

> On Sun, Feb 28, 2021 at 01:41:05PM +0100, Konrad Dybcio wrote:
> > Add a compatible for PMI8994 WLED. It uses the V4 of WLED IP.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Why are you Reviewing/Acking a patch that was applied on the 10th?

> > ---
> >  drivers/video/backlight/qcom-wled.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > index 3bc7800eb0a9..497b9035a908 100644
> > --- a/drivers/video/backlight/qcom-wled.c
> > +++ b/drivers/video/backlight/qcom-wled.c
> > @@ -1704,6 +1704,7 @@ static int wled_remove(struct platform_device *pdev)
> >  
> >  static const struct of_device_id wled_match_table[] = {
> >  	{ .compatible = "qcom,pm8941-wled", .data = (void *)3 },
> > +	{ .compatible = "qcom,pmi8994-wled", .data = (void *)4 },
> >  	{ .compatible = "qcom,pmi8998-wled", .data = (void *)4 },
> >  	{ .compatible = "qcom,pm660l-wled", .data = (void *)4 },
> >  	{ .compatible = "qcom,pm8150l-wled", .data = (void *)5 },

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
