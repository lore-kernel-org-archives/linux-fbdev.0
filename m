Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0960FC4321E
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Nov 2022 11:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKULNs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiKULN0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Nov 2022 06:13:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E1BE877
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:08:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x5so15234714wrt.7
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKFN/qhJLz7mgPB83k+rnOu0PmFMybHP5ytr4JLJaN8=;
        b=skMPVaZW7ILGeRoxtx30vONIGtauHppYucwUioLbzrs3ayNy+JmTsntWDg04dYoH3b
         HF8vhGPUTX5cDsFpMtgSFUhFOBoMcf+9IL9M4nYrI55ja55xbrhlRIFCs0Bsth+Ixa+S
         MppqtJMBoy+vP3MfNHzbCc/RdrLvbYwilyussbFkEAym0PFcj/mJZg78Ht8bNO+nXSc0
         gCrRT00Q6xFI70WgpViyj3jZT0m425ddYS8rPsJxTg5J5DbaoEnTDuqDsEQnKyZQPAtz
         SwKtNRl9PXTmXn1zd+TnoFzX2vVnQOGr/F8JYxIWXNV9csANcDjnnEAvyVKY92C44t5A
         Z3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKFN/qhJLz7mgPB83k+rnOu0PmFMybHP5ytr4JLJaN8=;
        b=yJX1UZ6P4+QnVAG8JolV13lhWd95UtyDPw+WvKYw3xx2jFMGSr97Im/WpkoHuCruyR
         GorkQpZmr8oMjdo+B9gfljLGkStzz258s4tZK4VuLlCj0tniykiceiEgOJY1VVnfVXtO
         7yPPUU1on4QX9eVol9rzvuAL2CoKSc+XNgf3WLgcVsHN/Ah2aaT6uPr7lfCgRouXaNdE
         BVZCd7wO7FcDF1FIi6NXNTBnYrbpcSTLmJGc/cL6J7Up10bHnQGgBah0Bb2DuSJbh973
         EY/CpcI/eUlCnVLJO8X8rbHMwjzCASCBSx38zGJoFzL6q4jRFRzgoxTzrisH4rDhZggQ
         XtBg==
X-Gm-Message-State: ANoB5pluUPnh5iclxFoahkO9o2lisMrFvk7APgWkkyoTSxSZyDR8DS8m
        5B7Sv+nA5WefQKFy0ZcnWuqhxA==
X-Google-Smtp-Source: AA0mqf40H/ICnbr6ZBWHaqtwbFiAylS7QqqSPNSiszc0FzLclW6Lm03Q48bJYma9B2JABx2G9q/GyQ==
X-Received: by 2002:a5d:5955:0:b0:241:553e:5040 with SMTP id e21-20020a5d5955000000b00241553e5040mr4154181wri.578.1669028927942;
        Mon, 21 Nov 2022 03:08:47 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003d005aab31asm13554055wmq.40.2022.11.21.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:08:47 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:08:45 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-i2c@vger.kernel.org,
        kernel@pengutronix.de,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 590/606] backlight: lm3639: Convert to i2c's .probe_new()
Message-ID: <Y3tcPeajtfN/hCce@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-591-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-591-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:24PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
