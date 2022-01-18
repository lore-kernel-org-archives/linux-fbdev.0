Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8D3C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 Jan 2022 12:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiARMsa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239324AbiARMs3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 Jan 2022 07:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642510108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CB6tHFD3hrD0W0enC4pHpoosOH1HSXx3fWvCf7Pxffo=;
        b=BakLB2qgtUgIgClyBbpKeVxUP3A5vNniciajh/rRUeBQ41K/NQYH+GYoo++oz53kNYy5ot
        oYAhc/3W3Wn6c+TtmgjemZ94LmFoNi+X8szoDEPB2rJymO3AmIROVdI20Hwn9MNx1BjqNq
        sug69BTVru0z09Vx+q/KGYCXo7ho/YU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-6FX2kNaPP3Ch-pn68zxI-g-1; Tue, 18 Jan 2022 07:48:23 -0500
X-MC-Unique: 6FX2kNaPP3Ch-pn68zxI-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26F0E1006AA5;
        Tue, 18 Jan 2022 12:48:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1BF02B4BF;
        Tue, 18 Jan 2022 12:48:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4523D18000A6; Tue, 18 Jan 2022 13:48:06 +0100 (CET)
Date:   Tue, 18 Jan 2022 13:48:06 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Message-ID: <20220118124806.ywmjxk6wstipzi56@sirius.home.kraxel.org>
References: <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com>
 <70530b62-7b3f-db88-7f1a-f89b824e5825@suse.de>
 <CAMuHMdW5M=zEuGEnQQc3JytDhoxCKRiq0QFw+HOPp0YMORzidw@mail.gmail.com>
 <57d276d3-aa12-fa40-6f90-dc19ef393679@gmx.de>
 <CAKMK7uE7jnTtetB5ovGeyPxHq4ymhbWmQXWmSVw-V1vP3iNAKQ@mail.gmail.com>
 <b32ffceb-ea90-3d26-f20e-29ae21c68fcf@gmx.de>
 <20220118062947.6kfuam6ah63z5mmn@sirius.home.kraxel.org>
 <ebe9c076-e2a9-0cb7-eb6a-ae71c075975e@gmx.de>
 <20220118091615.3ih5n7vhd6tgmnku@sirius.home.kraxel.org>
 <ffef1042-e1af-d5b5-b140-ae24fcc1855b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffef1042-e1af-d5b5-b140-ae24fcc1855b@gmx.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

  Hi,

> > fbcon/fbdev emulation: RGB332 support must be added I think.  But both
> > argb888 and rgb565 are supported today, so it should not be hard to find
> > the places where you have to add some code to handle RGB332 too.
> 
> I'd expect that that framework is provided by DRM developers if there is the wish
> to get rid of old fbdev and transition existing drivers over to use DRM.

Good luck with that.  Asking people to code up stuff they can't even
test due to lack of hardware isn't going to fly very well.

> > Yes.  The world shifted from 2d acceleration to 3d acceleration.  Modern
> > hardware simply has no classic blitter any more.  Which is a problem
> > when it comes to keeping scroll acceleration alive, it is already a very
> > niche use case and it will only become worse ...
> 
> For me it's Ok that the DRM drivers don't use 2d acceleration (as it is today
> with the arguments mentioned multiple times).
> But the patches broke existing fbdev acceleration which is available by
> the fbdev drivers. That's a big regression from point of fbdev.

Keeping it alive and working will be a tough challenge.  2d acceleration
is a thing of the past and the number of people which are able and
willing to put effort into supporting it will only decline.  It has been
a problem for a while already, basically it was dropped due to lack of
support ...

take care,
  Gerd

