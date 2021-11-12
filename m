Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A913C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Nov 2021 12:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4090960F70
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Nov 2021 12:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhKLMW4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 12 Nov 2021 07:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhKLMWz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 12 Nov 2021 07:22:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE06C061767
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Nov 2021 04:20:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d24so15245508wra.0
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Nov 2021 04:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekAy44bxYcE4719//M2Agt8con9V746x7iZRtQHtp3A=;
        b=okzkqHjBZhid2abmaHx79x9eNG6/T+iOIjm6zgNQbmIFT8x4OlzM30xm3ucTjnGCkR
         I4ZBb1525SOlr9Ff1G4y7d62vfM/T6bVzUqr6pGIQt+utmpXt/4Y0wJqnf47tTeSDU0B
         lYFWM7TfLIL3I28tI4DIaTepVZtoShvE2QK25y4cjpjmVZaUM+I+nQUNxsUEoaD8A6NA
         SNLghy6rvhZY7SvZagFN1WBigiJ11hUB196wDUflqhlzkEiEGfTc3yeF/OiHQGSGnFo7
         SP2Mcc03KU4EESnx6azApdjEvIB6pzoQMzrl/JMBWMfBNTcJSw6GOI3lqXABPx5pToxf
         C9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekAy44bxYcE4719//M2Agt8con9V746x7iZRtQHtp3A=;
        b=EtZy8wuxc5gYIWQuJ2FB0rj1cJW4Zb2yhPjrEk5qBnMRMK3jrX+FP1F5eHnJoHhEf3
         7rd3DRbT9T6KyiGL3ZETIcNSwta6ZESPM6qsG94oKU+Q6qIYnP757f2l0ZPhWDh28zYc
         jPHZ3WVQ7QUjdW1XSFnj4DINN5qikhU9Dtybd5lA0MxAi5u08x29DgrRUCi/PKbQ0004
         AAGYb1p9GhK45hSqUCBILjvcwH6TzE6JHnzXl5nNkJuMYSqlTOSaai/J+lZD564/Alvc
         pj+RhwLA6lZZj6Iafyp+Hz/p+qR90x/XyCAdjpyWeJyeDNgT7/yLybUxYNj4HBKnwgvH
         8YDw==
X-Gm-Message-State: AOAM531Zvn8UXXZVHPLRYKjA5KeHibMWEdLsNLorGyY87Imp3Xd0BQEv
        rnpfYQyCLfEpv3DqEWzsptVjig==
X-Google-Smtp-Source: ABdhPJzUDqalj7QNH7bS9OFqHBZBbBagrC99qMZAAdpP4vZLeXhJhoqFtb9ZUxsbToXqPrsaYZE6Yg==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr18784594wru.366.1636719603596;
        Fri, 12 Nov 2021 04:20:03 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l7sm7236877wry.86.2021.11.12.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 04:20:03 -0800 (PST)
Date:   Fri, 12 Nov 2021 12:20:01 +0000
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
Subject: Re: [RESEND PATCH v2 09/13] backlight: qcom-wled: Respect
 enabled-strings in set_brightness
Message-ID: <20211112122001.x67ljs6hvrtsfnd7@maple.lan>
References: <20211112002706.453289-1-marijn.suijten@somainline.org>
 <20211112002706.453289-10-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112002706.453289-10-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 12, 2021 at 01:27:02AM +0100, Marijn Suijten wrote:
> The hardware is capable of controlling any non-contiguous sequence of
> LEDs specified in the DT using qcom,enabled-strings as u32
> array, and this also follows from the DT-bindings documentation.  The
> numbers specified in this array represent indices of the LED strings
> that are to be enabled and disabled.
> 
> Its value is appropriately used to setup and enable string modules, but
> completely disregarded in the set_brightness paths which only iterate
> over the number of strings linearly.
> Take an example where only string 2 is enabled with
> qcom,enabled_strings=<2>: this string is appropriately enabled but
> subsequent brightness changes would have only touched the zero'th
> brightness register because num_strings is 1 here.  This is simply
> addressed by looking up the string for this index in the enabled_strings
> array just like the other codepaths that iterate over num_strings.
> 
> Likewise enabled_strings is now also used in the autodetection path for
> consistent behaviour: when a list of strings is specified in DT only
> those strings will be probed for autodetection, analogous to how the
> number of strings that need to be probed is already bound by
> qcom,num-strings.  After all autodetection uses the set_brightness
> helpers to set an initial value, which could otherwise end up changing
> brightness on a different set of strings.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Fixes: 03b2b5e86986 ("backlight: qcom-wled: Add support for WLED4 peripheral")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
