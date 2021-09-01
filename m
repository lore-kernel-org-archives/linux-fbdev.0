Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE84C4320A
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Sep 2021 19:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9655C6102A
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Sep 2021 19:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbhIATaU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:30:20 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:35858 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhIATaU (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 1 Sep 2021 15:30:20 -0400
Received: from g550jk.localnet (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4280ACA11B;
        Wed,  1 Sep 2021 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1630524559; bh=0H/X2fUD2T06MoUgfBCJPfMjregzSG/7Yg0C8emnr9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eKxmw25/GlXk8ZgdZq1qnrFluDvsDRg+0AGxqUiqp9JyElSo/UnkDtjzPRM/1N//w
         pjkMeEpP/jPg9VJpMMEVa9zkZQyBOSbEBfiFWsOosYObhELen29s7ek5vN2xaCRU6H
         PPOhDZCJtPg4xC0KuZ/5t6wAV8T/wI9fTYboOJT4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: add missing simple-framebuffer formats
Date:   Wed, 01 Sep 2021 21:29:18 +0200
Message-ID: <1648705.hQpMTjSAMY@g550jk>
In-Reply-To: <YS6fZ4nFgic1DYhR@robh.at.kernel.org>
References: <20210828110206.142899-1-luca@z3ntu.xyz> <YS6fZ4nFgic1DYhR@robh.at.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Rob,

On Dienstag, 31. August 2021 23:30:15 CEST Rob Herring wrote:
> On Sat, Aug 28, 2021 at 01:02:05PM +0200, Luca Weiss wrote:
> > Document all formats currently present in include/linux/platform_data/
> > simplefb.h
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  .../bindings/display/simple-framebuffer.yaml         | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml index
> > c2499a7906f5..c1acd2859ae8 100644
> > --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > 
> > @@ -83,13 +83,25 @@ properties:
> >    format:
> >      description: >
> >      
> >        Format of the framebuffer:
> > +        * `a1r5g5b5` - 16-bit pixels, d[15]=a, d[14:10]=r, d[9:5]=g,
> > d[4:0]=b +        * `a2r10g10b10` - 32-bit pixels, d[31:30]=a,
> > d[29:20]=r, d[19:10]=g, d[9:0]=b
> Not a new problem, but are these 32-bit big or little endian words? That
> should be figured out before we add more.

As I'm neither involved in the driver nor really have any knowledge on pixel 
formats, maybe the maintainers of the binding can help out here?
(Bartlomiej Zolnierkiewicz & Hans de Goede, both are CC'ed)

I can probably dig through the sources and guess but documentation should be 
written without guessing :)

Regards
Luca




