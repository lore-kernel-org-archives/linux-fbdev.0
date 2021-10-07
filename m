Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B769DC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Oct 2021 11:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABC1610EA
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Oct 2021 11:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbhJGLaO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhJGLaN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Oct 2021 07:30:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D24DC061746;
        Thu,  7 Oct 2021 04:28:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQ8Fp4Lgmz4xR9;
        Thu,  7 Oct 2021 22:28:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1633606095;
        bh=6XmEiUcJBUQ8ZFQRxDdulMZQn/HEizswWC5HCbgLKv4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DOGfBEHeWO47bjBBHSHsqxFr8+O8sec9YHMOV06w07chkyLOXFhiy33LfNn5VlWDC
         cKjYQVSHWpXovo4+4sITrz7gih9V9V4AXN2Wcdazpm+o5eAgii7U43m1xogcjaQacD
         qjhiWYCHziZAWNYDXzUAGSREejHv2cc/u5ySDu+uRZC81Uxd2+WmbuUTmnYW0Po+TB
         Sf5ivALvgxG2JTs/QmsZ6tIHV9JvFkIFw91QNK2C7Fl7c8uzlqWsCWXqGN8kCJuve4
         jwITcpfEw9wlw82uh2lulpy0eFqLA76uFzeA8+J4vJxxk8fxUBIynWjzD9Opa3CuYE
         mEmRv4WpkTXKw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH] video: fbdev: use memset_io() instead of memset()
In-Reply-To: <884a54f1e5cb774c1d9b4db780209bee5d4f6718.1631712563.git.christophe.leroy@csgroup.eu>
References: <884a54f1e5cb774c1d9b4db780209bee5d4f6718.1631712563.git.christophe.leroy@csgroup.eu>
Date:   Thu, 07 Oct 2021 22:28:10 +1100
Message-ID: <87lf35nkfp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> While investigating a lockup at startup on Powerbook 3400C, it was
> identified that the fbdev driver generates alignment exception at
> startup:
...
>
> Use fb_memset() instead of memset(). fb_memset() is defined as
> memset_io() for powerpc.
>
> Fixes: 8c8709334cec ("[PATCH] ppc32: Remove CONFIG_PMAC_PBOOK")
> Reported-by: Stan Johnson <userm57@yahoo.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/video/fbdev/chipsfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like drivers/video/fbdev is orphaned, so I'll pick this up via
powerpc.

cheers
