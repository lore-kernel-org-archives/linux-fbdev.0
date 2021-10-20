Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2C9C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Oct 2021 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB37610CF
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Oct 2021 14:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJTOQc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTOQb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Oct 2021 10:16:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4023DC06161C
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Oct 2021 07:14:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j15-20020a1c230f000000b00322f53b9bbfso404881wmj.3
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Oct 2021 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lTTo+8CQc/PqPJKiqi3R5Zq/naK0BJaStFZKEFzIMGY=;
        b=XE5BOwdM6MFT8nfQ+AsiilO5q65yPpW8S8VdeV/ZVBQ+Paypnm15C8imeEbuwnAacD
         T3rV6ah/sTpJ/FXMKJrY0ZVTcOFDwin0J2gr/y4/30olLpo3xIX1h4QtY2qcOopSaqd5
         jJsBe4i72ozInsXDeuHN54uccEshCS8FnLJW8NvpGj5wjEZu4VYN+X6AJjVE87wf52Hg
         7cbU649e5ZJxXD9eJvjxv7jsy2GIuCBxAVzzKYmj5AotBhqTJVubv8e3RqIuAtVxuIVG
         p/a6YUGOEBjFi0KbzOtHj+WYFp9DFodSajamhHgiO5s+FKBOVqZWIXXQy7CMDkRGuYvg
         BQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lTTo+8CQc/PqPJKiqi3R5Zq/naK0BJaStFZKEFzIMGY=;
        b=PjDwMo2FHfS8XJ748h0JjkLAH/40tgDcZT2i3UOBSUXXXUn8ZEGQw9pBC0kpFuoItk
         7NwcNVYVryEiZhGjX5DRoII/hnu68Hugu4/o6iLg3TeyLZS4xyU4rVyAZvRxABTkW+yt
         Sx1S3twQ4TVdt2PkdXtHzFfIByqS3QlJfXwThjTeeQY7bKiR7jt1pyuXrJ2wxTDj/ekt
         TtPrCAA+VUWooacE5b1OCOKHryr9iVUBQcMIs5RwS49kCNPC6N9d5kRCkEqHvk8xhrfu
         QIfKKOiVkAX8ExLPI4gm4K9cWOx3R8VR4vbtwVKvrkr5T0CLrmD8niFPvE/aahUY3OhY
         8Gxg==
X-Gm-Message-State: AOAM531eqXOHTOIGjOx3NfphGMyiquOeqV0UCYUjqSyiED3PSV1KNLas
        uS4Q+Ojtk8KR1M3XamDmP/V6Ew==
X-Google-Smtp-Source: ABdhPJxjxE/sse1ro3W61H+27+4b2kviDDXbSKUuInCFapBrDo5me8r3dYXJpqA4sN94WKGQ7AFkkw==
X-Received: by 2002:a5d:598e:: with SMTP id n14mr53432911wri.187.1634739255749;
        Wed, 20 Oct 2021 07:14:15 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id x7sm2094937wrq.69.2021.10.20.07.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:14:15 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:14:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] video: backlight: ili9320: Make ili9320_remove() return
 void
Message-ID: <YXAkNUrm2QI2XNyo@google.com>
References: <20211019120927.3822792-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019120927.3822792-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 19 Oct 2021, Uwe Kleine-König wrote:

> Up to now ili9320_remove() returns zero unconditionally. Make it return
> void instead which makes it easier to see in the callers that there is
> no error to handle.
> 
> Also the return value of spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/ili9320.c   | 3 +--
>  drivers/video/backlight/ili9320.h   | 2 +-
>  drivers/video/backlight/vgg2432a4.c | 4 +++-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
