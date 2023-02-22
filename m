Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77164C61DA4
	for <linux-fbdev@archiver.kernel.org>; Wed, 22 Feb 2023 15:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjBVPXe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVPXd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 22 Feb 2023 10:23:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6C323DB0
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Feb 2023 07:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38BB96147A
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Feb 2023 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE2DC433D2;
        Wed, 22 Feb 2023 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677079411;
        bh=DQiMmdzoaF/dJutqCYfJ3egYITEZ/zDtJM+U9xI5WEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGdOCU5d+rDHLhFIStOTwsyB9Il/laUoKCVjPrlyymwgfPAo2QcQ4hfPROctZfhnU
         cCVWcL3hBoZy4qGXlRs+mRIma7k6/Nn52OaI13EZgpbHNDwy0t4ISAB3NyGo4hL9go
         cwZsfAolnLkhZE0JLZzn1JnHD3bNvYhff+ah7L8s+X81vJNGIT0sZls627lBcy8zYr
         pRvpmlwchC+J5Kp+bCyyBC0mW/IUUWmbprFTdzhf3YsLiOkABCYu4skZtz89gBifLG
         BeutjoCA2ndmD+3A+7FgJaqavbTMDGJOK3feLnghY1bqPzvJMYjA0AQ14o1BHgIXuZ
         BGfm0SHVUOYZQ==
Date:   Wed, 22 Feb 2023 15:23:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jianhua Lu <lujianhua000@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: ktz8866: Convert to i2c's .probe_new()
Message-ID: <Y/Yzb7pWcMzSFYfG@google.com>
References: <20230127152639.1347229-1-u.kleine-koenig@pengutronix.de>
 <Y9eQ6QTngI18zUJn@google.com>
 <20230211230545.lv5g2f376rojlwyc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230211230545.lv5g2f376rojlwyc@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, 12 Feb 2023, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Mon, Jan 30, 2023 at 09:42:01AM +0000, Lee Jones wrote:
> > On Fri, 27 Jan 2023, Uwe Kleine-König wrote:
> > 
> > > The probe function doesn't make use of the i2c_device_id * parameter so
> > > it can be trivially converted.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > there is an ongoing effort to convert all drivers to .probe_new to
> > > eventually drop .probe with the i2c_device_id parameter. This driver
> > > currently sits in next so wasn't on my radar before.
> > > 
> > > My plan is to tackle that after the next merge window. So I ask you to
> > > either apply this patch during the next merge window or accept that it
> > > will go in via the i2c tree together with the patch that drops .probe().
> > > 
> > >  drivers/video/backlight/ktz8866.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > Applied, thanks
> 
> Thanks, this patch didn't make it into next yet though. Is there a
> problem other than pending tests before you publish it in your tree that
> gets pulled into next?

It's queued, ready to be submitted tomorrow.  Don't worry.

-- 
Lee Jones [李琼斯]
