Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BBC6FD1F
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 13:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCPNtH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCPNtD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 09:49:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5918AACBB5
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 06:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE64AB8219F
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 13:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8034C433EF;
        Thu, 16 Mar 2023 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974536;
        bh=zL4FIdTg00ODHjqpMmVqY9LOs4Ir4Md6XTe8ybzUXlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1j5+GIhBaaA0IEeqqbDAbqJjF+mmVA5FsmU72fEwjyZ0KHwdzvLhWAdkHqPLtEeB
         PAFd2fHkXgyYDRGSOkIeShgTXXknCXGuL2H7Xz6GMmi2VpoCEjTokTtvvEwZCXrOo6
         yYMx9AFssi4Cw9iLrFL9DDOjG1oAr8tD07oXhspl3v88nKPFeNIfEsSDQ2szW0PZe8
         9C6G7S4wYmgb+FeqvG/TO6gCe1BQBN77GTo8zZCwMmrp0OjaTsLTgbq7NRp68rZ/ce
         wqcoGpUaG/okoi15iIkimJpLjI8WotYDQKc/le3+K4JLWq4vpmeKsEXJtSEIP505P3
         y3/Zkx8qloynw==
Date:   Thu, 16 Mar 2023 13:48:51 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 04/13] backlight: da9052_bl: Convert to platform remove
 callback returning void
Message-ID: <20230316134851.GS9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-5-u.kleine-koenig@pengutronix.de>
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
>  drivers/video/backlight/da9052_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
