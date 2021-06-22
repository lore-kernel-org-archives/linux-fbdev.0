Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA1C2B9F4
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Jun 2021 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE1161040
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Jun 2021 13:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhFVNN5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 22 Jun 2021 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhFVNN3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 22 Jun 2021 09:13:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A5C0611C2
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Jun 2021 06:11:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so1102594wms.0
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Jun 2021 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4ClenBNFnPWHMhqejsNe5gaf74Np+yZIMmycF1fngD0=;
        b=cikWR6oES/vEFxXcIF4Otrr+lOBxkB0bxRhNQz40xIxkZEwqBUL4rd+XEYhUiPy02A
         ld7jETSbFZNw0+94pqVncdWGaSmXxWiHls2XS40Yujxuap0EjZQl+za51D7abFPAh0jZ
         alBZBfTL/WJESu21EaUjmVbjv5PSMT+2uZ0lLo6A4YWvuBpM55Pnzlh1wAmqd/e1/+My
         /mtj535QVBJzQYOpdFcNwcPEPULDIWEHQwHSbihdzlv5VqOzQ23atTaognM8FyimQWG8
         lmK7W3Tl3pbXE/PjZud6cEGliygQ7C2RGefzBZD6z0lazAq0snJH4cpNKari12+h/Oke
         X1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4ClenBNFnPWHMhqejsNe5gaf74Np+yZIMmycF1fngD0=;
        b=lowKgfSkvznfazGLY1rE5c+THBzTBLomR4rlMtQdmYhNjcjrbDrZnTYpCFvyRVDWBo
         aXCL7Nh3tIp7FuUPWwa23K7LsT1GyhV7icFs135X9aNqOD0QRtC/keP4CgfxGEr9mbIb
         8+KugSRpdpP1tGqFC4wkqr4r8ZR/ugdXEvshfaSIXHRtG90ij+pTgSJFJpJxPSvfLg9d
         KnDN6yeJmLY0X7X8ScnvDjhhteIwGDk5zAUvCouAMHnlhFBwx7X34POjh5VfncNBJ1WM
         ib2J1aFAKlr1Avp+RMu3kKf5JEiEdfcVk881xOxReB4fK0RtZLfRGgd2sYkHSoHr6SlE
         f7rw==
X-Gm-Message-State: AOAM533snOiGPrBwWE6op3YbQYYVw1kx7uNZYZbK1EFn/OANDsCBmFJe
        9Eh5ycZDbg2j88Qn33LBd2+hMQ==
X-Google-Smtp-Source: ABdhPJyd0ZBEfT4naKU/aoV/BVHri+673sPYJQn0GQx2PGKHw3++vn5T86SrhOVGaXeBJcRhs2KDDw==
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr4496387wmd.22.1624367465132;
        Tue, 22 Jun 2021 06:11:05 -0700 (PDT)
Received: from dell ([91.110.221.181])
        by smtp.gmail.com with ESMTPSA id c23sm2482647wmb.38.2021.06.22.06.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:11:04 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:11:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/2] backlight: lm3630a: fix return code of
 .update_status() callback
Message-ID: <YNHhZRkKFoucAyQJ@dell>
References: <20210621122148.116863-1-u.kleine-koenig@pengutronix.de>
 <20210621122148.116863-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210621122148.116863-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 21 Jun 2021, Uwe Kleine-König wrote:

> According to <linux/backlight.h> .update_status() is supposed to
> return 0 on success and a negative error code otherwise. Adapt
> lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status() to
> actually do it.
> 
> While touching that also add the error code to the failure message.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Fixed the subject line for you and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
