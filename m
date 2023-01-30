Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6AAC54EED
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Jan 2023 09:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjA3JmI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Jan 2023 04:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjA3JmH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Jan 2023 04:42:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54DD8F
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Jan 2023 01:42:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBEF60F04
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Jan 2023 09:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B40C433D2;
        Mon, 30 Jan 2023 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675071726;
        bh=4lfm3sE3/eFrpEywA1t6MKrvuPLMfIVyZC/x6yxyH2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJhmzThDdzEfi81VQ/krxd7j6slu3NHEen7+fA7IxrjZ1xmM+vZZpLV9PdJM30ZnO
         UWVtm1lobAUvnquTsTis+c6MhjZIboirFK1GrIjcfW/uza6V62gHjqol/U1HEHDyrx
         aGIHTaHXn7Qw49hHcDJFxU46UHDasz6wiDfqwnMag0BFwEe8SYd9iKo+vZMMQegPDl
         4xGH5a+ISiQFe0WNT/q87SYDi19WDQN50a70oXBCh4dvDTnxAHHik3ldXG+IpU40uL
         cVKl7KO+lXl9vHtKUPVrVGDn4VcKdYmX45fbioQDfbFoUPfGoYjov4heinugNGPIN/
         9qvvUwOSt9eDg==
Date:   Mon, 30 Jan 2023 09:42:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jianhua Lu <lujianhua000@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] backlight: ktz8866: Convert to i2c's .probe_new()
Message-ID: <Y9eQ6QTngI18zUJn@google.com>
References: <20230127152639.1347229-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127152639.1347229-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 27 Jan 2023, Uwe Kleine-König wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so
> it can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> there is an ongoing effort to convert all drivers to .probe_new to
> eventually drop .probe with the i2c_device_id parameter. This driver
> currently sits in next so wasn't on my radar before.
> 
> My plan is to tackle that after the next merge window. So I ask you to
> either apply this patch during the next merge window or accept that it
> will go in via the i2c tree together with the patch that drops .probe().
> 
>  drivers/video/backlight/ktz8866.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
