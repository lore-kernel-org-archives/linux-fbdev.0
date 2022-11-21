Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BC7C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Nov 2022 11:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKULQ0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKULQF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Nov 2022 06:16:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B11C2865
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:11:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v7so8228671wmn.0
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 03:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TuaUGDgXnCpLOv12BMouwM4UOCrJ0ikAuiiKIwp8g1U=;
        b=y4KKgF18QaAgNAnvvwKab5m1wkiwC3e9zcNV+IuK9OXZe+tNbuQVNvFGLR4hRWX5He
         kB8iilZFgVaUe51BA4yROJ+kSvO3TYp62m4Fi9vZP6iuY5L08/QGWmeYsS9KS06TBiyK
         xJVmf43xN07AFD6OfFPOjkwx6tKDLdqqmYhxZ4L4iV1SSXUPl8+8N3OvWTVLweEKE/dg
         WT7p2W2GB6/GwA+jfV/ntSwClAxsAsCBxWJqfpo/hE+jveKblZA36/wI+VBEvAOxZniO
         pcJYS48iUDDNVei51d8CXtKJ6k2IhRFr9E9vHlge/THdkwFO+PUXVuIbkx3JAXFkam0e
         5vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuaUGDgXnCpLOv12BMouwM4UOCrJ0ikAuiiKIwp8g1U=;
        b=Sx8iAfs+w5Z1+ZCBWUFhtvQZZgjjyEuGfWOD36iwYT9eKKS/Vn6ETQvlKMCKoAtilk
         B0dOhxhVzQ4dbmAkS8K0plGIm11LL1/djpkxukALoUP6mG7GZDTltiDhCeBh3TcaF108
         24AMYrTkk8fwWeFzkMlmJMddgCkJgKFTpKtXsPb5KffX6iZeAbIPRYSyMyp36YOT6/BH
         T3O8gVptGDAFhVEcg5cWy9Y8+Zhl0lu470LVP+0B71YE6qbJ6X/RR16UamkzJuD+D2EZ
         8DE2SQgV6ToFNxhQfakvq7uE1vEZf2Y4Pgz3B042+rZ3+X7x9RLJObrhrKn/8dFd220o
         VvgQ==
X-Gm-Message-State: ANoB5pllcwhE6DsKMm5ecOKUoUNXVjQaIJjo8Z8aCILL3k+5jMj/G8cI
        u9yxR3QbGDCXPy4+jzP97PJzsA==
X-Google-Smtp-Source: AA0mqf4/URPwCl5Oy5aMSPG2azSdKyv87pmdAci9Q7T+z+ChDsE+5kzfd4s0Mo+L2g5DpI8nlo8S4Q==
X-Received: by 2002:a05:600c:348d:b0:3cf:88d3:5685 with SMTP id a13-20020a05600c348d00b003cf88d35685mr5655901wmq.38.1669029080500;
        Mon, 21 Nov 2022 03:11:20 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003c5571c27a1sm16645135wmo.32.2022.11.21.03.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:11:20 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:11:18 +0000
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
Subject: Re: [PATCH 593/606] backlight: tosa: Convert to i2c's .probe_new()
Message-ID: <Y3tc1hfTpZ0uTLjY@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-594-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-594-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:27PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
