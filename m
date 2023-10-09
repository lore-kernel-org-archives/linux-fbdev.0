Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFE7E95A91
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Oct 2023 10:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbjJIKSj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjJIKSj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Oct 2023 06:18:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92231BA
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Oct 2023 03:18:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50585357903so5743206e87.2
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Oct 2023 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696846716; x=1697451516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzjqhcxTplk/fjWtjjswcwgpKZ+f2AVwpc+PUpIKpZs=;
        b=ZEUKLlgG/gqJMRxvNHNWSDthUAREEt003CrTKeTuRNfvd/UOpwsu93VQOfO34/amnB
         y88jK5pmZAvN9dvwadadS3zMDa8Bldab1Gae6gQtRKl65J9k41zsPih/MEPw46HTiiAp
         xrx7tvKvSZrUlq3YxRJVyqwpUXwNnMgmonDsoiBXNiDfYZH90xdHl5xtjq9bvXRNNGKH
         HcJmwcjfxYTd2R4dNQdhmEU9IRDOobevYP1O1AexRCNsw6sslBJEv6FKPjWlkvl7x8Zn
         NLPxxVJU/WmKI4B87j1mOQDV0R3TC0eff4jQv3ODtCNSiDUg1uWmSi0SwwC4gQYKnown
         XzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846716; x=1697451516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzjqhcxTplk/fjWtjjswcwgpKZ+f2AVwpc+PUpIKpZs=;
        b=ojBXQz4kCda0u/a7aQI3Tz9qMW8yOPLlO+4oQ4R4gE4LyTTmjVbskNPP7mzyNEG2QT
         O191+OnU0dLmgNcJLxtTO2R79a5q6//LEeTFfFe21ea9woyCC8cqpDSOdaiIPvqA9B56
         GFkMOM7C8Njwh2ByOPZ+eVv5Ys1OVe9H8ecpfRCRL+Z3A2zNjfKCyGp9GTWJ5503aoAE
         anTT/Bi6IUJKMWjO2UjOw4oh0STR/niqk6xEwtM7uHmASeOJvASMVSxrMZ1OlfAPMKR1
         sj55+39dS5MM6g7kdDP8uArxyFBZD4PaHIu/ou+DN8qLy5ZJc8LvrxBO+O1Xx14oEZ5v
         J9Kg==
X-Gm-Message-State: AOJu0Ywr+Y7BWuGiCIAxzQwuJniWSZEHTlCAJ3+ka7ntloUEW9pT6WEb
        nd9Xq/E55l36IU7rm1dcDocqkA==
X-Google-Smtp-Source: AGHT+IGY9WKDt7ALyy/qcEMDEosc8dNznZ/T5vS8ZD92++froNBAqLNU25PJBwaTdb63LswVmU9kIQ==
X-Received: by 2002:a05:6512:250c:b0:503:8fa:da21 with SMTP id be12-20020a056512250c00b0050308fada21mr16362091lfb.43.1696846715809;
        Mon, 09 Oct 2023 03:18:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003fe61c33df5sm13038355wmi.3.2023.10.09.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:18:35 -0700 (PDT)
Date:   Mon, 9 Oct 2023 11:18:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4] backlight: pwm_bl: Disable PWM on shutdown, suspend
 and remove
Message-ID: <20231009101833.GB223751@aspen.lan>
References: <20231009093223.227286-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009093223.227286-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Oct 09, 2023 at 11:32:23AM +0200, Uwe Kleine-König wrote:
> Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> the PWM any more. However this is necessary to suspend because PWM
> drivers usually refuse to suspend if they are still enabled.
>
> Also adapt shutdown and remove callbacks to disable the PWM for similar
> reasons.
>
> Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per backlight toggle")
> Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> Tested-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
