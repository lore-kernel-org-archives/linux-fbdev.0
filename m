Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F1C433E2
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Mar 2021 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DEE61930
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Mar 2021 17:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhCVRen (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 22 Mar 2021 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhCVReS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 22 Mar 2021 13:34:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB4C061763
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Mar 2021 10:34:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so22646076ejc.4
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Mar 2021 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=itvxu6pseNvAArTXkxBUqpwVqMnWpn85hJGn4Cdpwhg=;
        b=uNTiuiHb//r+7s512XtcPzPyLF04pqLQ3NrFXgaoxYNR2RU0pDoYy1ZNFTfKaRBx3R
         qUpdSxsLmTiozn+u05mEF/2mOns8JJqI3whi5eUsFhPYQd4a/eGXutlrOs1KdMC5vKXZ
         D5NfmKie5T8TXOEpLX3eqXPKF/2ibqi+auQ3HJUAWhdl0PiQcmhIE+gj58H/w7T4dyTb
         KY/Ex9Y+BtG5FhKLOWVluiKYgNltP/jhOs8Abi1ZipK2VPfsg0P3Rx5+52mA6aIxLF5Q
         D+A7SD93d2c23HV9ByoiID4u+zWDyy2KubD1XKv/mr87//jjBOOUc3lGWiUyiBSMvn7b
         dSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=itvxu6pseNvAArTXkxBUqpwVqMnWpn85hJGn4Cdpwhg=;
        b=cd1Tqc0n+LRm8eYUlsPNzT/dzk1C7zAICzm1jE74lufoKWuBrH63/gqfFlGNuvN4Bu
         +KQxjq0wCiSBV0jNPzPiX9NXBwwt7kAwgDE12utkM5Dlbvw67rmtPXMOyGloHaiWTMn0
         ai2qn1IMxY/qP0eycVRVT8gGuWS/Qfn+HtjT/df/AW0kV5LGw4p8Ovn23/yMuCRG9Gea
         iQ6A/Of+Yh9d8Agp/9snZNJom2HOlZRejmwrQP4DUJnM23owCfNbPgmFEj/+IHUiUKFi
         FXkgv42oo1U0eGNaWKZJN5MfPRXVNcoSe50b9WJtqrsmXB3J5ygFlaD/nhP9qKrQ6uoz
         FgWQ==
X-Gm-Message-State: AOAM532jkZIR4H4KsQFsQH/MsAEzpA9WTIFOlogpvhPwWBSmwmGdhP/L
        7ecdF7V6X4bqD9FAqrflboDPiw==
X-Google-Smtp-Source: ABdhPJw9FtwQ6aO2ECGVnHO58EnkDcEQ+fGQM9CFtqdocU6sXQqPcqwjPD5Dl/pLvT5flLaGRSP8fw==
X-Received: by 2002:a17:906:340d:: with SMTP id c13mr934869ejb.29.1616434455577;
        Mon, 22 Mar 2021 10:34:15 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id n3sm9867573ejj.113.2021.03.22.10.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:34:15 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:34:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH V5 1/2] backlight: qcom-wled: Fix FSC update issue for
 WLED5
Message-ID: <20210322173413.GC2916463@dell>
References: <1616071180-24493-1-git-send-email-kgunda@codeaurora.org>
 <1616071180-24493-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616071180-24493-2-git-send-email-kgunda@codeaurora.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 18 Mar 2021, Kiran Gunda wrote:

> Currently, for WLED5, the FSC (Full scale current) setting is not
> updated properly due to driver toggling the wrong register after
> an FSC update.
> 
> On WLED5 we should only toggle the MOD_SYNC bit after a brightness
> update. For an FSC update we need to toggle the SYNC bits instead.
> 
> Fix it by adopting the common wled3_sync_toggle() for WLED5 and
> introducing new code to the brightness update path to compensate.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
