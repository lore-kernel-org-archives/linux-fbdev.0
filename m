Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7534C64E7A
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 20:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1E2151B
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 20:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEJ+cbUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgLAUKx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:10:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbgLAUKw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Dec 2020 15:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606853365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9xBuIwvHlgEYVcinhRR/M3/VaorTrBcdWGpGOVdNeU=;
        b=CEJ+cbUWyPqUH8iWkyuCTy2Zpn/ioLdZS4htguBzLtI/tXMkCNd4oADUo0W7xW8W7KDWWI
        3FIn24pSs5V9XuIbImyEQa5s71H59Z1hyw2WBjKiOiQJnqdxA4Y4oWl4AeThTLGcE0WJaL
        G3r5nOJJ4bWqzEFcofH2wgXsMlvHkVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-iuFG615qMPK1Fc5-5Lrjvw-1; Tue, 01 Dec 2020 15:09:22 -0500
X-MC-Unique: iuFG615qMPK1Fc5-5Lrjvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E08A158220;
        Tue,  1 Dec 2020 20:09:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3077189A4;
        Tue,  1 Dec 2020 20:09:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 0B1K9JVF025796;
        Tue, 1 Dec 2020 15:09:19 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 0B1K9I7G025792;
        Tue, 1 Dec 2020 15:09:18 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 1 Dec 2020 15:09:18 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Thomas Zimmermann <tzimmermann@suse.de>
cc:     daniel.vetter@ffwll.ch, sam@ravnborg.org, geert+renesas@glider.be,
        bernie@plugable.com, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] fbdev: Remove udlfb driver
In-Reply-To: <alpine.LRH.2.02.2012010500310.27495@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2012011505060.25490@file01.intranet.prod.int.rdu2.redhat.com>
References: <20201130125200.10416-1-tzimmermann@suse.de> <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com> <336a41ef-1e49-6799-1bfd-06fb42419fb8@suse.de>
 <alpine.LRH.2.02.2012010500310.27495@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On Tue, 1 Dec 2020, Mikulas Patocka wrote:

> When I try to run Xorg (from Debian 9) with the kernel 5.10-rc6, it 
> doesn't work at all, I get this crash:

I tried to rux Xorg on another machine (with up-to-date Debian ports) and 
it didn't crash on unplug.

Mikulas

