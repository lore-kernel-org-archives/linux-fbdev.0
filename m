Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0758C46467
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 Jan 2023 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbjADRRe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 Jan 2023 12:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbjADRRS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 Jan 2023 12:17:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2BDFCF;
        Wed,  4 Jan 2023 09:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D210AB81888;
        Wed,  4 Jan 2023 17:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9BFC433F0;
        Wed,  4 Jan 2023 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672852634;
        bh=flCRzPb0Fn/y+JbT6SPfEuNtl01OMb1WGCSQgr8q+sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIkzxo70Qhk/3IV9GhD0kIAbJPcx9Piiij1rPPyZlOw3UsVv4PxKwBfWtoDopSUB1
         RyXmRTIZAZKIskE9hWQdA83+hu2WAkVPv2mruhTF3QakpYDhHmN0VuhtoJoKBRaOw+
         kCdgI0PU3c/ydAWT84HAUPygbhiTcuMhQvddCLgu6eT992YDnIDl6H783KBNFEsgie
         d2h4O8/cKulJhmy2ulRYGS0+WI5CrrZ+o61YnRBiCwym5n1SBMldAWRNAGiIdH4pxY
         3/pnr8qk7C47nilEnTYZoNydhwUiWkXidDUWtNxsGdaRRe+shlqSBR4wIyBtcAvVn+
         f58Es7zvTtWwQ==
Date:   Wed, 4 Jan 2023 17:17:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: backlight: Fix doc for
 backlight_device_get_by_name
Message-ID: <Y7W0k8bQMH7cRbo8@google.com>
References: <20221215071902.424005-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221215071902.424005-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 15 Dec 2022, Miaoqian Lin wrote:

> backlight_put() has been dropped, we should call put_device() to drop
> the reference taken by backlight_device_get_by_name().
> 
> Fixes: 0f6a3256fd81 ("backlight: backlight: Drop backlight_put()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/video/backlight/backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
