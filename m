Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21331C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 22 Dec 2021 11:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbhLVLSk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 22 Dec 2021 06:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbhLVLSj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 22 Dec 2021 06:18:39 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5EC061746
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Dec 2021 03:18:39 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so4288744wrb.0
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Dec 2021 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BTFrGRijmyqVtwNX+eYj7uLDLDEXDa8YjLzuMRD+fi4=;
        b=n1wWbc5/GBac4/7gX+mStLNdXD+9ZndYLSDI5tNU/kz1pFG6iO/9vDLjbq3DvBMd7w
         XDwjYdZrCF3T5s1L15XEHfsQe81DDgZNTBJGUXvkDlQdIGA71FSjMEnYgn3gz3LbqQgH
         JgGkm5YZGWh6e0AyCb2sK0g9PiUEL7B7UieKYvrzmgObGqfRvPMPKs0uhSUk9RJWHsCM
         V8dbXY3DQADZK5nusdcU76Fmwe4y5LKKgYmD4niSo6OGjcvhaPt9OJvsuQ3MrIPhmLow
         8ClxdDLz+f99tFS5ABAYB4WeonMu7CrFh5Vp/if6pzBieskOCnPyBORKZDHVlCyGhLLM
         CBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BTFrGRijmyqVtwNX+eYj7uLDLDEXDa8YjLzuMRD+fi4=;
        b=07hf3G9qc2pMyhZ0Q82aAFCfumttCF7TxpxgQVAhx8PpMz7D6J01e4MOkIVbZr4ivW
         fG4qiiF7obnnkOax3ShjS65X01JL2O3nbkeTnfx1SQMRJj2pcyRzQSTTM1JdlsJVUvrf
         NQAhe+F9TI8O7YzBV5u2/57PYJOR7UjwDWozeRhtCkni0euWKilqJeUHeQ02Bqplvy/C
         mgbiLyamDWzaaQAxUeOow4r/Ey7haYYCEfc/ihv5gNnw1tG93oC2BsNZZkJ5wCjpGmZz
         u6cDXis/inPj+gKe+deMbrylSQBP3vm9c4E0G3HgSf5ZkdlBVpkENM/bl1ZLmjLMsGLh
         2drA==
X-Gm-Message-State: AOAM530l29fgNye2FUhhyj3/mEe6MQ3/PWJyZwoD+sW3HFlQ7NG7C/3Z
        aYh+Qc8mxzvLVDZGlNTrsU81fQ==
X-Google-Smtp-Source: ABdhPJw38s9cSuuBgFo9+w66UfDHy3rKbuDjgI0szZLbSoZofWuGha24IIq6shTkSBB6qomoMhNtng==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr1750277wrw.353.1640171917614;
        Wed, 22 Dec 2021 03:18:37 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id a198sm1460546wmd.42.2021.12.22.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:18:37 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:18:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 8/9] backlight: qcom-wled: Remove unnecessary double
 whitespace
Message-ID: <YcMJi5Gpx84zaau6@google.com>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
 <20211115203459.1634079-9-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115203459.1634079-9-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 15 Nov 2021, Marijn Suijten wrote:

> Remove redundant spaces inside for loop conditions.  No other double
> spaces were found that are not part of indentation with `[^\s]  `.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
