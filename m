Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B0CC6FD19
	for <linux-fbdev@archiver.kernel.org>; Mon, 13 Mar 2023 10:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCMKOz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 13 Mar 2023 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCMKOt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 13 Mar 2023 06:14:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C15B52F69
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Mar 2023 03:14:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r18so10755175wrx.1
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Mar 2023 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678702487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LFf8imUXGJ740YH30H8G1wP3R9KYJHw0iP0NBgTQYjg=;
        b=vFNwZo6RCHXiM9iiMArLPMPbJCFc/TRgHdwWgiREr79AhocZJC4USZsObQ2FuO45qf
         /pYOUkBfHdUJyqlNEi2VlUGnNEgay8UO1jJIcF98bJJd0t1+80wfuCAmpy6ttHVnpicF
         S6xbPBQifPCWFghEzurSI479fm+E/lS7GvHvcur+Ni6/yFUh50ABzZmCUgZw82bsVyYm
         CCmqON5iJgMlhnUMKIRzUp6/TzBtAGYeyjuacVbeasFqrd5NRa2/31+Dx5Rd1oCukOIy
         RW+FIo8fvSWDEhx8MREr4tuJ1yF6LRjbzW9bCfsro6jEyRcH3ZUnXLhvbahXnJRTWtE3
         n7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678702487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFf8imUXGJ740YH30H8G1wP3R9KYJHw0iP0NBgTQYjg=;
        b=HABPKpGaubSShyTzcpqmTVX9xXOvBhcAaAHd2jFYnKZTh4tWizwM06mz58pXJZVFRm
         opKVMfWZLh/pBb4tM57pyk+FbM2V+71yemyHcH7oz4iqmG+aOyzMvfxxFxgvHu+AKD7i
         QL1Epl8B4P/3khAefAKxTceX2Dxam1pR5OfQBODplQAVpU0WaKZUcVwYStf5JUSoMCDk
         tyegaosuR6cqaivHcqSvlpLQmKAAh0dQd9TxVaYb1rsfbmlXOMBX75vLlj5SmGwtxNkY
         KTP2P3LxybcwcoL2w8FP904rRu//s4zfqW+Um0rnkw4obJHjsx+MIMu7/7xtPIyynLFG
         zSMw==
X-Gm-Message-State: AO0yUKVGvi0RwofcFB0CbygGLpH5jed4yrCo+ffH4o5r6Y+Y/ZtIfYlO
        fTggg1NrDmshRInmcVbNHdmr1w==
X-Google-Smtp-Source: AK7set8yLU2cIhBgVUD2MrkZNSiTLmoACOPx2vcTRtog66hQ7l61dtZLkzmt+UbOf2oZpjyAn50keg==
X-Received: by 2002:adf:eb4b:0:b0:2c6:e744:cf71 with SMTP id u11-20020adfeb4b000000b002c6e744cf71mr20498231wrn.52.1678702486687;
        Mon, 13 Mar 2023 03:14:46 -0700 (PDT)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b002cea8664304sm5554039wrs.91.2023.03.13.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 03:14:46 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:14:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: arcxcnn_bl: drop of_match_ptr for ID table
Message-ID: <20230313101444.GD55049@aspen.lan>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
 <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Mar 11, 2023 at 06:35:56PM +0100, Krzysztof Kozlowski wrote:
> The driver will match mostly by DT table (even thought there is regular
> ID table) so there is little benefit in of_match_ptr (this also allows
> ACPI matching via PRP0001, even though it might not be relevant here).
>
>   drivers/video/backlight/arcxcnn_bl.c:378:34: error: ‘arcxcnn_dt_ids’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
