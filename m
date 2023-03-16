Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FBC6FD19
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCPNsc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCPNsa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 09:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED969CFB
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 06:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 897CB62035
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 13:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700F1C433D2;
        Thu, 16 Mar 2023 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974508;
        bh=Pn29suZ4ZGaja+URFO+T7KoYii0N7lNJTP9iRWfhv9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJIIphtwWXithuVMSPUs+30wighlwpxIBpiOIAULTkDYCLrYcnKlKHEreCeJ1+pZM
         O/t05XxxTSypECG8h6vGAkPrFkeGDEhs5ialwTVFQK2pf2GWfJKIffsMkgWphr/m05
         nJUnb3RlkmxLhT8/+NdvRFxvp1Z0FcqV52Pf1W3qmmlsnwvSL2XrowqomLn8JDh99a
         f6e61277GGm2QnyPBvUzUDlpIvL2/wMORMm41Gngwggi+i7pgcQl63nCtE77CgNXIP
         CpAJP5qI23CtTUeeEL2h0gM/ZzkmDN+yqJgRBkcCxAirB21y2BjPOl7XoIcBOadeBE
         9a9ozhgwrm8HQ==
Date:   Thu, 16 Mar 2023 13:48:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 03/13] backlight: cr_bllcd: Convert to platform remove
 callback returning void
Message-ID: <20230316134823.GR9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-4-u.kleine-koenig@pengutronix.de>
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
>  drivers/video/backlight/cr_bllcd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
