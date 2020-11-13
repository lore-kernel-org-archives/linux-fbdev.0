Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF7EC4742C
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Nov 2020 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18ADE2222F
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Nov 2020 22:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYryAWT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKMWqz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 Nov 2020 17:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMWqz (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 Nov 2020 17:46:55 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC852222F;
        Fri, 13 Nov 2020 22:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605307614;
        bh=mrL0p+Bsz9/fxM2HbgiWUgT1fPwu1dJyQ2h/5u3OJNk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=NYryAWT6CwWzB1rPlCYpRNJsYOJjneOQ3BeqQ+F/7LBwWIzlj9y6vK7yK0Lw7JCDQ
         5C3PKfustD80DXUx38QvAHi7mtwK5Sbpszv1XDpSUIRqZjJLv38IclNxTHFqA1K+do
         XKIj8zbvM5EUHLzGnJZ9XyKa65Fk3N85HDbjw48Y=
Date:   Fri, 13 Nov 2020 23:47:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <X68NFzaAuImemnqh@kroah.com>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
 <20201113211633.GY401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113211633.GY401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 13, 2020 at 10:16:33PM +0100, Daniel Vetter wrote:
> On Thu, Nov 12, 2020 at 07:02:21AM -0500, Peilin Ye wrote:
> > Hi all,
> > 
> > This is a collection of some miscellaneous clean-ups for fbcon and some
> > console drivers. Since v2, I rebased them on linux-next, added some
> > Reviewed-by: tags from Daniel and Greg, and rewrote the commit messages as
> > suggested by Jiri. See [1] for v2 links.
> > 
> > It does the following:
> > 
> >   - Garbage collect KD_FONT_OP_COPY callbacks since we disabled it
> >     recently. Mark it as obsolete.
> >   - Delete dummy con_font_op() callbacks. (Reviewed by Greg)
> > 
> >   - Add a charcount field to our new font descriptor, `struct font_desc`.
> >     (Reviewed by Daniel)
> >   - Do not use a hard-coded 256 for built-in font charcount in
> >     console/sticore.c, use the new charcount field of `struct font_desc`
> >     instead. (Reviewed by Daniel)
> >   - Similarly, in fbcon.c, avoid using the magic negative-indexing macro,
> >     FNTCHARCNT(). Set `vc->vc_font.charcount` properly and always use that
> >     instead.
> > 
> > Daniel, hopefully [5/5] removes FNTCHARCNT() for ever, but I have not
> > tested it sufficiently yet. I remember you mentioned elsewhere that
> > "fbtest.c" is insufficient for framebuffer testing, then how should we
> > test it? The first 4 patches should be fine.
> > 
> > Please reference commit messages for more information. Thank you!
> > 
> > [1] v2 links:
> > 
> > 2/5: https://lore.kernel.org/lkml/c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com/
> > 3/5: https://lore.kernel.org/lkml/20201028060533.1206307-1-yepeilin.cs@gmail.com/
> > 4/5: https://lore.kernel.org/lkml/c38042bbf5c9777c84900d56c09f3c156b32af48.1603788512.git.yepeilin.cs@gmail.com/
> > 5/5: https://lore.kernel.org/lkml/20201028155139.1220549-1-yepeilin.cs@gmail.com/
> > 
> > Peilin Ye (5):
> >   console: Delete unused con_font_copy() callback implementations
> >   console: Delete dummy con_font_set() and con_font_default() callback implementations
> >   Fonts: Add charcount field to font_desc
> >   parisc/sticore: Avoid hard-coding built-in font charcount
> >   fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount
> 
> Patches all look good to me, if Greg is ok with me applying the entire
> pile to drm-misc-next I'll do that next week.

Yes, please do!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
