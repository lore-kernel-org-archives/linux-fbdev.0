Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6803C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 14:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiFHOdm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiFHOdl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 10:33:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194F02348D6
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 07:33:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h5so28684235wrb.0
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WG0Tg8LMw+6v7cVOptDrWGidi6Emu/7DP7YsEfxFl6U=;
        b=w5ns9byp/YevaOrUVFMpt6yWKTxidJfob2R42ggpIXdfZryqVTt3BWo/JEXVWZr1j/
         8MQNNoSDO31sJw5ZxAGkWLRTguwolkAR3GkglPLBkfmQicHsLq0mpDWMII4t1rzJpDSJ
         1qHXNvuzp6rjxNOWug5lHVQ1Il0O3D1ScFGdxV1xsT2LMfxiK259cV7VikZuqUCgPH4Y
         abglkbFh7NIHE458XQ+pUluGsmU1Zvwx68tYsCfUfH4jlgyCZa/rIEjXR31fayXJJLKS
         imGwHjwGsoi0YKCMsil6mG/1USLI9QpcLwjnixUtFthbfRihxmZjOD7OcuAzV4fAmJI9
         /Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WG0Tg8LMw+6v7cVOptDrWGidi6Emu/7DP7YsEfxFl6U=;
        b=W1DQjaYTn0WD4HVKEGINesEDHdjzA6xEbaBCugBPJAN4Q9XaIiqySI/s4ePEVabx3C
         ROWp7w5Kfz2Ay5Wi5p4Zm1CRbTco2OYjMsY4FZ8MbHbtRV42JQV89a0ZWlzvqkUcTkZy
         kWw4eb5SVT2YrUKglGhXtRdDfFebT8WXvGwUTl8fFMhXdxC/n8eI9UN1Zy5MfkUCr0ai
         pQ6c4Pczu9XAz0U2THnV12OJcpcx7HOs8YrCqwo4lGwY7n5tk6RbLAlx/iP8bXvzaqui
         rAkNJXiQ7qsF7ZeVAQ/lDwAgdL0Om5EUI1xHEnviSqU/qEMJJgbZUjp5R0LReO/31BxZ
         toLg==
X-Gm-Message-State: AOAM531SNeTXMlbPanI7BgEW2Hq5yz9GB6DHZFM/mTA6JdzvOYrBFOcK
        Wa5yQIHRRpy5VkBkXHermNPwkg==
X-Google-Smtp-Source: ABdhPJxvKQxEHFDay/r4QAKbU2kqfhMU+/AqDh0VaknrdyOg+5OV5Q/qtMdENt7I/tH2UsYyr2+h+A==
X-Received: by 2002:a5d:5410:0:b0:218:5b98:425 with SMTP id g16-20020a5d5410000000b002185b980425mr4976962wrv.243.1654698818607;
        Wed, 08 Jun 2022 07:33:38 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d62c7000000b0020fe86d340fsm21422134wrv.55.2022.06.08.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:33:38 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:33:36 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] backlight: arcxcnn: Use backlight helper
Message-ID: <20220608143336.duk2g75jjnwxxa2g@maple.lan>
References: <20220607190925.1134737-1-steve@sk2.org>
 <20220607190925.1134737-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190925.1134737-3-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 07, 2022 at 09:09:23PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
