Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D001C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Nov 2022 10:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiKUKWt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiKUKWr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Nov 2022 05:22:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675913F18
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 02:22:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d1so7000391wrs.12
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTOHRzceQYVbSDGQhGLsG3F76+dMRPGYLu5KqgSSAiM=;
        b=LZ0IPSCDo80aHrpFHT2RbRfDhrEM8HzMSN1EyZP/Tb3gPrJ1qucGYmhr3Z97MBwJjb
         HLcUq7b56VOCopXtILEmmsotshAJyTeCJJwPKS7hOww4zyhg+xtCOHWeWSMfDdQhVW67
         s2KdqyT//VhTNhG7F2lytEKXx2jdITXPZ/PNxsUB3CxAT9XDTwPfXifiIhMzMeOF83eM
         ciiGNI7r+7dUNzjZNsHTwlfzaLLMXr+fjalYsSXpK039uMO59MGK1gm8HO1A56vkpW/2
         465WplN1OHOw2pmtawR0/RLuJsQlBhyMwVa16+njzup3ADQkjT6UkkSaXFblRxWJZmzI
         Q4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTOHRzceQYVbSDGQhGLsG3F76+dMRPGYLu5KqgSSAiM=;
        b=0Aa1U9vsw4YhvoX4moL8FlKYkQsgoX2XCmOvfm9hg4jTwk9D3o6UaQn8/Ddgxxk/tb
         tDWtoNTDP49VJuG5MTK3A/S0dj9HYrjihTXwYz4ZM0A+GzxFYSgrZ0KXoDclMNQOmJTt
         CXmSyernxEQH7L/TTv0n+BXg07QfTOmNGBXTtVEXINglpI+dgvszBJRnzgkjlZEVcMwt
         ZPDL9Kk2cKcEJaYdbpAUDIyB92O/yM4nlXwsCRp7uAFxiB/+yQv1skrGDc9t3AOPfT5z
         VTpQpd9Z8hZfNeCliJ9wmQEZBt2pXcOiJyho8fhWTy9ySM088DpbtL9K44+gYDJC9EEl
         6bCA==
X-Gm-Message-State: ANoB5pnhCVkebHtEJ9LAshWTgVn7jLiJBlEKnjc1/4qh64yTvz4HXBPv
        ynYw4S6q5vqpb3/AxyiCzzgLNw==
X-Google-Smtp-Source: AA0mqf67/fMDHSu3j27cQjDIa1ZpZopwDRvpBD/uQs/oea0QTn+saXwNsfAKQLZBdoagr1e7hek2Bw==
X-Received: by 2002:adf:e347:0:b0:236:76de:7280 with SMTP id n7-20020adfe347000000b0023676de7280mr10897544wrj.194.1669026163781;
        Mon, 21 Nov 2022 02:22:43 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id a6-20020adffb86000000b0022cdeba3f83sm10864175wrr.84.2022.11.21.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:22:43 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:22:41 +0000
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
Subject: Re: [PATCH 587/606] backlight: arcxcnn: Convert to i2c's .probe_new()
Message-ID: <Y3tRcRJoURo/NTgt@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-588-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-588-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:21PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
