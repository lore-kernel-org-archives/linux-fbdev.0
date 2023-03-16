Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E7C6FD1F
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 13:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCPNsL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCPNsF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 09:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F4CA1D4
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 06:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2099E62013
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 13:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B674CC433EF;
        Thu, 16 Mar 2023 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974477;
        bh=pz8zb+x2OYq4JrfjJXg/dKlmVC8FlKsKdUjg+1Z/kWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6x84cG1sAJ0cRlDYOBu1byTdgayYKLUPQMoIU28XtvwB35Mgv74LkitpeLP+6nJF
         VXdT3OB2YxobiR0lC9cDklN2VCV2X6kyYs0TIz+opOukXYc8EKaKSuNf4Nb7WImCFd
         4qJICIWH/9vBdptQ9JGBy02PVVPGUrOIuS0ZE49+qrSMm8YA7KSaWFXUGnXI0CzZe6
         NP8MtmxBFu54/ZmpuDM8GzTHElRx4H/vUG0PR70CgFHezpokhBYXnUqYxI9iaW3x4X
         zLn/pfqo+nZjNYKmhFdzTKDvxFst3/JBHLz88F2qWHVB+7UY28tc1Mrs8cXVKcyZdc
         pbj5fpeeXhYDg==
Date:   Thu, 16 Mar 2023 13:47:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 02/13] backlight: adp5520_bl: Convert to platform remove
 callback returning void
Message-ID: <20230316134752.GQ9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-3-u.kleine-koenig@pengutronix.de>
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
>  drivers/video/backlight/adp5520_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
