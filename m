Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED6EC7EE2D
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 May 2023 10:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbjEZKig (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 May 2023 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEZKie (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 May 2023 06:38:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EEF128
        for <linux-fbdev@vger.kernel.org>; Fri, 26 May 2023 03:38:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so4040805e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 26 May 2023 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685097511; x=1687689511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqVVAm/y1HoALh+s361erx7bMZgCxQRFgtpi/v1PaKo=;
        b=HJ7fBVJqCsT5R4//AmW9AScNLLApXJA8d/6S7+0FY9YgxHH74VnQpWwCehPoOdr0wq
         SQ2JuvmK7sm2lA+i+BrspdAKh4JaEWD2AzLV6FIjF2d7I7ARoWcP75ZGPe3VoV3TouUX
         IFsE/VaWeFtVv+mcA4umKZORliI1NLDFlPa8O/NLaC9owMTeCLNhJrzWzxkHyPF91Phg
         Yw13DjWeDFiBMeKO94urScZMETTyzG7JWyUSgr0OIbueJhL17ZDbdm8bGjcQLXcB5Ps/
         RB2Ey9BZUFnKYilXj0DM97vYkgULbKziaGJx4rJaRpxlyrTiwKssm4TGN1ASwks8GDMS
         VZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097511; x=1687689511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqVVAm/y1HoALh+s361erx7bMZgCxQRFgtpi/v1PaKo=;
        b=kovjYUd2MyaRm5D0TO82il12dHmE/tbhbc744c6VcXUNTU87humUmKJRGeGkptKr+P
         Hab8voNk0MnNZ0rUgohY6luCpek6r/JaDQDQg4id/njoWDLn3nTVrcRZb4OZ9auetgL6
         p83pglm4Q5kX6YdlFVwW5KmVCnI6z7BlxN6Ul8LvTdG3IMbJjzLFzP7NO59oSuDrA7ag
         OjsC7TvRwEOMOl7SyEAISN627iYkJ1+RSxFrzmxjBqhmJr/4xdu/tRzLNiiJbk5ARmEE
         KZgarTIvnZ8RIW2FK3VOs/wtD/HaT13z1uPxDn5+pBug8ZxIzjyRYyht7JanoyKfTfXf
         gLCw==
X-Gm-Message-State: AC+VfDzMCAy822vkCJe2YckMOg0lsd8CUNBdKM4cywSoyhqpZDprevqo
        x0kIQStUH7LI8R834ow/oJEMNQ==
X-Google-Smtp-Source: ACHHUZ656Zt2yUkAzWvrDGzkUWXOvr37WPMqjvtf1rRfMMcu9S7heLTHhVOVYRLwpW1FUroNPr92DQ==
X-Received: by 2002:a1c:f40a:0:b0:3f4:e853:6a1 with SMTP id z10-20020a1cf40a000000b003f4e85306a1mr1350782wma.38.1685097510904;
        Fri, 26 May 2023 03:38:30 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id x4-20020a05600c21c400b003f0aefcc457sm8460239wmj.45.2023.05.26.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:38:30 -0700 (PDT)
Date:   Fri, 26 May 2023 11:38:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/4] video: backlight: lp855x: get PWM for PWM mode
 during probe
Message-ID: <20230526103828.GE626291@aspen.lan>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
 <20230519180728.2281-3-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519180728.2281-3-aweber.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 19, 2023 at 08:07:26PM +0200, Artur Weber wrote:
> Also deprecate the pwm-period DT property, as it is now redundant
> (pwms property already contains period value).
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
