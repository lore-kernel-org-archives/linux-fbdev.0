Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE15C6FD1F
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCPNuX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCPNuW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 09:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1EEA9DC3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 06:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB38962025
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 13:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCBFC4339C;
        Thu, 16 Mar 2023 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974617;
        bh=6DIUuO5OucJfOZkmMSmX+nGMyXcQZPZaOsYkWlbrgrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maKFrFaIwr6y8jEtfImaNwXku4j8tZpf2HHXoxihbwCRboTLzZyczqybN2+XY4aM7
         MgeaKQ2G/P1ju5ZcqLDSH+GVjpcB0J/5jjcufSDgy7NxXHoqpQUqosddhh/UIPsldZ
         Sr6M2bw2Q1MtdJRq5g83QN03d+LRBThopJTxtAW4NUUV8P8ZS2gqHMh1sN7YMpn7GL
         P2hLOLoolmji2sdo5Q8LEWXeyPgSJ2BSt7M/Ng6J6dQ8foZuVvPgeSV0EEjHe5gMBU
         10w1qQ4Eg24tcxwDx69aT4fq04LybCzUnGZyarBfedJgr2znc6lZlSCXd7trv9xcGG
         YFqpph1I2xnJw==
Date:   Thu, 16 Mar 2023 13:50:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 07/13] backlight: lm3533_bl: Convert to platform remove
 callback returning void
Message-ID: <20230316135012.GV9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-8-u.kleine-koenig@pengutronix.de>
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
>  drivers/video/backlight/lm3533_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
