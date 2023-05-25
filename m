Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B0C77B7E
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 May 2023 11:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjEYLYx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 25 May 2023 07:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbjEYLYs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 25 May 2023 07:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678E10B
        for <linux-fbdev@vger.kernel.org>; Thu, 25 May 2023 04:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D6C63C4D
        for <linux-fbdev@vger.kernel.org>; Thu, 25 May 2023 11:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7B9C433D2;
        Thu, 25 May 2023 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685013886;
        bh=btjnOS5QBQbH1TK+krstl7WoC4pjCk/EvZ5Dl24yVkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlGx7vULqkX0U0Lhjy84XofXnfTD4UM/yoGBln0OrkvrvDEn0HUQSoIOr+qBE/IoV
         IfLOZRRxCuy6N+sOfAuh4HwbZ+/7rUFiDri3KIW4+OlURootsv1ifFpFlrRnyCCT7h
         Pziwa+ibAp+ajH6tLKnml66xH20j1DcV00A3swnTXpemCyhDFf5ojGi6MMv1O3fDyr
         fJowxDn7KA0eXO+1AvBe81+VoOWr+QflNJAJugIiv3HOWmHaYq8bYArtET2vMcYUd2
         lWc3TmhPnIQsSe5g99na91nQ3aWL+/C7gXSpQ58gLUpAiUB2lBCB/jaGgzTMnYcRZy
         LSB3eQaqcrBAA==
Date:   Thu, 25 May 2023 12:24:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>,
        Jianhua Lu <lujianhua000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] backlight: Switch i2c drivers back to use .probe()
Message-ID: <20230525112441.GA423913@google.com>
References: <20230521143844.375244-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230521143844.375244-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, 21 May 2023, Uwe Kleine-König wrote:

> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
> 
> Also fix two indention inconsistencies in the neighbourhood.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this patch was generated using coccinelle, but I aligned the result to
> the per-file indention.
> 
> This is one patch for the whole backlight subsystem. If you want it
> split per driver for improved patch count numbers, please tell me.
> 
> Currently there are no changes to drivers/video/backlight in next, so
> the change should apply fine. If however there are other changes that
> result in conflicts, feel free to just drop the hunks in the relevant
> files and apply anyhow. I'll care about the fallout later.
> 
> Best regards
> Uwe
> 
> 
>  drivers/video/backlight/adp8860_bl.c | 4 ++--
>  drivers/video/backlight/adp8870_bl.c | 4 ++--
>  drivers/video/backlight/arcxcnn_bl.c | 2 +-
>  drivers/video/backlight/bd6107.c     | 2 +-
>  drivers/video/backlight/ktz8866.c    | 2 +-
>  drivers/video/backlight/lm3630a_bl.c | 2 +-
>  drivers/video/backlight/lm3639_bl.c  | 2 +-
>  drivers/video/backlight/lp855x_bl.c  | 2 +-
>  drivers/video/backlight/lv5207lp.c   | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
