Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1299C77B7A
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 May 2023 10:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbjEZKj2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 May 2023 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbjEZKj1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 May 2023 06:39:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A701812F
        for <linux-fbdev@vger.kernel.org>; Fri, 26 May 2023 03:39:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-309553c5417so509177f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 26 May 2023 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685097564; x=1687689564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HytdpLB2BLkS5NjviYqG4FdqHruuJyRPB0ysP9IOgkk=;
        b=DKV+rKHG+vvRFnOB+auX3vzeeI3kmPgtHFrm6CJKW0TTJUlZZ1zj/+LgTeVessIrCk
         APlR/AEoXDcUhz+XodwfI2V2eYTO0+adiIyjZvB/+HjNyR7g3VEDRy8gl6k57Kv/lEZX
         xR1ZAtEMgt2GyvCZ7r21fy4xjJ84D1V0fdTd4wjCJmcOvbQilMVQXzO0o5Am30ebc9UK
         bOlQQ9zqHxH0dv+ZJf3ddkTJoG9r/qohq2TM1gRgOobycD200E028Lgpjfn6j8UJ96EL
         9e1AP3Ch4LKRar0g2hdGrph7H/6kg94155zwCEE9s0b780NU3sg7NRLssV5H6JIDbJYk
         4JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097564; x=1687689564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HytdpLB2BLkS5NjviYqG4FdqHruuJyRPB0ysP9IOgkk=;
        b=T529Z5eeM5bsgkTn8EMaDUZV+m57adTAdvJWdZ3pSfhweH9yYM7CGJreKRU9t99wbY
         YTSqgVeunX04K77nWdxVvhl828jJztyVrp0rfDxqMzUhcG0osD3ibjIcAl0Df8Fo/EeE
         Rqfq/c6gE7uzPMvIITTjjx1kYhLfQg7CpGaMYGd9yBhJf6f9eOmEuMaZLLZjT1h+X3XW
         x/WJymu3OBP7PaS9iisCXwRpy3fuK7M6ahBeI/ngqTsNhFsrX8ox2NhLzVbjYvi3IwwY
         Jj9MFovqe8L2L4790ldsb+AGnJKa/EhXkYdwbChFbxp3X2P4ZfZxLG0QCvb/g6sUAtdC
         FxVw==
X-Gm-Message-State: AC+VfDwqIytzFrlTF7MKX1kjZKnId8GRJZnaC/C5vtH76VATLrZ5H7Dc
        aDF47F2iQSIi4h6SY2VsOZnsrg==
X-Google-Smtp-Source: ACHHUZ6ubA2MF6JgtRAwxIFIE2lVjUYAKPZfiw6mxaXshnyIKhN55g87E0purMwViHwqcEIS1jrBWw==
X-Received: by 2002:adf:ef46:0:b0:30a:b4e1:a89f with SMTP id c6-20020adfef46000000b0030ab4e1a89fmr1135169wrp.58.1685097564174;
        Fri, 26 May 2023 03:39:24 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id i11-20020adfdecb000000b0030629536e64sm4737259wrn.30.2023.05.26.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:39:23 -0700 (PDT)
Date:   Fri, 26 May 2023 11:39:21 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/4] ARM: dts: adapt to LP855X bindings changes
Message-ID: <20230526103921.GF626291@aspen.lan>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
 <20230519180728.2281-4-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519180728.2281-4-aweber.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 19, 2023 at 08:07:27PM +0200, Artur Weber wrote:
> Change underscores in ROM node names to dashes, and remove deprecated
> pwm-period property.
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
