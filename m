Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055FC43381
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Feb 2021 17:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DBD64F27
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Feb 2021 17:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhBZR0r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 Feb 2021 12:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZR0p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 Feb 2021 12:26:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CBBC061786
        for <linux-fbdev@vger.kernel.org>; Fri, 26 Feb 2021 09:26:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so9303710wro.9
        for <linux-fbdev@vger.kernel.org>; Fri, 26 Feb 2021 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bqhbgu1Yp7BWdaUz/Li+kTuQBD64JpudY4kka6cuYOU=;
        b=de/+gQcXIlBR8jVkGwRajly9Ur7JLImRwKdA+cqTXTZs2N9AXIZdKdqD63bPpunD4X
         skq0DwsLCISevZLfmV9iOR6B/XV8PPTB0urSK1KY3HiY0yFlCuOSPH1MXrt8FHbRz5dq
         qm9yXsuQ9A/7hySFuR9vYhZQXbjIhgI0PgCuHk+GmglnrOlbRmcijDueB9SRpR8saq8X
         Si6LEabKe9dqZqHszSD2dChA8chYp7GnBZgSNV1yPlWZYAX+1UB7xHqJLcqjV4ESJ+mW
         XmgfxsxOViwwKJgHzfnSA+RUuMgpP09C2JcsYvCwhZoLeuwu+l1MLZTugYxD1FPiG2gG
         YggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bqhbgu1Yp7BWdaUz/Li+kTuQBD64JpudY4kka6cuYOU=;
        b=gFp5J9XLGwQJIn4GNngF1G+Bn3iGnrS9KAUAsGsddZHmSdPQl9yio/uTHS6bD1HYul
         zpi21hQQsVShvej0l76mYXJJu6x8RjNqJtJtfu/C+H7wxvQacEGa4BWc5gw1s6w+CWsY
         GLRu66M4STzz8lDciBzKsg06vfn3a4nR5Sb8rHpTARtVu7w9gL1YCeI5cSRb2TCz+h76
         Tbl0qUu0a54rzp7MS35Sx6Nv3Is1IRs6WIDwZTZZGwnyF98WlrbF1HK+HLzrI+yCJ4cl
         W/sdWQ3ByGiMWIYnVgFarHEWPsXXfiQpFbXkxHkMwOZQWXxY7QhAOcXgu72H1QsjQ7gs
         qZ3Q==
X-Gm-Message-State: AOAM533OGrkKPwe6nvAQpuWGY1Xmc9ej0A4f9ZaKNa8w5iKFXMccm2FZ
        9KrU6RU20qLCSVANbm4yxZt0hg==
X-Google-Smtp-Source: ABdhPJxv59nbOS4VjGoDEpvCB0o1HoLwhHwNNBMlJkKj6HsOImMA6tQWRJDOfwNGqiBMHmLBgvAGBQ==
X-Received: by 2002:adf:e409:: with SMTP id g9mr4219176wrm.423.1614360363351;
        Fri, 26 Feb 2021 09:26:03 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m9sm57861wro.52.2021.02.26.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:26:02 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:26:01 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] backlight: qcom-wled: Correct the sync_toggle
 sequence
Message-ID: <20210226172601.aknj2d4hghkkqjol@maple.lan>
References: <1614341544-5306-1-git-send-email-kgunda@codeaurora.org>
 <1614341544-5306-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614341544-5306-3-git-send-email-kgunda@codeaurora.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Feb 26, 2021 at 05:42:24PM +0530, Kiran Gunda wrote:
> As per the current implementation, after FSC (Full Scale Current)
> and brightness update the sync bits are transitioned from 1 to 0.

This still seems to incorrectly describe the current behaviour.

Surely in most cases (i.e. every time except the first) the value of the
sync bit is 0 when the function is called and we get both a 0 to 1
and then a 1 to 0 transition.

That is why I recommended set-then-clear terminology to describe the
current behaviour. It is concise and correct.


Daniel.



> But, the FSC and brightness sync takes place during a 0 to 1
> transition of the sync bits. So the hardware team recommends a
> clear-then-set approach in order to guarantee such a transition
> regardless of the previous register state.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index aef52b9..19f83ac 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -337,13 +337,13 @@ static int wled3_sync_toggle(struct wled *wled)
>  
>  	rc = regmap_update_bits(wled->regmap,
>  				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
> -				mask, mask);
> +				mask, WLED3_SINK_REG_SYNC_CLEAR);
>  	if (rc < 0)
>  		return rc;
>  
>  	rc = regmap_update_bits(wled->regmap,
>  				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
> -				mask, WLED3_SINK_REG_SYNC_CLEAR);
> +				mask, mask);
>  
>  	return rc;
>  }
> @@ -353,17 +353,17 @@ static int wled5_mod_sync_toggle(struct wled *wled)
>  	int rc;
>  	u8 val;
>  
> -	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
> -					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
>  	rc = regmap_update_bits(wled->regmap,
>  				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
> -				WLED5_SINK_REG_SYNC_MASK, val);
> +				WLED5_SINK_REG_SYNC_MASK, 0);
>  	if (rc < 0)
>  		return rc;
>  
> +	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
> +					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
>  	return regmap_update_bits(wled->regmap,
>  				  wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
> -				  WLED5_SINK_REG_SYNC_MASK, 0);
> +				  WLED5_SINK_REG_SYNC_MASK, val);
>  }
>  
>  static int wled_ovp_fault_status(struct wled *wled, bool *fault_set)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 
