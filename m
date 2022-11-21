Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA57C4332F
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Nov 2022 10:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKUKO3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiKUKO2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Nov 2022 05:14:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A384C13F73
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 02:14:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v7so8121641wmn.0
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Dzbdx+YB/boCMO64dCfkzauhQz7NXTFwUFa4JU5m/I=;
        b=qhVVdWUoLbDIiuG/gwGKsCTx8p5RpzzYtUJp/Bg6xnf6S9Oe2ocd9NEPLVpdpfy9tu
         e4XdLEF6ETSp4sCmqb2KeFldyhvQC9EYRzjzA858QRJWFpgygD5RHYzPcbhgFpemPm4P
         xDPvVr6uctICfBhmjJwJMYBqHiqoDsSJijAZiwaSd6ORt5tckHuXqS2Gf6BKNnHtg8CD
         VOA8mLAF7A7HUrKwAqLU2DV4TEE60NJw4WjryhHuAcqqzkmG0EJlhRBUnxqIOjsPDNn7
         c/poaTMOgAaW9uceXs/2Tcgp22Fa7kyat5nUOuzyIFI5SJll8Kngx2ztNjHwWWUHOukk
         L4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Dzbdx+YB/boCMO64dCfkzauhQz7NXTFwUFa4JU5m/I=;
        b=dDOXzM7TsTUAWp8pXivxZerD6LsHmGE6nYybxWHlzu8LXQwYup03OWSp1zaivk5lc4
         10NhRwEUluEJnwf7uoUtpOafme22gTFaUF4k0rqhTedh8v95Rv6curpRSQp+MGFlp3dP
         eHovi+rG6G1ecDoc9C7UAXwjPG5IZi561AUtLYITWOBMh8a1QkfEaO96OSHveQ3/yrLh
         t8g1wAuJwKQOqZE/lZORrgoBnSY3wcBu72ASntVaW4mWtAwXer/wlfjT1oVS7X7WcQ5G
         0BJoxY9ZL4o+PJeTGcxFVFtrTuOTDskQFwyFeWo2n6oA/bM+4IxWKhKcHI7/GuYwPNN/
         zksg==
X-Gm-Message-State: ANoB5pmd1T3t9hEvWrIBI/41bTmmc+w5BJeDHdNh2Dw/vJEPgYlVV2Mh
        8ZFZNd7rodLMPTy8/kozW/44NQ==
X-Google-Smtp-Source: AA0mqf4mZ3vHBYk5iRMjwVfb91H1TAzjZF28Di5vZlwZDO5WrJ4yqKAzbSCZU0JmtUpvWsi6sqMjZQ==
X-Received: by 2002:a1c:c918:0:b0:3cf:f2aa:3dc2 with SMTP id f24-20020a1cc918000000b003cff2aa3dc2mr2879921wmb.175.1669025662121;
        Mon, 21 Nov 2022 02:14:22 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003cfbbd54178sm27381570wms.2.2022.11.21.02.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:14:21 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:14:19 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-i2c@vger.kernel.org,
        kernel@pengutronix.de,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 585/606] backlight: adp8860: Convert to i2c's .probe_new()
Message-ID: <Y3tPe9mAnT9aGnGL@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-586-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-586-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:19PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in the probe function.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
