Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F4BC6FD1F
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 13:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCPNtX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCPNtX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 09:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3E8ABAC4
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 06:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C2CC62013
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 13:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F053C433D2;
        Thu, 16 Mar 2023 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974559;
        bh=HtSqZtaWq+21wMq+Kxw4Dw88HQjqRZ2M7IH54wJo65Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIz7g0KkDCDrm2nQJTgs6hh+Tv3DGaeyAp7SOO6tuNOWc/5LfSxSQMQ4AWHt6eVO9
         dMU/8rOjI6wYvPmbhLqs8o19xOxUnL9xlXlNIDdLNclAMdz84L5tOWuIIF7A/7mbBW
         akB1FXKqobcDrCjzLapYV38c2Agkt8UtkCKbXMvlf59FM+XSqt+FTFzIZoJD0NvnIK
         2yZlKTKgbVswU0BGNxUcS8/OeEi51rgCfmZUBfb1xkfYQZuUx/2IDvAakNoR+fXWUe
         66ZQy9znhUmMbiBRYlnkD0x/HlGGWY19pvxciwhOy9nIjtYTxYmBLKlGNQ/wavW7rk
         SoVnbKk5Jl11g==
Date:   Thu, 16 Mar 2023 13:49:14 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 05/13] backlight: hp680_bl: Convert to platform remove
 callback returning void
Message-ID: <20230316134914.GT9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 08 Mar 2023, Uwe Kleine-König wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/hp680_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
