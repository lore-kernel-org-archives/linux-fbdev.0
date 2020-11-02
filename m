Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F8C4742C
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B9D2076E
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 11:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3oyj/8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgKBLM7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgKBLM6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 06:12:58 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88DC061A04;
        Mon,  2 Nov 2020 03:12:57 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id o129so10826729pfb.1;
        Mon, 02 Nov 2020 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qCgiqZXGNwvNh2nZMtUDnqrlrZqGGd0+W48CRCFS5Bo=;
        b=g3oyj/8BectFHMWdpOJLUmTdLl6ao46UPyBqt4FGqyBVKmWGt5uTsIVrZlIeUg1kKp
         BBgtWX3kj4FS86SKaIeAwtMdHwt92nFpIAVanSryUOtS79J+OMzAjXRuwKG7yRz4Q2Jd
         2YqA+/Rr5omjYftodpgfkeo2fVcimWdr9Jty4R5BaiXWsIpYYbdvxyxNOt83QtgY1Em8
         nkFfjzgRFv1w4XLjnRsfzoTnaxg0gl6R+7Kt4wD0XKpn9prfm6SeaZyIjvU+i9TjGvvR
         mKotJYuoYwAmT7GuZn9jTBKaZtrrWzYZMqWdL9nsHHVapaaDei+Htw61qhtLV7EF9d8E
         5+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qCgiqZXGNwvNh2nZMtUDnqrlrZqGGd0+W48CRCFS5Bo=;
        b=QILySlQ2EtXNFxv2wIK7vP4O4AEI6ADBOP808x72I96t2ulO7WuKEAI8j+3c84TH2Z
         Us/x7lnlbqTXmTix3ycDJ510v01jS1Am5kFTB5+YspHXQrdw1HqoNHdeetjVmR8JS2aU
         RySwNyWtB9GWFVuTy1Y8PKHR8ZRqF0MfPftTTOr4vqyGCk4p1rKSjokXWXCL0MAaeKii
         vp3FLh7tp4KTtjUGQXComEZp5ujwWQU1MXccrvHtL06dot+cWoXyhwqg0cl/Cl+t+7LP
         ZIt2G6e+4XwcKV/Y04BZXNHBsT32b0pA45t+kHKFFaT6yHnAfulOi6tm3kpQZFfh0dHD
         ux+w==
X-Gm-Message-State: AOAM533cIvaa4ujxrssK7LTXkUfar6WigrI0YY8D+EuHZNLAg+jFWO9y
        fj8S4JUqXuPx0shahXCqyg==
X-Google-Smtp-Source: ABdhPJyKj6yz7vBgyoh7xhGNMnD24Vj1loJ7dkpZAbbMnfJNoJPPQas76a/fl61lg2hFJOnMRs6fDg==
X-Received: by 2002:a62:64d1:0:b029:161:ffdb:e07d with SMTP id y200-20020a6264d10000b0290161ffdbe07dmr20737550pfb.71.1604315577377;
        Mon, 02 Nov 2020 03:12:57 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id m2sm13516592pfh.44.2020.11.02.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:12:56 -0800 (PST)
Date:   Mon, 2 Nov 2020 06:12:48 -0500
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
Subject: Re: [PATCH v2 2/2] tty/vt: Avoid passing struct console_font_op to
 con_font_copy()
Message-ID: <20201102111248.GA1558630@PWN>
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
 <72c954371ed9b1d050901b2d498a979017de8a3c.1604306433.git.yepeilin.cs@gmail.com>
 <20201102101044.GM401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102101044.GM401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 02, 2020 at 11:10:44AM +0100, Daniel Vetter wrote:
> I'm not sure switching from int to unsigned just here makes much sense.
> All the console code is still using int con to index all the various
> arrays (I just checked fbcon.c code), and using int to index arrays is
> pretty standard. As long as we have the con < 0 check to catch evil
> userspace.
> 
> There's still the switch from op to int for con_font_copy, but I think
> that's better done as part of the larger cleanup we already discussed. And
> then maybe also include patch 1 from this series in that rework.

I see. I think at the moment there's not much we can do for
con_font_get/set/default(). _get() and _default() use *op, and _set()
uses all except one field of *op. Maybe we can change the type of *op
from console_font_op to font_desc, after cleaning up everything else?

Peilin

