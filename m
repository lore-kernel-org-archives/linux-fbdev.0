Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC4C5519F
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55892074A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 08:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd5iuX+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgK3IxG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 03:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgK3IxG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 03:53:06 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B9C0613CF
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Nov 2020 00:52:26 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so6130148plo.0
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Nov 2020 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F8gz64bKeAs0YPQcvkE/rBDqMgLpfaqaTi1XhXTLQ84=;
        b=gd5iuX+jRxP4x+a3Aam2vFbCg949ZJHRAnNoi5327NZzkt5D1cRISvVsv/k4XLNaRj
         5SItMyMDnr3qU2lMLPaX+r4uBxnkfAOHv18hubuUjltGrMGWNJjv58RBwcvgZ9lqj49X
         0R5N4oZ/uppMATZCj+K9YZ2RKsm+19JbLCerk0DrAIDFdAEu+iC8Ct9SBNKuqnXGkMcQ
         ijc9+/d+/01V9aMObVbycymKGK6a9Aa/fJOxGrg69+DVX8T15m3DxPq03KyNZFfEFdre
         2GaEPASE/t7+X0UAZ76cqKOr4IFswvSvUhOoLHKv7m9jTULEpjW7iq5Z0x7rosSS7cOQ
         26qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F8gz64bKeAs0YPQcvkE/rBDqMgLpfaqaTi1XhXTLQ84=;
        b=NDfVbGWl025g63iYBLG77WFd9mqhp8uQW9pMBAHnb4VWzfFxg5vkz+4of9LuYOIVka
         afVAZvRc8N/oKdwUxIfX5VXlTPLlPOi6uZqVSwVhredHOHrBR5itXXnjohHa8ixyQI2x
         KJpf09y/7aB9WOwOWT1LQrXL29MCmLb6kDUky+t6zYWrllcexAfTgyEJS0rGRbGMvWDN
         7NJI6t3AffHCLs1UQSBvb1msuKk70BVRbCeuU/iaaow7oz19ic7crQrHsUVJY7esBVnE
         kgii3yYCw849BP5niDpmdZ9+L3OcTAmurCbCSo3kxcKSBzN5QCcG1IOx3VM/W6Y8xE5S
         0Wig==
X-Gm-Message-State: AOAM533DkjbG8/Q9mMopPPVDoOV5hua4Q3AiRzaDOTI4fwgh/8Xu+x5h
        0xOanyrJnfM8zNCIuWjpMQ==
X-Google-Smtp-Source: ABdhPJzaha/Dgv2Z2ggaTX+gmjsC/KIZh/3xdpYPWiuzeGkIJCP+avDy0nS4pqqvyehL7W1JY4U+3A==
X-Received: by 2002:a17:902:8212:b029:d9:d097:f9d5 with SMTP id x18-20020a1709028212b02900d9d097f9d5mr17756174pln.34.1606726345541;
        Mon, 30 Nov 2020 00:52:25 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id g31sm14652145pgl.34.2020.11.30.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:52:24 -0800 (PST)
Date:   Mon, 30 Nov 2020 03:52:07 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Lee Jones <lee.jones@linaro.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>, Peter Rosin <peda@axentia.se>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 02/28] video: fbcon: Fix warnings by using pr_debug()
 in fbcon
Message-ID: <20201130085207.GA22647@PWN>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-3-sam@ravnborg.org>
 <9fbdaff8-18af-223d-6cec-4b44aeb94fec@suse.de>
 <fe2a56cd-10bd-962c-4f65-96c23a78cdd7@i-love.sakura.ne.jp>
 <20201129111836.GA1094053@ravnborg.org>
 <20201130063805.GA21500@PWN>
 <20201130075645.GA1442147@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130075645.GA1442147@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 30, 2020 at 08:56:45AM +0100, Sam Ravnborg wrote:
> Please just keep up the good work cleaning up fbcon and related stuff.
> This is an area that needs some love and care and there is work for many
> long nights yet to do.

Thanks! I will see what I can do,

Peilin Ye

