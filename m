Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5AC54EB4
	for <linux-fbdev@archiver.kernel.org>; Mon, 23 Jan 2023 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjAWO3s (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWO3r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 23 Jan 2023 09:29:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260F1E065
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Jan 2023 06:29:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so8722781wmq.0
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Jan 2023 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVEX3K9R7UTVs9BpydIEVGiNnSD4cwRlULo8SBOwRn0=;
        b=i3RoMQQsfcUP8NOwgfzVsWobAfVLn54sIZ4XHfy+qH+5n0QZ0M+sWsiNJTPpKCU9K8
         yqaNynX/bMUw2xIkPwJI3RoYO+DyM0d0QhX/6Cngq7qnw6kclIfHvp7040IR4NAlnrM4
         fnhBpq/EZrpa5GzYXXa4C+IZaTklI8dpbkC5W9HcFJ8fbyzDPFaxXTA+WudfULmeJEYw
         DNvDV10+bAumqGo5/QMgQhj9vQUrSY+v0QJip3z9RXyIA32B3p49xegzWnudQhV/+BH9
         dhsot0MsFXnAaAJEOOVH8svtpyHgg3P9rk6izZrf6lOxlvZlfu+RMhr29AMY+npqCvlo
         kRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVEX3K9R7UTVs9BpydIEVGiNnSD4cwRlULo8SBOwRn0=;
        b=XE+FZW6omTp4ncCpU/Vb5DkCm46WGlXWswBMxkXndZiC3bXdm0XXVMpY3xIq4rOSCU
         NWt1biVesu/ijf2VwUhIeoBCPKTAX/QLsQ+PV8wmF1mL1opi8SUz4ujpa/y3E1+jzcUc
         pnvzgbZc535NUVgrT3LUeB6YNKqf6ygmBMttjG1mtp59uvIcMMpr9jRAEJA9CUJgNgkr
         kY+qISAx4pIg7jd3gpoXq/FJasrEobTyQrOdaVimppmrID4TYyA3YDE4Kbp506pLQtvO
         0FS4QFz/FsfyIbyQO8bIca3gc1aJHXahPLBy5RDNFJ8x9vr52A5wXjwkBT96R1XyelgI
         0zuA==
X-Gm-Message-State: AFqh2krcoTjoqX2a5+dXSsAFygEQnWoh3TGKDQfgoXpumam+aXXjcWju
        //ZNcsNmElQW7xo5XhRdMjxW7g==
X-Google-Smtp-Source: AMrXdXu+uy83sENphsRTx1C76RiEULtoqR/9nxoXaE+2BE1EGyLljUeg1Q2ZHou14FVb8ThEN22dvA==
X-Received: by 2002:a7b:cb88:0:b0:3d9:f801:73bf with SMTP id m8-20020a7bcb88000000b003d9f80173bfmr24150509wmi.12.1674484184653;
        Mon, 23 Jan 2023 06:29:44 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003dab40f9eafsm11865469wms.35.2023.01.23.06.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:29:44 -0800 (PST)
Date:   Mon, 23 Jan 2023 14:29:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y86Z1ohimSHhNvj8@aspen.lan>
References: <20230120155018.15376-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120155018.15376-1-lujianhua000@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 20, 2023 at 11:50:17PM +0800, Jianhua Lu wrote:
> Add Kinetic KTZ8866 backlight binding documentation.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
