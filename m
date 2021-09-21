Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EBC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 21 Sep 2021 14:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A78611C5
	for <linux-fbdev@archiver.kernel.org>; Tue, 21 Sep 2021 14:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhIUOvi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhIUOvi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 21 Sep 2021 10:51:38 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CE0C061574;
        Tue, 21 Sep 2021 07:50:09 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:50:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1632235807;
        bh=HVjDwY3TCzwDBv32KPIGLsUQZWFrfWErmGlbPLXnjeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lI661zFUSBSuibdyMJanQmYB+xU6QJzPb2CWZUzlHjMwPUdQxw7FRTWp32l/sK9sD
         sLAyANhiH1BNw7iKrs15lH3mn+f5AmHL3FGc07a3i461k9/lhD0jHTTMzebK2Hje36
         AdCR+HCtoeeEMRFKYSLKotEbHGtp+Zq7aTAaZeC0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <b25975d3-f417-4cba-92d1-35c93d37e1e6@t-8ch.de>
References: <20210907124751.6404-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907124751.6404-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2021-09-07T14:47+0200, Thomas Weißschuh wrote:
> backlight.h documents "struct backlight_ops->get_brightness()" to return
> a negative errno on failure.
> So far these errors have not been handled in the backlight core.
> This leads to negative values being exposed through sysfs although only
> positive values are documented to be reported.

> [..]

Friendly ping.
