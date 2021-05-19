Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F84C43460
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3615E61363
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 14:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbhESOev (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 May 2021 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347445AbhESOev (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 May 2021 10:34:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78ABC061760
        for <linux-fbdev@vger.kernel.org>; Wed, 19 May 2021 07:33:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so3457611wmq.5
        for <linux-fbdev@vger.kernel.org>; Wed, 19 May 2021 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DCQ/kFDivgK7GQNYhLKETXZZY70HNicwNr4SprqTshM=;
        b=thuJugNL923dMzFnEsVGIaIZZZrP03SU5WUwFJ/UlId06Fx0wC6czVpNH8MRjBrVSH
         Fw8hYXX9gbUBKkxhZupMKfoUnEiSlS+eFGv6OO33TLzo37AfZaxLMXQyPvdaGVrPAEYl
         CP49oxYDuaVorakDyLwZExpae5Z2LY0E1rD+AlhDeq7o7KctgMKZn54BiGptgXqaaF2I
         sO54wDuqUU/+iFx+/PASGI7pk9Szld6LZf50aDCv/nlUIYbK3z60Mk4Y8270ZqAb5/JO
         a4zp2vBSKO8uZrejZTUQa+FKV58G5yoRd3C2teZ0nEdcxOzc24Momse6vpHa+yZ0de8r
         U0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DCQ/kFDivgK7GQNYhLKETXZZY70HNicwNr4SprqTshM=;
        b=GMf/oRsa5dYeHPxDyjCOD98iUjI426y31q17o4bqwN2zM1ojApGH0PWP76jTGulCvX
         Ow5xdC0S4CvKMLaC7QPCrP2/hCKf2SqLDASw0osgg8+37cjFOcObRystWGJbBzLCbjkH
         uoY5y09oIht9HNkaoHeRVyG9khYmgYsaMPYQoq9JO2hsOWmdwuV/RZSdZiZ17wgs93II
         6Mwcvn2VNVbIFAyXdj1P++h+2q7urkIAVt+iSLeysnEyMI0QHr9J0i76Tile6sEu6qdy
         /j3Hn9fJ+BSXdQLq2tkJj00LCniZ12Zlbe8MTMaZTbzyVOOTvUZqiwTJ7DqU/F/Q8Jw4
         FiWw==
X-Gm-Message-State: AOAM530N//80vnRGswsO75hHWzS9YjVUc6tpnqxeRmrpl7Wgd17MM4JK
        QoLMAjrUSMvChYfcVdOJMpp+NNSYBip+5w==
X-Google-Smtp-Source: ABdhPJx4JB1bRalzDlI4ShWWTZFpYU2OBLRYrTfkbbKxLsPeJCa1PyVKw840yKYR+zYU6HfFI6ZKhA==
X-Received: by 2002:a7b:c742:: with SMTP id w2mr11918923wmk.76.1621434809298;
        Wed, 19 May 2021 07:33:29 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id y3sm2894271wrh.28.2021.05.19.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:33:28 -0700 (PDT)
Date:   Wed, 19 May 2021 15:33:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v1 1/1] backlight: lm3630a_bl: Put fwnode in error case
 during ->probe()
Message-ID: <20210519143327.GE2415519@dell>
References: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 10 May 2021, Andy Shevchenko wrote:

> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: 8fbce8efe15cd ("backlight: lm3630a: Add firmware node support")
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
