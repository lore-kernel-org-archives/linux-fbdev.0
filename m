Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C699C00528
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Jul 2023 09:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjG1JBz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Jul 2023 05:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjG1JBw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Jul 2023 05:01:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570CB6;
        Fri, 28 Jul 2023 02:01:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18FED6203D;
        Fri, 28 Jul 2023 09:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D86C433C7;
        Fri, 28 Jul 2023 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690534910;
        bh=QFbAxq6StERpZ+KK7xUrlh9LufNoAHMbQ1zTa9eTS9A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S6LwPGwK95psSYAKBfRe3YnemnLXtJH1tFmZY2LEnrfl9QzjjDzM947xHZJjJzWSg
         8Nw5pZS5i7Qtlj3I5BHRld6dyYGG+hgztqHp+h9fm3ZRPZgqza/V7cNT+zz0l8zkDW
         s3R4RLCccGVqBvBdpHMOTnFmLH62VBq2t783K/PHLqAC4L4FIrApZXTk8AdnUti5LT
         Ka73CcgVkVXmh7MkY2a3bMW4ZHYROsCrTgVZxQUFJWdYb+KJp45rsGJ2C9VK6OsUzb
         RLW62+Zi+f4DLTpUk967KT6k916JAaDzGrMouLsCicxyyH142WalportSxAXI1gTDw
         NvfNv/ZQHSJ3A==
From:   Lee Jones <lee@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230714175029.4065326-1-robh@kernel.org>
References: <20230714175029.4065326-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] backlight: qcom-wled: Explicitly include
 correct DT includes
Message-Id: <169053490748.289850.10304540751076738824.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 10:01:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 14 Jul 2023 11:50:29 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] backlight: qcom-wled: Explicitly include correct DT includes
      commit: 1bb5187b673208f7191f227249ffe7401e969b97

--
Lee Jones [李琼斯]

