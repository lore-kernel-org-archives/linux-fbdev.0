Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3259C388F7
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F8B207BB
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+zWxG1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgKJNY4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNY4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 Nov 2020 08:24:56 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DEBC0613CF;
        Tue, 10 Nov 2020 05:24:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m13so1992198pgl.7;
        Tue, 10 Nov 2020 05:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+QrV5GbdFaGhruHIUGFYEWHi77tyozQEbntZ4ud6Fo=;
        b=k+zWxG1uer0ohn+xFxeIJ/v6PRprgpVH7sP4/vCcDZiVHY0DRsZE88ksmsbgx/AFAm
         GBB9oNMYJebK7UfbCk638xXbMbs8VclMcOHJpe+1I30eXa2co9zrHBfmkOt0HqX1ijBn
         YMJQsO8b40szqlwuGm0jDszq6ZkjVZuG4bqgj3id1hVqQbA5IAKPn/VomPV9CEnRR/l5
         Af9kYOTZ7/2ilBcD5BQiPLtHJzrS9xlGEiCRNoryk3Ie4iKs3bP+pZRWFI1ZGNeYjtNF
         pUIc4hdZ5NuWm6v35CoJ4jrRNvX2cUlm7elN7sw7iPa3Fmy4uH0LBsLaBidK73W6Hk6r
         63/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+QrV5GbdFaGhruHIUGFYEWHi77tyozQEbntZ4ud6Fo=;
        b=MlwEh6ClGra03u4ow8EwxneEwCZ/jkAL0ZJd0hTS/sJLVvTxTlzbUWva0rbP0nCwCY
         YmSjQd1LwA+3faSbVQUIXKNb82Xtx0rTgRsvKzjzaADWCbYXiUQpMrN/9O7RzBHQmdu4
         M9IPBc3soP42p/Q2rKfr+V7Z4w0qI5jRE6VNLZAqCXOsBOA2YMk5d3NxoWrW1haz8P6L
         X7P14JmM/VuQolqd+DTBvdM/66bg3Zf/+ZKqLfOFGbB1ESNOgeTOQEFs5H/Q1wiV4etd
         mv+t34WJeYQFn4rqGhKed8yEcHV/lDdM6qkCpBA8wiLq/Y8+WqRgWJ+FbvoI8KsJTtTU
         FzFg==
X-Gm-Message-State: AOAM533kxuKHiduwmyxFF51RGjPyfWCDpZ9yR/XLhM76WeZRz8xly651
        qvj1XbxTUQ9YdkCgVcj80g==
X-Google-Smtp-Source: ABdhPJwolrm32K/4m+gVTu/aqACBTH40DteoL2hIeqoeqD/xwkyyaUXnbYbOTqSNWFOpNaBr+S6VKQ==
X-Received: by 2002:a17:90b:e8c:: with SMTP id fv12mr5145898pjb.196.1605014694293;
        Tue, 10 Nov 2020 05:24:54 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id z12sm14816996pfg.123.2020.11.10.05.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 05:24:53 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:24:45 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] console: Remove dummy con_font_op() callback
 implementations
Message-ID: <20201110132445.GA2483842@PWN>
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
 <20201106105058.GA2801856@kroah.com>
 <20201110124946.GF401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110124946.GF401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Nov 10, 2020 at 01:49:46PM +0100, Daniel Vetter wrote:
> Peilin, can you pls resend this together with all the other pending
> patches from you? I think that's better than me trying to cherry-pick the
> bits we decided to keep from random places.

Oh, are we doing an -rc3 backmerge soon? At the moment I can base these
patches on neither drm-misc (due to the font_copy removal), nor mainline
(due to the signedness issue in font_desc we've talked about), so I'm
waiting for a backmerge to rebase everything properly. Sorry that I
didn't mention earlier.

> Greg, ok if I just pull these in through drm-misc-next? It's a pretty bad
> hairball anyway and that avoids the tree coordination issues. Only thing
> that might get in the way is the vt font_copy removal, but that's in -rc3
> so easy to backmerge.

I will rebase and send everything (including the font_copy
garbage-collecting) in a v3 series after the backmerge. Thanks,

Peilin Ye

