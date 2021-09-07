Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8491C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 14:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A347610E8
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 14:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbhIGOxr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGOxq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Sep 2021 10:53:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77180C061575;
        Tue,  7 Sep 2021 07:52:40 -0700 (PDT)
Date:   Tue, 7 Sep 2021 16:52:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1631026359;
        bh=rBR2zR4qYK5bAv6dYBRzzsHRiX1WFHqQpOc1+JsquVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgWipVkapyOEVwkfXw+q6eXUANQ9cUfmpjzqHwb4QWB25rRkA3+bF/T+Z5SqBAKwD
         /5C5jJSOgfjDbtrQ7H4Ia4YP8ZfXNzBzNxpvVyD8/K4b47ZXTxqzMvNA/4yCGMKY3t
         Dh9Si6RIr6Jf78amtbnYa3FsB5kg80tnhGA8ABnE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <cb817cdc-449e-4587-ab79-36be4f49f8d4@t-8ch.de>
References: <20210907124751.6404-1-linux@weissschuh.net>
 <20210907131005.vvaitvcllbte37zp@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907131005.vvaitvcllbte37zp@maple.lan>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2021-09-07T14:10+0100, Daniel Thompson wrote:
> On Tue, Sep 07, 2021 at 02:47:51PM +0200, Thomas Weißschuh wrote:
> > backlight.h documents "struct backlight_ops->get_brightness()" to return
> > a negative errno on failure.
> > So far these errors have not been handled in the backlight core.
> > This leads to negative values being exposed through sysfs although only
> > positive values are documented to be reported.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks!

Thomas
