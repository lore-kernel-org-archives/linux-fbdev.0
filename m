Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6CAC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 10:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbiCHKto (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbiCHKtn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 05:49:43 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590B99FEC
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 02:48:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r10so27837865wrp.3
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 02:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oePfju4fJo1u0s2xutLmdABPmoZWfyejObfpQ2SykO4=;
        b=Kvw4rYX1l2sThJBvtCbIACTNXs1/EIDUO7KiaORWiPElVea4Aug/UYOTP+zjI/JyJK
         27zrtK+BkR4xPR0hwcDn0ewK9C/ltgfxEuBhpij0ZOFUwYpQpp12I2BXFpv2fB8mjRDN
         UJV+7o0cMfCQTraeALyQd2k0q9tinPQA9Rk4gNS2DeucN6mxnz61dnJ0pbmqdvMi8Pmw
         687pFuRIOXgKHJO++mTRgs0kINcItgyzAazm2Kp66ihf5JJYF8X9dU7hImFdFRDTphTz
         B8puYe7LgWXVqP+6wEsz4XGPfSyn+/pVJnxRBuLUAZEyU65MRd35xVsEVGq7A+V+9FQj
         zDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oePfju4fJo1u0s2xutLmdABPmoZWfyejObfpQ2SykO4=;
        b=MIXPTDTYwU4CnHRF6zzgkf3Q61kMw+53mzaKciFD8cFhw3xjZ+QLQ4rNi9M0zoxkzN
         7lzWCoIuiIXZYdTMOuZp0r862oaAxCY+6GR746+Zk8znlGGNQ0rwgxkJU9hCPZ3nOQv5
         Iw7KkCej7Z+toEtf1xv1OFkM+1iFMXj1hZbU4e4lK9P16JX/7BGTKAUxKRE/qkFVRq2e
         4Q7QtxSw1K2QP+8NvqFlbon84H9XDOj+ClvVBilcLnvV370zwl57LrQN4+DdAiLx7yu7
         gnkz4p4LNqPy08cnci04a38HcInE89ADxJtTcePa+y9LpGyBtzQSOVCAzP3eK30fF+n+
         r+FA==
X-Gm-Message-State: AOAM531h3bMilwmu4ZgfK1KSHPhESnxBJUBueTCzsQvQ3lIlxIpx+yJR
        eFs3WfPywHtK5Oky0Xm2ip1gDw==
X-Google-Smtp-Source: ABdhPJzJ87arojJYxVBgmLEfJTdVqi9wnz2y1QmFwmq0HFgSG6F6XH8GI/oU72rHX3ZHD0Ni89Qz0w==
X-Received: by 2002:adf:80d0:0:b0:1dc:90a8:4a1d with SMTP id 74-20020adf80d0000000b001dc90a84a1dmr11506035wrl.180.1646736525957;
        Tue, 08 Mar 2022 02:48:45 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c2c4c00b003816932de9csm1823380wmg.24.2022.03.08.02.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:48:45 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:48:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: backlight: Slighly simplify
 devm_of_find_backlight()
Message-ID: <Yic0i9DFzv3bWoTz@google.com>
References: <f998a4291d865273afa0d1f85764a9ac7fbc1b64.1644738084.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f998a4291d865273afa0d1f85764a9ac7fbc1b64.1644738084.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, 13 Feb 2022, Christophe JAILLET wrote:

> Use devm_add_action_or_reset() instead of devm_add_action()+hand writing
> what is done in the release function, should an error occur.
> 
> This is more straightforward and saves a few lines of code.
> 
> While at it, remove a useless test in devm_backlight_release(). 'data' is
> known to be not NULL when this function is called.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/backlight/backlight.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
