Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27536C001B0
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 14:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjGEOd2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjGEOdZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 10:33:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1931700
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 07:33:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so76794425e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688567603; x=1691159603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQUXAkyiQApMq+ZE6mPnwyJ3KTToGXwRWpzxeS6gtoU=;
        b=TP49Ly4bRH4lLTT35h8wVfAwVxrJgc8Hm8iAUo+nhTxeYBA+AKk1HSKDGzn94tP3jJ
         /UIxJ4/uo8yuFDr/vJUsJmog42GwssD1cqtABp7hqCH8wmX3QJ92ttJqCTg2dGDN2OGm
         rDcsmLUR7aL3zpWnpNRYgW7Pe6E6+onYViN1i5ZyhJq+in7lkAX5KFaZr8Oiq/8tPWzz
         o0gw3qO+o6bNrEqL6giVppiT7lA/FpOF5OYwCN2/Ze7DwE+48Pb/gJXVuNiID9PkG3LS
         4RinTWPpx4VsGESZDsQ1rXLnLtquh+aKBRLdw9D+xY1KGPufXXcKZwLrW5hr6u3akx8S
         UgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688567603; x=1691159603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQUXAkyiQApMq+ZE6mPnwyJ3KTToGXwRWpzxeS6gtoU=;
        b=GwNgVlrbp9dEX4RAsYIuMFVEipIX3YuVlqmSvcloBokUQs3td0wkCorqAAgsTPVmfb
         UOGyERs9eqZ/rUQ/gEu/5I85tWrbmXloTgw6diQaxJqeTwT+7sgqODvmBWS0S7HvpEDN
         w98rCSBpLMPSzCllEC2vJ+VYBE+tQrgAE4XRuRnFPCvo5ZHwllcs1ew8tz2vMraIpXft
         6HXZvdA/cWOSaEMlk0gy2JDSjPlfKtYjfzSJSlUsOR1rvgsTtgIvxV7FPtLG/fkY3g1P
         wRHV2pYa/9Wh1N/OXvPbz1pizm3kRydlD+TaWco8v8RaLKJR0YuZM8SkgCPTV5vY8uaO
         mxQQ==
X-Gm-Message-State: ABy/qLY+IUjV47XDkbKcy5FZM+J0lTRCQ4aHhhBr98QsJ7d7Vpu730OW
        XuUPGZ7zR4H0cuhNqFZFD9W+0Q==
X-Google-Smtp-Source: APBJJlEcP9KsqrX0torxAaick855DXdlm/LSXir4ylL4od030uqLUgvwXNO/rx9wm36ZF/1GfIK8cQ==
X-Received: by 2002:a1c:f713:0:b0:3fb:d72b:b2a0 with SMTP id v19-20020a1cf713000000b003fbd72bb2a0mr9242635wmh.6.1688567602750;
        Wed, 05 Jul 2023 07:33:22 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003fbda7d2d41sm2280190wmj.48.2023.07.05.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:33:22 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:33:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
Message-ID: <20230705143320.GE6265@aspen.lan>
References: <20230705142447.15546-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705142447.15546-1-mans@mansr.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jul 05, 2023 at 03:24:14PM +0100, Mans Rullgard wrote:
> The condition for the initial power state based on the default
> brightness value is reversed.  Fix it.
>
> Furthermore, use the actual state of the LEDs rather than the default
> brightness specified in the devicetree as the latter should not cause
> the backlight to be automatically turned on.
>
> If the backlight device is not linked to any display, set the initial
> power to on unconditionally.
>
> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changes in v3:
> - Add comment

This mismatches the subject line ;-) but I can live with that if Lee
and Jingoo can!

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
