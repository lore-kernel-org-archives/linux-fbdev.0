Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA54C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 23 Sep 2021 10:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9DD610A0
	for <linux-fbdev@archiver.kernel.org>; Thu, 23 Sep 2021 10:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhIWKvY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:51:24 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:40949 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240407AbhIWKvX (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 23 Sep 2021 06:51:23 -0400
Date:   Thu, 23 Sep 2021 12:49:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1632394189;
        bh=qjdeXlozuivPeR0eioe8PmC1RMurpCpfF51tRU3+QM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8pmoguZ5rt6w13+fKgEO/8PREU8+OdNS6URzNpfyT+Kup/dnjTmmsm7JbT+FiTFQ
         AO/poVTmHKqo7+aRLtgCJ+A4M20fnLVuN7Ze+iMvj6rRMVIwnJdjfkyyv6x03UJBHG
         c8A+TqBeqqzfFEoWKAnIU4gXkGv83K7gjvJ49HSc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <4bb3051e-2550-43c3-afed-d4b00850126e@t-8ch.de>
References: <20210907124751.6404-1-linux@weissschuh.net>
 <YUxNczBccLQeQGA5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUxNczBccLQeQGA5@google.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2021-09-23T10:48+0100, Lee Jones wrote:
> On Tue, 07 Sep 2021, Thomas Weißschuh wrote:
> 
> > backlight.h documents "struct backlight_ops->get_brightness()" to return
> > a negative errno on failure.
> > So far these errors have not been handled in the backlight core.
> > This leads to negative values being exposed through sysfs although only
> > positive values are documented to be reported.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > 
> > v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/
> > 
> > v1 -> v2:
> > * use dev_err() instead of dev_warn() (Daniel Thompson)
> > * Finish logging format string with newline (Daniel Thompson)
> > * Log errno via dedicated error pointer format (Daniel Thompson)
> > 
> >  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> Applied, thanks.

Hi Lee,

thanks!

Also I'm sorry about my nagging before.
I was not aware you were on vacation and saw you respond to other mails.

Thomas
