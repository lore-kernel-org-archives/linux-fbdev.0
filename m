Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080CC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE5961502
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhKPL7l (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhKPL7j (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Nov 2021 06:59:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2CC061764
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 03:56:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d24so37106220wra.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 03:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tykKfzZRZs8W8LB8dDzw5i3CD5rhrU5zWD1WHrFGu6I=;
        b=PdFx29zeOFtKWYfkjdFXu4FzngjheOfZFBdUnmdD06TBxqyhoP6ZiWipqG8zf5x9K5
         Zk/t5mwNF7kmhQ+x98VH6LWeOs4ba9wDFEdZQ4vAan0vTm4HNF+cH013ecdNxfv3/w2y
         Y/G/U+1hr4yNWe0jyu2HzBrH/b1OxP8Nw/r7bgQjDI3vq0eGP+tuYkgALS0YS7LiCsYv
         /4z7Oi7UR2jJs2oMtIIDa8MTnoL+UKxaoccn2YEkC3gXvBxL67XBhKJOc6yxemkZRcnN
         c24vxX82rD3hgOG4IxBEfTTcuVB/r/mUJvyZIsuMLNQDdFjNiFJbaq5WVtrksKSDpiAv
         DWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tykKfzZRZs8W8LB8dDzw5i3CD5rhrU5zWD1WHrFGu6I=;
        b=Nde0BODTlzPw6Q/Kf4CsVySSkNU4GOtgulvtQ1II24s3msQKrCvrPuLx0hOUsPNffz
         Aka/gFrdzo8teEms7/d/6XlRtRfRoG2gpfFCcKW3LzpYmZEKLsBwXdAN32ou/7hXMNV4
         kOvgB3ncEoEdiZk/FFySw0Oa+NGldUq+Cj2S9CuIqxn/zYUcn1LAI2yseaAcCeI6hJEv
         m6RhAZsbM0RHLfnirzTbxCmcKLLaMPEaCAEfmVxf087q0uu5XT5zlGPEFlQ1Fjqw6JPb
         f+U5mr2cpcWbXuTTtUeZrhZ5GIBlR/PAvamT4YM/R87s10SgSFqLgQ+fhW1m76Ek3EdN
         bkBA==
X-Gm-Message-State: AOAM530vJYme7GB6n4h/RV0E2i3uczNrK+CktR3EmXrJbONfXnyC6MOl
        dQI7hbKo+8IdYRmNfTdKQKTESg==
X-Google-Smtp-Source: ABdhPJx+DsVIlJi3qFUEgUdKvjqrCDE8LrH3TXHbTDv/qIgV8UK1fSvVa2mKOiRmfZXNdh/uzdkPpw==
X-Received: by 2002:a5d:6c6b:: with SMTP id r11mr8549336wrz.231.1637063800263;
        Tue, 16 Nov 2021 03:56:40 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m125sm2157270wmm.39.2021.11.16.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:56:39 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:56:37 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
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
Subject: Re: [PATCH v3 3/9] backlight: qcom-wled: Use cpu_to_le16 macro to
 perform conversion
Message-ID: <20211116115637.22v2pluxkni36ehr@maple.lan>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
 <20211115203459.1634079-4-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115203459.1634079-4-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 15, 2021 at 09:34:53PM +0100, Marijn Suijten wrote:
> The kernel already provides appropriate primitives to perform endianness
> conversion which should be used in favour of manual bit-wrangling.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
