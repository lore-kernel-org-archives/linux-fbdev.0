Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4FBC46467
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Jan 2023 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjASWAn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjASWAB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 Jan 2023 17:00:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59046C1302;
        Thu, 19 Jan 2023 13:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C316193C;
        Thu, 19 Jan 2023 21:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EEC433EF;
        Thu, 19 Jan 2023 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164324;
        bh=FQJpoqxB6OaO61PvKyPRMDj1dmn+wD7csP9DHZDao1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oM6m0WwBPsUWLaDpmDqxpqLwFwJQr0g2vnqyvRQ8PLnZvtZQshzk8GZa/qFTfOkc7
         2Ed9CgwtStzfPTesAmGmg+1CrFAdEqcVXehS/NdoHWgWgOGlQO7moagoYDGdi6b+R6
         EAyPCr352T35mGNsPlQivTjAHIgrGVAFgWikOupsxBd1eVIFe50nrhDfPtod11wrjd
         Rjwlx23za76bHDQoRt36xnIZZS4NlVWOBbF96B44b9we8dXbdKm0+gKEm2X6UTW4PI
         Zznzy3JnY6gR4JGCkCc8Z0Y7q2BaxnZnKuqaL7O19SFI1+xP59D3nmtSvoiLo7SpaT
         mOt7eHuRbtRqg==
Date:   Thu, 19 Jan 2023 21:38:39 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] backlight: arcxcnn: Use backlight helper
Message-ID: <Y8m4X1pB5h6sryFl@google.com>
References: <20230106164856.1453819-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106164856.1453819-3-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 06 Jan 2023, Stephen Kitt wrote:

> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/video/backlight/arcxcnn_bl.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
