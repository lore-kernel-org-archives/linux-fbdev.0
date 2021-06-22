Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CECC48BE5
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Jun 2021 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20D960FE9
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Jun 2021 13:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFVNPS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 22 Jun 2021 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNPS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 22 Jun 2021 09:15:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19BBC061756
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Jun 2021 06:13:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb6so34366408ejc.10
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Jun 2021 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KGR/V7/heOm1ODCqsrRncyGJUsTeE85nFekDdwDYzNU=;
        b=EheAH1Cz1WWsjTIJcZUCqQ6Ot4TNrkNjDfoIBYrWNkD00KCYDP80HL5XgCSbDJzdnz
         oQVEBayaa2OEKDt2WjYl4Yh8Sw1vfH9X3oqNUJwNfbH74NSAPxBmQ/KFP2pqA0VTTIcB
         S/JNuhiCW9bdN5sU+VhHpgtSXVVzZbiDZRjJ5o450gZ+Lh0CiYplvaKvSlkKxLMvCag7
         k4Bsd6pxnnk1ruYYUNb3a5xxRnfmO9lVw+D5jFnWADHXZOIeA75Z2DBTd9dN+tbjKY0C
         TA0MC++LUw4SpzzKClLUl59U9adxmL4hjzaDAuogGS/pW/Yfcj8XaheI5zBYyPUkDkgm
         AsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KGR/V7/heOm1ODCqsrRncyGJUsTeE85nFekDdwDYzNU=;
        b=sKh6GZdyX3rBObKIg93cKet2l0D/86uXMBvkdMThB1Gxa6GU/Kn8XbjOhx4O0D56m+
         W1pxEEPMg9mY8vZq7OT2OF30DVaOWJNbr+ZUhNyYyAyoiJgkL2F2URY96zAMQ9ZbYgUK
         N/VxrPqWftQbjZsqhjLu9RmAKfi85W5RC1q+hsMd5TCAe+a4O2or1siQ0dhmQ6bmboaJ
         HPXeB6bezLyFY6KNzEqoln4zXI0AV0q/UORPXxIPcH74uDBVwZlorDCVcSsR9JE9TawL
         dzvYBKq3vptrWgvrB474AYfCXIajgjwp0AaxnyBKLPN33zbewE3dvGu3UdqgW7umNh6d
         g1Zg==
X-Gm-Message-State: AOAM530EBX4F/s9slHxFsB42Dy2JNReHhhq9zi9cfBlJXADEa9wEa0d5
        3c6KqCMfCby+kwHKmkcCkAa3SA==
X-Google-Smtp-Source: ABdhPJw6hZRz3q9lseuwDw+f1EYETZvPbOGRNjWLhiZeL2HxdDKfmQqVaHA7GgYZfQZ19WzYcZfLLw==
X-Received: by 2002:a17:906:2bdb:: with SMTP id n27mr3987193ejg.312.1624367580615;
        Tue, 22 Jun 2021 06:13:00 -0700 (PDT)
Received: from dell ([91.110.221.181])
        by smtp.gmail.com with ESMTPSA id o11sm2362659wmq.1.2021.06.22.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:12:59 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:12:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 2/2] backlight: lm3630a: convert to atomic PWM API and
 check for errors
Message-ID: <YNHh2cdcyzLWSCkK@dell>
References: <20210621122148.116863-1-u.kleine-koenig@pengutronix.de>
 <20210621122148.116863-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210621122148.116863-3-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 21 Jun 2021, Uwe Kleine-König wrote:

> The practical upside here is that this only needs a single API call to
> program the hardware which (depending on the underlaying hardware) can
> be more effective and prevents glitches.
> 
> Up to now the return value of the pwm functions was ignored. Fix this
> and propagate the error to the caller.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 42 +++++++++++++---------------
>  1 file changed, 19 insertions(+), 23 deletions(-)

Fixed the subject line and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
