Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07FEC433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 11:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7633364E90
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 11:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhBXL1U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhBXL1Q (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Feb 2021 06:27:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146EC06178A
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Feb 2021 03:26:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i9so1175151wml.0
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Feb 2021 03:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Dupz3O53DL08Or0yk10V+iPvTZYbPsmQwB7yrZKV6w=;
        b=qONknWsxjLt46Tv+VSk5low1SmhgJvZv/zSwxdxmOApxEXFhrhxhXR7tkOuhwaR7Pv
         lhIHBX+nNa6U1XaScW2R46NDN0lC0sukXHm1HJmj0zKoxgxzURWdEFBtvPq7ifTIt9MM
         +8MR0Z3LyW9k+f/2Z88WG4V6bhX4dyGqrWrwpwfHVf6Un/+EjZDH7HzAsO98ON1742tJ
         PvERobBd1n0p5HW9EYJ1se2+U1S6mNPhiQ91+EMUNHK6i6qtZFxROhfW7oGOyRN61J2B
         d/55+1eG8qnFVg8tY+POfjRUIFEBf12f+BJMlgxgE/sX/Nd6wWw4bH+Xsq79arT8YkVW
         vDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Dupz3O53DL08Or0yk10V+iPvTZYbPsmQwB7yrZKV6w=;
        b=VhwZtY0+uqUr7yFKfAOjBt+peRTO/BrN51wK9v5pcFixy9bB0a9nddottYM3jAzS1J
         D6TG1E6m5ekSwyVFdbkjCNkU6o40GV/nJfUlCGF5yvgIRyYPaqsvK1HnC+V+FNHyjSsA
         6PuphUbAYCog4SWGCi2TEEzXrJVkOmDvhKzYHfs/ncdWILVMicyfVl7/ghAAir+JJRwL
         /s/3f+pJKSwFhFsr9Kjh+/PAy6VRTDbmFcRP0xVb4mp1IpIaHk6TqBIVKxMFQr3liYpl
         +AxFH3dtz2xDPx8z4mkbC4wFTm2h7VxkXBaB1fawCRDHugWszhk90fjdOGjTOv+nZ90W
         l3cA==
X-Gm-Message-State: AOAM533xsQ7gC60UE7Fj4onxBdQbEcSGf1YXBu+iWE84PnkcSM2MAptF
        mdlHco4V4rn6KsDQq/ulWsm+bQ==
X-Google-Smtp-Source: ABdhPJwor6keoh6M2L2zgYFANbudE+9Gd7yba6NAmYs8Z4HPgcyGvNCz4XuESN6QjxZbm8V+Zz/k3A==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr3349896wmi.132.1614165995020;
        Wed, 24 Feb 2021 03:26:35 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 36sm3369148wrj.97.2021.02.24.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 03:26:34 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:26:32 +0000
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
Subject: Re: [PATCH V1 2/2] backlight: qcom-wled: Correct the sync_toggle
 sequence
Message-ID: <20210224112632.lgm2yj6ekayuqg2p@maple.lan>
References: <1614138648-2963-1-git-send-email-kgunda@codeaurora.org>
 <1614138648-2963-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614138648-2963-3-git-send-email-kgunda@codeaurora.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Feb 24, 2021 at 09:20:48AM +0530, Kiran Gunda wrote:
> Currently the FSC SYNC_BIT and MOD_SYNC_BIT are toggled
> from 1 to 0 to update the FSC and brightenss settings.
> Change this sequence form 0 to 1 as per the hardware team
> recommendation to update the FSC and brightness correctly.

Again... this patch description feels somewhat rushed. A patch
description is there to support code reviewer and to go on the version
history to assist with future maintainance. They matter!

Anyhow I don't recognise the "from 1 to 0" in the code since both before
an after the change it goes "from 0 to 1" and "from 1 to 0" but in a
different order. Doesn't the code actually currently implement "set then
clear"? If so then, likewise the new code is adopting "clear then set".

As with patch 1, the sync bits modified by wled3_sync_toggle singular
or plural?

Finally a description that is more sympathetic to the reviewer would be
welcome.  For example the following (if my guess is right and it is
true) makes things much easier for the reviewer:

  "The sync takes place during a 0 to 1 transition of the sync
  bits so the hardware team recommends a clear-then-set approach in
  order to guarantee such a transition regardless of the previous
  register state".
 

Daniel.


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
