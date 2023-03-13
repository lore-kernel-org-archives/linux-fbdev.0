Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B1DC6FD19
	for <linux-fbdev@archiver.kernel.org>; Mon, 13 Mar 2023 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCMJtI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 13 Mar 2023 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCMJs7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 13 Mar 2023 05:48:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFC11EA0
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Mar 2023 02:48:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p26so7444862wmc.4
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Mar 2023 02:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678700937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HkyQXV8Sx9ZiihnRIEst2K2Pia3Osr/efAg4G6vW/d4=;
        b=YyIhi+qBKXeCniBQqYHNXvbSy+16jKMevR5pLkpADFaOLjyEDkhC1KEP/+/NtUNqLq
         WRtlKz6pUBPcjb4ZyHkYR+Zyfd5tzUnvH6LkYPU3ym7PxHURP+R2tVeHPQy2VivX91IT
         y1fpoowiLZ5AIV5uyXZQofz9T9bTRjLbAtZezcwoN0COtmR1SagwpWgKbSX7Uy0Y4arS
         ZrrAO5teJRJXswXBzMcBvdjWuTjdZy4iAzhhGImwEyt0elgs8DBIKVuZUNgkQQVkwcPY
         thb/JLkAv46ioNhodlfr0RgdHBKOennanVxscJu0TTFISuJgGIXZiyCXxRzFJLkzQ/jh
         kKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkyQXV8Sx9ZiihnRIEst2K2Pia3Osr/efAg4G6vW/d4=;
        b=CTQ3QUpQ3d8lswiLdipcRd26z6KLpHfY9dTJLpOlvCk27poWX5G/5AxsBr6YrDbyho
         PuARo+Wk3Al/U8Bh1gZN/hRJ55W0orYXZp4DYnk4tfZDPOqAgD2eiBK5CxhKVghqVb2u
         9xAKhUGwkGjVA81saUIbM2e6poQY4pQDS1muIrdPHv+YqJ+0xjaw4ikoNHnGAdbe73jl
         C2pb5T2kPzXLLqQt+ybNwW9QGRtDvSgVy5q9v09E6K2zhaJ6ElsNt8VZ2rJbGYemfWa1
         uFDyfgV0lJakd6GKhN5RaQl7wEWUZk0Duv813r0ajXlRBGRF/LKYvl51Mq2PmllCj2GP
         ulqw==
X-Gm-Message-State: AO0yUKVqESFQXEnB0MI32LUwA5q6e63DoL9X6q6UZ1N0aQkGxBo333z9
        oQ7adkaM5iPhmD5rXlVo15pFvw==
X-Google-Smtp-Source: AK7set/o8hyLBzsXl3rkE65eXXSwq1sPMaL90pmRe5O2/veHyLmLBgHIUUgjnFdyrjDZ5pHpoAQCsg==
X-Received: by 2002:a05:600c:198a:b0:3e2:1368:e395 with SMTP id t10-20020a05600c198a00b003e21368e395mr10237994wmq.33.1678700937004;
        Mon, 13 Mar 2023 02:48:57 -0700 (PDT)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t1-20020a05600c2f8100b003e2058a7109sm4732704wmn.14.2023.03.13.02.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:48:56 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:48:54 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: lp855x: mark OF related data as maybe
 unused
Message-ID: <20230313094854.GC55049@aspen.lan>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Mar 11, 2023 at 06:35:55PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>
>   drivers/video/backlight/lp855x_bl.c:551:34: error: ‘lp855x_dt_ids’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
