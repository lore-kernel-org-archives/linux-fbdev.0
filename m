Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D67DC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jul 2022 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiGMILp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGMILp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jul 2022 04:11:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E0E95EE
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jul 2022 01:11:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so14415325wrx.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jul 2022 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w3mh7mSgOdwjOte1AQXmDns6aE0VntldMF/fOySoyz0=;
        b=uCrAA+uzPAWxLWCGb4PkG9dXnQy25fjY2FJphWgJuLK+++V+mJWdRDrLrB1pwl6tn+
         mBscwpHrjnFK+uWfxkYUL9hLFrjJBhB3C9cZSKxWhTt+Kw8mUt/oXnDJiyseGQ8Sa9o3
         a96/37rjL4yt31+2z3ewqsOk2x5din6PCBQA2Ywc8OAsVIVJ7lufUsvdSnYv5zE1NCMU
         zEd72FWpbLn14QkBP7gfXjuLZZRoJwm4yNSNg3ERqPVh3U9+M3rlxGwgv3+XzM3SpBRl
         tRxhq6fDewKvNFqThx36ZjEIp6lKDT0+QO9ekStVMJsBY9UO45wYN85ZTfLoZ7Yy6kuz
         1iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w3mh7mSgOdwjOte1AQXmDns6aE0VntldMF/fOySoyz0=;
        b=182pzgkpq3zTCT0A5oKb3zRWL46XEY6hHGAR2IE9a2nDlh6dh1hdelU2lsvmVOzzm+
         xzcf6R8XN3fxYJNEDmBKEYLwSOxSSjgaMo94+h2a+dIkGe3SsOBDPKRKJ2DpMmolwRCo
         mvijavBlHb6aurr9I/pFWIHnRucxnLymk15Vx+taZQ88+Hb5ZjnrMqTOc5FnrFlSAZ5i
         BYJxRzzL11aP+kMDQeNCNlbTnVL0IgI9n9FaT0kJm96tLxSFjz7ORt0C7Ps/6UM4u3cO
         Q7Ns8uelk4rsjR/NcFECVBm/rm8094gWvaZ/GNQ1WdF1ibKY3UGMfcRITDwKDV1zWi3r
         S1fw==
X-Gm-Message-State: AJIora9/6m+njb1FWzFzWmT0r1K++VlSUywg+WXejwJt9rx3BV+zqLaL
        ZfwfVub/UDz4hwj9EYFJalzxFA==
X-Google-Smtp-Source: AGRyM1vXUPhWcRP/h8EOhUrcVZT9zzgiwiQSjeNfCyeXP8a0q8IfaM81cuydW1W8bgSk4nlqDVWyWw==
X-Received: by 2002:a5d:5683:0:b0:21d:8013:cdc7 with SMTP id f3-20020a5d5683000000b0021d8013cdc7mr2029245wrv.618.1657699902753;
        Wed, 13 Jul 2022 01:11:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u13-20020a7bcb0d000000b0039c54bb28f2sm1311516wmj.36.2022.07.13.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:11:42 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:11:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Jingoo Han <jg1.han@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drivers/video/backlight/platform_lcd.c: add
 support for device tree based probe"
Message-ID: <Ys5+PH4ig049cavb@google.com>
References: <20220629210024.815761-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629210024.815761-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 29 Jun 2022, Rob Herring wrote:

> This reverts commit 52e842432f36d5b15227d0ee0d2aa3d2bc3cc0b2.
> 
> The DT support never would have worked because there's no platform_data
> providing ops. There's not any documented binding for it either.
> 
> Cc: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/video/backlight/platform_lcd.c | 10 ----------
>  1 file changed, 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
