Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE06C433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD5520878
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhA0OKo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhA0OI4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 09:08:56 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56513C061573;
        Wed, 27 Jan 2021 06:08:16 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id f63so1241452pfa.13;
        Wed, 27 Jan 2021 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dZ5Apc48PgkcI0iXXqNFunIaMeiv0OUaEYhLHdVP0NQ=;
        b=dJy0+TMILjiVrUpvi7MdKmW8sdrsYcu+xcsBSAgst74BJQi0ZNqyRWhZfzs1szh0p7
         lWS54dhIYPKbyr0rJ0broDLBytoXwoz/mkAv6kRh6Ddq5i8pUKb0JSQ+fIZJ2ARQdD1q
         i6fJMvNgcKx4e4JakNddu3DpJLn/jVtdvgAFaZ4iibiw3zg9IMH6tbjvTHrYAE6kqC1K
         vLukDbyD+W11RS0/l8d3XG3mujP03amTNHJp3UbUbbfNVGrLsyudpD3VFfTKR7jcuGGY
         X7ZHQY/G5OqmAwjod3a/2Il9nyvNf3AE9g6y2I1G5oeXW5Pgw63PTqI0TCFP85SbbvXt
         SA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dZ5Apc48PgkcI0iXXqNFunIaMeiv0OUaEYhLHdVP0NQ=;
        b=H/Fo3XN2prwEgNZwh8FXcEAzIRLNtPPQDeY4D1p3LsIoZCFsA3K5iP2wf3yKYW4Jro
         6SqxmfC69QBYjUImxb+Rss1CR5LTfe+A+B71cy4j6Bs8j71P9HSjwDHcCfzNx43wWhWn
         ZSJqwvw/6M690KJ2FH4h5A68c8hls4h2pCHZ9M+L8cQXDLzHvYX9upv5wys7wBi2s6PS
         5GGyb0pKHvX8GuyKPBTm4WvQ0WM7wbmxIIO5MGLh7LTxQvXskz3fneIgNAgVPawUJPlL
         NxtxJnrTQJpdi5+lrym8fJx6Ja8Bzs66FxtV9OwdGYmy6MdJKfYWC55lp/EJbI45Rged
         58rQ==
X-Gm-Message-State: AOAM532oTMln5CS+vLaZd9KDM98nC+X3Hi4T5Yx2qixj1G25mdg7J5NU
        D0SPCqfhsQtFI5sd0zRvyNY=
X-Google-Smtp-Source: ABdhPJzc7K4wiaIzTiUqaEc8ZDf0bQRgXReBZZ0hBd/naH+2JnDs7iHHAkpIutIYQ12pcivRgHxmZA==
X-Received: by 2002:a65:5241:: with SMTP id q1mr11307536pgp.143.1611756495877;
        Wed, 27 Jan 2021 06:08:15 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id u3sm2866475pfm.144.2021.01.27.06.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:08:15 -0800 (PST)
Date:   Wed, 27 Jan 2021 22:08:09 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <20210127220809.000026fb@gmail.com>
In-Reply-To: <YBFv+12xfsoxacDb@kroah.com>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
        <YBFv+12xfsoxacDb@kroah.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 14:51:55 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 27, 2021 at 09:42:52PM +0800, Carlis wrote:
> > From: zhangxuezhi <zhangxuezhi1@yulong.com>
> > 
> > For st7789v ic,when we need continuous full screen refresh, it is
> > best to wait for the TE signal arrive to avoid screen tearing
> > 
> > Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>  
> 
> Please slow down and wait at least a day between patch submissions,
> there is no rush here.
> 
> And also, ALWAYS run scripts/checkpatch.pl on your submissions, so
> that you don't have a maintainer asking you about basic problems,
> like are in this current patch :(
> 
> thanks,
> 
> greg k-h

hi,
  This is my first patch contribution to Linux, so some of the rules
are not very clear .In addition, I can confirm that before sending
patch, I check it with checkPatch.py every time.Thank you very much for
your help

regards
zhangxuezhi
