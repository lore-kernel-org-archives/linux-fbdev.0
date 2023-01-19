Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12454C678D6
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Jan 2023 22:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjASWD0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjASWC5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 Jan 2023 17:02:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F014C2B;
        Thu, 19 Jan 2023 13:41:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEC661C1D;
        Thu, 19 Jan 2023 21:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB970C433EF;
        Thu, 19 Jan 2023 21:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164475;
        bh=VhT//xdaFJPL+dSaI47Z5lILBjkKNuCbZfXeuUicLJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuXpGV1gFsGP6Vt1PI8UcWgi4x+iHPLQ2GhQyJCPCcS5NtMAJrcoTNG8bKnV+6XA7
         VTY1lhJK5jZt7/WZbL4cgaQi2gxlb9bPcGTRK10xcDcekU+MlG8IBpB5/sscFoOWsC
         h9ga5iUbMBihFJcfj0QjKzIr3HV4GrwseDTJQVgX1DyurpLTL7mjVNVit+V5UW8NVw
         onL3FbbfEJ/tLmpebZGR4PUiwiDf2Er+2wv3LYQIF9wvbaAIkXt0qcGEOI0/aknnYr
         ozmT8Xw9BqNp8GADORcZ29uKlJmHx2Gn04kxdDRhkBdBxh1JGp/SZumQB8p0MdsknL
         FmnMSbBvaBI+Q==
Date:   Thu, 19 Jan 2023 21:41:10 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Message-ID: <Y8m49nsyR0B9vcbX@google.com>
References: <20230106164856.1453819-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106164856.1453819-2-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 06 Jan 2023, Stephen Kitt wrote:

> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/video/backlight/aat2870_bl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
