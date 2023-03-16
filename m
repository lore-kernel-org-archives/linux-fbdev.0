Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9393DC6FD19
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 13:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCPNuF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCPNuD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 09:50:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA4AF28B
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 06:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE287B82184
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Mar 2023 13:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBF1C433D2;
        Thu, 16 Mar 2023 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974597;
        bh=Zh0QyoMAbNt3lTx4uf5WJVcZDlxY1DfaUCFaEB7fU2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFIXXZ7BP/ni4RRSIwqwp30UtxkmNh0vazW87tx8vOm4K4j5cY44xd4DUYW1YC+xl
         0RX8IfD8Cqco1hU9sDXlZieH0YFBQOmFZziqWwtHFt9epKCFr+2hjnkuLPdDxOmaCH
         8sy/WQYTuko+6Nd9YeJmYsUV0EMyE+Ji9U3Ou5Nkze4rJK8spDjQMuHmUtjAMDiTUe
         UcqZf3Ri577tGgAkbJhyJqpd06W6DqWLlMoEHMUsBRLfJoek6yoEzyzHypwMJFVWsU
         CMnC9uLXy+iLUmx4aZVEdy3BTOBy14GUp0cwmArX9pQ2e7ud1qUxlhnwWg9ALGksod
         YicvZaoQbO7fw==
Date:   Thu, 16 Mar 2023 13:49:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 06/13] backlight: led_bl: Convert to platform remove
 callback returning void
Message-ID: <20230316134952.GU9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-7-u.kleine-koenig@pengutronix.de>
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
>  drivers/video/backlight/led_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
