Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB4C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 11:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AC660F22
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 11:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhKPMB6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhKPMBy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Nov 2021 07:01:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3401C061746
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 03:58:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id z200so16685687wmc.1
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2lkNEPN5OP5kdyraYR6h2y5fmHN+EL9Nmvifn0raI8=;
        b=FQZ6Ler4mcGoHSNJn3muv8L4ILy3TD4a1XiNFd+PKkvccjN5vXFeFkdICO76YhBRv+
         FqZYorusGyCMUNrSKQByBk0fL6jscTvPKdzqhjHpTswLiuxMy749jrdtLRCS3JPNma6O
         PuKQji62b5n+mkiyZ96bLuEwQaSuWj051q3wXrj8kEanRC+Wl3EVnvrjr7N/E0Dr1yC8
         F/i/tfjKlIWdZVZN7RNPPwptxki7oZDKWX4HBsf6X3IbmyWXuOcOoFw5PAbCja/b12PW
         ajaeZiyi0+T7Egr+ZetGs7leXZgGRlfppNIoN+F5U+30y2G5jBsMBkruPyzGnfgoS9ij
         1mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2lkNEPN5OP5kdyraYR6h2y5fmHN+EL9Nmvifn0raI8=;
        b=vMayVO4xLylpyIbyYXJofE7ohxkARbrPK95Wtg+lgbJf7Z9IqNXRjDYIuSINNzrrDw
         PintvLSCbmt+lxralqM7FnfS6gPnr65aCRU0uOjiPUX6XpQ/rbEtA8LF21gOz0heXFAm
         txrJXwRJvtjqUSx2ZLoUrPbYcb+dR/6hk4kykdsQ+Y1WI8zffU/kMQCwDBUspQtwMLGd
         Pzac2nEGnfWC0eDuYuNgJhR8MgDGKZGuum3zUw5bdUiM+wFfF2TwyHzAdoH5glkvhI3g
         yql1FTG2l5N9BwX5C1Cxniel7FIt+iiP7herSnC0YFs/++rYzRwTUHSZTv+3AH50PJQ0
         hKDw==
X-Gm-Message-State: AOAM5332/XydJSm/FWWBb9tFbJkShG1dMdQSfXnhEdjt3KYbcDgn0bh1
        GBdFoZuOQlyAMWIdfr42DbwudA==
X-Google-Smtp-Source: ABdhPJyGcsDTHEkbLZBHATBRRsdkDFubekjiZ9m89IVYrT7musLvksci1JED4nkakdtkXd6kzec2Og==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr6973409wmh.60.1637063935397;
        Tue, 16 Nov 2021 03:58:55 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n15sm2458635wmq.38.2021.11.16.03.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:58:55 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:58:53 +0000
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
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH v3 4/9] backlight: qcom-wled: Fix off-by-one maximum with
 default num_strings
Message-ID: <20211116115853.mujwmb3v4r5s6c5v@maple.lan>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
 <20211115203459.1634079-5-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115203459.1634079-5-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 15, 2021 at 09:34:54PM +0100, Marijn Suijten wrote:
> When not specifying num-strings in the DT the default is used, but +1 is
> added to it which turns WLED3 into 4 and WLED4/5 into 5 strings instead
> of 3 and 4 respectively, causing out-of-bounds reads and register
> read/writes.  This +1 exists for a deficiency in the DT parsing code,
> and is simply omitted entirely - solving this oob issue - by parsing the
> property separately much like qcom,enabled-strings.
> 
> This also enables more stringent checks on the maximum value when
> qcom,enabled-strings is provided in the DT, by parsing num-strings after
> enabled-strings to allow it to check against (and in a subsequent patch
> override) the length of enabled-strings: it is invalid to set
> num-strings higher than that.
> The DT currently utilizes it to get around an incorrect fixed read of
> four elements from that array (has been addressed in a prior patch) by
> setting a lower num-strings where desired.
> 
> Fixes: 93c64f1ea1e8 ("leds: add Qualcomm PM8941 WLED driver")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
