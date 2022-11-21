Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD1BC433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Nov 2022 11:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiKULPX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiKULOu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Nov 2022 06:14:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91CBFF63
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:10:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bs21so19313160wrb.4
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bovRlaV+W5pxvhors/w9N6j//qWxcZTo0qg8XUozrUg=;
        b=Mq3lZGUFJvV2db5ccYAI3CTBXzUz18HyYkrHGH4ZjxfwsJjGhJQS8ioXSjg+mfaDEZ
         YlRTCEiwVtGuuUPRKsWMewBS75dGwa934vPNmalnoXfJUFAJWEBzEPylO48LNxu86ULj
         +ofRqY0hpLZOa+bBzVtb1D7TNfSXqVOuECGWE8wb62kOcVoUXHXtHTROfG5lovou9ifp
         3GEz2j+ZaxwhM+cl823HbyQtlJ9k31CUnoEIX30LQOwS/r6iHSCbM81h5VAwVm1ufSir
         H/XZRfWKVnxKxPeny7/UJh63vmqtLyqxIkunN72klDvLX0vNbj6W+i4d6mJGNqn2C9Va
         7yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bovRlaV+W5pxvhors/w9N6j//qWxcZTo0qg8XUozrUg=;
        b=DiP/gVYA80epkbTs5RIKr3XeqdqGMcLH7LqcvZzDrQBXnrgTw5YvSRh8e2p7/1GZDx
         KBZL74LFsrOFldCnezhZ91oXZPGxJZPIL2qGnSO+bdbdWtPgxDrc/N72iIjDn9/wYii8
         anyfgWT+l5Z78KGO9LtbLhyooDQBPXXMn21l8t49YnHbXK1tipqxMmRFxnJ7egL2nKWQ
         OEbtYmxqm4CEpRlrI9IyE6llkMdAEZK8gjAOr0XPck1uSmKgpSAe1Lb5789lARqAQVlv
         TbdgPE82Sn0wBjPXEe4Rk7N0BNCBpFCmhEKrIHiMQVmbjPT+My8VLYCAZc0vNHZ4RXVq
         kPrA==
X-Gm-Message-State: ANoB5pl+xxs8IUfhr/mBUI80ht1wNmyyR3HHkeSzf0rRayZXUVaWThWp
        YTSdxcpCWG+rDH6MNILdaW/y6Q==
X-Google-Smtp-Source: AA0mqf4V3ZLnNNPcGkGa84Iox1i5ExYxfBP5BDriqNKkkM4OyvZF0Q6WAV8GEafnYO+omjGoAwSdkA==
X-Received: by 2002:adf:fd10:0:b0:241:b42c:2e4e with SMTP id e16-20020adffd10000000b00241b42c2e4emr10868331wrr.482.1669029021492;
        Mon, 21 Nov 2022 03:10:21 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d4d8e000000b0022cbf4cda62sm12947381wru.27.2022.11.21.03.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:10:21 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:10:19 +0000
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
Subject: Re: [PATCH 592/606] backlight: lv5207lp: Convert to i2c's
 .probe_new()
Message-ID: <Y3tcm9FGB/UCRbuC@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-593-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-593-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:26PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
