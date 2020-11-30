Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FA3C5519F
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 06:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF46206C0
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 06:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUz+jKFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgK3GjG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 01:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3GjG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 01:39:06 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE801C0613CF
        for <linux-fbdev@vger.kernel.org>; Sun, 29 Nov 2020 22:38:25 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id e5so724359pjt.0
        for <linux-fbdev@vger.kernel.org>; Sun, 29 Nov 2020 22:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6+dtAknrkqA4Yimni0jD+y5oA5qluuBuclYUMOPvYg=;
        b=bUz+jKFEZHNMSTnQV8CYtCPlSYJuu/mBseIRKD8DY/OSFYJYJV3sp5NaPPHdKR/DIV
         5IqMwPNiKvmq99PuQ658ITTSRpE1tnFnDa9dvzHCpYXXz04UhFBJWfWwgleQDm+0CQpm
         PhJeeFHdUZqItzeYLiJWSRixdpLCkTHPR6PuyVZipqoVkOzbwExGnfBC6AehsraGxM/U
         TNZ5AMk6m7ewz8y+mAgUUV9KcTuoNKetrSOI2q1m9q5pl0BoqAO3QN7Rh2hdkRKxTFVu
         V9G7+y6E8+jr2BESPvWTwdnI31Ywpj7JWg0INjJN+plaHk3tNVZKvffXkCwPQlvU+Luz
         rd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6+dtAknrkqA4Yimni0jD+y5oA5qluuBuclYUMOPvYg=;
        b=IrN9B/L4x9rVLTw7xi8ENMM0LRSR3zkZGPnPXVox75eAAAc8e3JkYv+MbFsJX4Q55Y
         jFPFpVUdZT2bze/eLk04SGaVCsTFxEF3qMpx4Q0Wve7PRqiS+LmZ8794hSG8xwaFuVaU
         FG9xEJp7NEetV3X6yNT36fV2HzqRaezeJgEvBjOkzq5e5cAWLWtcp1kOXhDANB4VG921
         kz0/CM8Om954c4RSbyGW4Wy12Qm4NE24ryTu7mmL8gR5N1JIt3bn71X0IrnT4flaxq/U
         Ze8K2k7xoZ9C+eoZOTxi7GnjRlF2/aFZ5dthzS/XKSE/3Z9tK+Dg+v+/OaWNUXCYDoSI
         XYLA==
X-Gm-Message-State: AOAM533mAZmzE7XrweCMrKEwdmxMPaJ92h6T+/ln3nQq7J0FT4Qpq4d8
        qvpkTso2UVyEWxR9FeEXfQ==
X-Google-Smtp-Source: ABdhPJw/6diNBVLIYytdwfhMkFQV2NjjkvrdG6vZhAGOx4lsjHNVmh8FJMnbdxqi/bQhWoncrY6V0A==
X-Received: by 2002:a17:902:d210:b029:da:578f:741 with SMTP id t16-20020a170902d210b02900da578f0741mr11311326ply.82.1606718305406;
        Sun, 29 Nov 2020 22:38:25 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id f15sm2692399pju.49.2020.11.29.22.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 22:38:24 -0800 (PST)
Date:   Mon, 30 Nov 2020 01:38:05 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH v2 02/28] video: fbcon: Fix warnings by using pr_debug()
 in fbcon
Message-ID: <20201130063805.GA21500@PWN>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-3-sam@ravnborg.org>
 <9fbdaff8-18af-223d-6cec-4b44aeb94fec@suse.de>
 <fe2a56cd-10bd-962c-4f65-96c23a78cdd7@i-love.sakura.ne.jp>
 <20201129111836.GA1094053@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129111836.GA1094053@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Sam,

On Sun, Nov 29, 2020 at 12:18:36PM +0100, Sam Ravnborg wrote:
> On Sun, Nov 29, 2020 at 07:28:08PM +0900, Tetsuo Handa wrote:
> > But replacing printk(KERN_DEBUG) with pr_debug() prevents __func__ from being printed
> > when FBCONDEBUG is defined. Is such change what the author of this module expects?
> 
> When someone goes and enable DEBUG for fbcon they are also able to
> recognize the logging, so the printing of the function name is redundant
> in this case.
> 
> There is likely limited to no use for these few logging entries, but if
> they should be dropped then I expect Peilin Ye to do so as he is the
> only one doing active maintenance of fbcon lately.

Sure, I will take another look at them. Also sorry for the delay in that
printk() -> dev_*() patch you suggested, overwhelmed by some other
things this week. Sometimes fbcon.c accesses dev structs in a pretty
weird way (e.g. registered_fb[con2fb_map[vc->vc_num]]->dev), I will get
back to it when I understand this better.

Thanks,
Peilin Ye

