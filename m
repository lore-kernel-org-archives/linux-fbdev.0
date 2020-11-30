Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0B3C64E8A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 14:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED2720684
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dU9r3IB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgK3Ocw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgK3Ocv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 09:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606746685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QQujhvvur/pM8ZJh3DSJTp6K0D4ASRltH6KQoBKkjWo=;
        b=dU9r3IB+7zD55++aIpg65fNIP64ifln5y2OlIcxzBKpWwqhKdBNYEuP2ckoORQ/y417ckk
        FDxF0m0DTxejTBsOkrxzY7GvyC0YoXHSE16re7I5lTg75l5SfBcjgmNb1j1+oIVN+mxeKf
        MD9/jkjLxwQvGiOspan5J+4CgplRahs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-X7i9HG4-PO-SbxCKkvoMCA-1; Mon, 30 Nov 2020 09:31:21 -0500
X-MC-Unique: X7i9HG4-PO-SbxCKkvoMCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE768030A0;
        Mon, 30 Nov 2020 14:31:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1004060873;
        Mon, 30 Nov 2020 14:31:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 0AUEVHHG001898;
        Mon, 30 Nov 2020 09:31:17 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 0AUEVFpX001894;
        Mon, 30 Nov 2020 09:31:15 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 30 Nov 2020 09:31:15 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Thomas Zimmermann <tzimmermann@suse.de>
cc:     daniel.vetter@ffwll.ch, sam@ravnborg.org, geert+renesas@glider.be,
        bernie@plugable.com, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] fbdev: Remove udlfb driver
In-Reply-To: <20201130125200.10416-1-tzimmermann@suse.de>
Message-ID: <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
References: <20201130125200.10416-1-tzimmermann@suse.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On Mon, 30 Nov 2020, Thomas Zimmermann wrote:

> Udlfb has been superseded by DRM's udl. The DRM driver is better by
> any means and actively maintained. Remove udlfb.

Hi

I am using udlfb and it's definitely better than the DRM driver. The DRM 
driver will crash the kernel if you unplug the device while Xorg is 
running. The framebuffer driver doesn't crash in this case. (I have a cat 
and the cat sometimes unplugs cables and I don't want to reboot the system 
because of it :-)

The framebuffer driver is faster, it keeps back buffer and updates only 
data that differ between the front and back buffer. The DRM driver doesn't 
have such optimization, it will update everything in a given rectangle - 
this increases USB traffic and makes video playback more jerky.

The framebuffer driver supports programs running full-screen directly on 
the framebuffer console, such as web browser "links -g", image viewer 
"fbi", postscript+pdf viewer "fbgs", ZX Spectrum emulator "fuse-sdl", 
movie player "mplayer -vo fbdev". The DRM driver doesn't run them.

If you seach for someone to maintain the framebuffer driver, I can do it.

Mikulas


> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  CREDITS                      |    5 +
>  Documentation/fb/index.rst   |    1 -
>  Documentation/fb/udlfb.rst   |  162 ---
>  MAINTAINERS                  |    9 -
>  drivers/video/fbdev/Kconfig  |   17 +-
>  drivers/video/fbdev/Makefile |    1 -
>  drivers/video/fbdev/udlfb.c  | 1994 ----------------------------------
>  7 files changed, 6 insertions(+), 2183 deletions(-)
>  delete mode 100644 Documentation/fb/udlfb.rst
>  delete mode 100644 drivers/video/fbdev/udlfb.c

