Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F2C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 09:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbiBHJYY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 04:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiBHJYX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 04:24:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05163C03FEC1
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 01:24:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1164859wmb.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 01:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U4eTC6qoUMprkOAPi/nq4R8RnDpnU3YMicKdHmccZLQ=;
        b=OjSkWWAHIdktAsoxsPi8byPQ2FeJ3bEHJsUZ77uP4OKAnFUO5xzu8gJgEUWd9BJvBz
         aO9juV01Jl+Jg51nPtatv0IZ7mhfSBtVI2MgFLAD7hRQhDhCKaCghTlC7XJOB4AytX2/
         UAC8qQsvDpuYIsar6dqeLQttRFVBOCGRSP/kOjCVp0iPeQVX5eWrBKnmGyMClgEKMPaQ
         uRN+U37PNeVifs+mA5ddKOWgc4VOK+8xIYZhqyAJQgcBY5ZQN+1I5Ajxr+QzVIjxBQax
         q7lAMPJoX4Cm4+OenG6xR9SaqiNfcTMbrnGzlg7YTuXhm7VnbLDUwDnsqIjtdsDoePeS
         agyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U4eTC6qoUMprkOAPi/nq4R8RnDpnU3YMicKdHmccZLQ=;
        b=B8h8z2hvDITvCn14OkqlNthLnwX8tZftbLbSgK3vrHCrp41fdVBfAE1Zs2xFiJ5D9I
         zmLf+kTJBakC1VRkyGt/0lhHvOVlTNh3KgwNCK5MM6O7mvElgKNM2xjuXHJ9M90hIvsc
         YyNGwd9RwXns2wmjLqZaJmsyFBw9voCRRebqr1S/6x1mCHF+hBetSxlU++ql8qZHCeID
         NsyRRqiFyd0RlDkKM08sq3xjTjtqFUQoRslSfwOyvyRBQlHhW02gtbEnhJ6gF0m4Ic1X
         IqJgfNU9bB1YR0s2OTeMmb4vNJ8wYVQKFaqIW82JUqL0L8zQ8WUuGarDTt8ajT0RKdA7
         X17Q==
X-Gm-Message-State: AOAM533C+NLOijmkpwRvpcvUE0wdlNBwCGEgNNI3vaDRNL002xzcymI4
        K/iqeALDrqpf1z+cfStGowA+Lw==
X-Google-Smtp-Source: ABdhPJyETs0h54mjP52R9i4urCVEkYxAlnNZHIWK+XSjvKFVpOSKSwgint1uilZINo2Imx/EJawJvw==
X-Received: by 2002:a05:600c:4e90:: with SMTP id f16mr274231wmq.175.1644312260622;
        Tue, 08 Feb 2022 01:24:20 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id j46sm27994wrj.58.2022.02.08.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:24:19 -0800 (PST)
Date:   Tue, 8 Feb 2022 09:24:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] backlight: qcom-wled: Add PM6150L compatible
Message-ID: <YgI2wXYHjrcsF40f@google.com>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
 <20211229170358.2457006-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211229170358.2457006-3-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 29 Dec 2021, Luca Weiss wrote:

> PM6150L contains WLED of version 5. Add support ofr it to the driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/video/backlight/qcom-wled.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
