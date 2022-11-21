Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0200C4332F
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Nov 2022 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKULGT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiKULGJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Nov 2022 06:06:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584A5D682
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:06:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so10148398wmi.1
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evsmNawcwqO6lha6bUl7Gf+9LrN+sO/Pwn+zWyJO1wM=;
        b=G7QARcYbyW9f0dfiOsuBOrzCi/KpTEH27qaR9M7P1StW3Su1gT/rmw6fHc+4P/zfIf
         hkSo6DC9X6i+YByHPbQiIJTE6T9n15th1reaNS1U4nfIuDwCmGFuIir81EODva9IqJQJ
         RjnH4fy8CwH2PD54C7YIcoeAq+yo8qq04nMIhz+cNHYwO7hl12P07Gp46hvFgltwXK13
         FS3Z/QZ93naI77vLXZPWC1xmUvSYPXkReYh6jb0QtdMw/cO9J7L0XxniiOAomxKljHqo
         azsgIR5KmfZbZsAL2q6df0Nk4WPpV6ELMjGg6LSMFb1T5QyK2pnlT8jpvjNUT+B2/z0z
         /j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evsmNawcwqO6lha6bUl7Gf+9LrN+sO/Pwn+zWyJO1wM=;
        b=gNp/eoMgu9/DgdIzmkCfw19ZEULdEJr6pDAfzajEWPTKiDn1VQtFK/BiInFfhERy34
         QbWD1RUNoUDyEeW2AimCM+m8aDT6+lEgxhhTmfOnLiu+X3JzsC2p2AT3UKMwFyAloTHH
         Ba6EeTydFwH73rAD3KEzljBkSQc74G9FuM37AbL4De48qAqfK9EU07qHWqaEVrtN8w3Y
         eYS+Jzhv/T83HMVblsnHB9T+3+D+tB7KJ7EnvoHrylme4vK48w6zPvwPEVnBMqGAcYH+
         zR7DZpClGtQFyyLmOhhfourf8z5FawpP/L6esoZcApxHjureAmxfJ6hLL81Z9rGP/SvT
         ToOg==
X-Gm-Message-State: ANoB5pnigKlTpqgZ96QbMR8jAv1z/fZANci/vcZCsyAdvw1jbMFXmMOV
        rMx9+PHiJYpa9N67j2wZudvLUw==
X-Google-Smtp-Source: AA0mqf6lVXLamDzYQYOoqpf6gqacemtmk+Na0iIl6z9H0biRW1QNT519RrWCrVA/rY7FWftqZiXvzw==
X-Received: by 2002:a05:600c:a41:b0:3cf:895a:b22b with SMTP id c1-20020a05600c0a4100b003cf895ab22bmr3567784wmq.81.1669028766360;
        Mon, 21 Nov 2022 03:06:06 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003cf774c31a0sm16576295wmh.16.2022.11.21.03.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:06:05 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:06:04 +0000
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
Subject: Re: [PATCH 589/606] backlight: lm3630a: Convert to i2c's .probe_new()
Message-ID: <Y3tbnHgRScTsI+o6@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-590-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-590-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:23PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
