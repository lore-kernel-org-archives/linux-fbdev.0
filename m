Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93052C6FD19
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 13:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjCPNum (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCPNuk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 09:50:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C067AFBBE
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 06:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C52A9B8219E
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 13:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE44AC4339B;
        Thu, 16 Mar 2023 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974636;
        bh=41JDTwywgpra1j/g1QCcorJIUZZeXGWLei2nG9yVvs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4NqbSuvb1c3ZQYnsH3hIvhEsILDU6bzGXTr4TXtDi0YNqpnT9A5HxT/mYqH09zYt
         x3KtaFYqH7P5w9QBBH1m+Ryjy3Pt93Mtd1Mz1MjHOFUr6ulqEWfaXdV5XUMCDPtp4o
         yO7G7mE+1bGo6laedAmQNCSqWjq8nVGYv01a/pbL2dJZ4l6ywuCnvVO3gjB+8OHkSK
         FXIPm1RSimlMC/UhGasdPqBXTs9Fjd2K95XhBHU9Wl5ojLasQQg5OBU6b5Zn0+fOeO
         +QGmr0E50NCrMVMPjOPT6ens7Wy8mpoHyB4R5Gs31O+Ghtqi/uJ/cAU/lzdlNCo2cJ
         3rvpRji7L/7qQ==
Date:   Thu, 16 Mar 2023 13:50:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 08/13] backlight: lp8788_bl: Convert to platform remove
 callback returning void
Message-ID: <20230316135031.GW9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-9-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-9-u.kleine-koenig@pengutronix.de>
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
>  drivers/video/backlight/lp8788_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
