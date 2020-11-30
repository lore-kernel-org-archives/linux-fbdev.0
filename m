Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F22EC64E7B
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 18:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD31820725
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 18:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et3EO0eE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgK3Skz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbgK3Skz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 13:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606761569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9ZQqaEJyTXtTPwKAIvc6yiwpWOFXj2Tjc6b0XQMCrc=;
        b=Et3EO0eEjXiynGtMn0Qgq8K//oppd9h/omL7uco+PSXfkkoiH/aDy7ie7lI09Vp6/zRN8k
        zzTdEEyIdFgSTe4KtDYFZLmA1CeXHbRKmgMZZYd3d2QhTNLVJoZFwhUznZkrQ3347fPotp
        mRAAIUTWyE1h6YaTLkX71opdq5gzt2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-DwSjZxLyOi6Zl2POdMrKqw-1; Mon, 30 Nov 2020 13:39:21 -0500
X-MC-Unique: DwSjZxLyOi6Zl2POdMrKqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6A8F180A08A;
        Mon, 30 Nov 2020 18:39:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A965D9C0;
        Mon, 30 Nov 2020 18:39:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 0AUIdIPn027142;
        Mon, 30 Nov 2020 13:39:18 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 0AUIdH6j027138;
        Mon, 30 Nov 2020 13:39:18 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 30 Nov 2020 13:39:17 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Daniel Vetter <daniel@ffwll.ch>
cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, geert+renesas@glider.be,
        corbet@lwn.net, daniel.vetter@ffwll.ch, linux-doc@vger.kernel.org,
        bernie@plugable.com, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org
Subject: Re: [PATCH] fbdev: Remove udlfb driver
In-Reply-To: <20201130154147.GT401619@phenom.ffwll.local>
Message-ID: <alpine.LRH.2.02.2011301241470.21432@file01.intranet.prod.int.rdu2.redhat.com>
References: <20201130125200.10416-1-tzimmermann@suse.de> <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com> <20201130154147.GT401619@phenom.ffwll.local>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On Mon, 30 Nov 2020, Daniel Vetter wrote:

> On Mon, Nov 30, 2020 at 09:31:15AM -0500, Mikulas Patocka wrote:
> > 
> > The framebuffer driver supports programs running full-screen directly on 
> > the framebuffer console, such as web browser "links -g", image viewer 
> > "fbi", postscript+pdf viewer "fbgs", ZX Spectrum emulator "fuse-sdl", 
> > movie player "mplayer -vo fbdev". The DRM driver doesn't run them.
> 
> Hm this should in general work on drm drivers. Without that it's clear the
> switch-over isn't really ready yet.

I fixed it with this patch two years ago: 
https://lists.freedesktop.org/archives/dri-devel/2018-June/179023.html

But the patch never went through and the fb_defio feature was removed in 
the kernel 5.6 (commit d0c4fc5a4814e431c15272935c8dc973c18073aa).


Without fb_defio, the only other possibility how to update the screen is 
the ioctl DRM_IOCTL_MODE_DIRTYFB. But this ioctl requires master mode, so 
user programs like "links -g" can't issue it.

Mikulas

