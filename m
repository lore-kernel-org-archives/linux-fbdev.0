Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22084C04FF3
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 May 2021 11:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021C46128D
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 May 2021 11:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhEXLuR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 May 2021 07:50:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38229 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232476AbhEXLuP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 May 2021 07:50:15 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7984B5C00DD;
        Mon, 24 May 2021 07:48:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 May 2021 07:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=M4uM525A9EdEenfyxCSJtV/Cbcv
        IXk+39bR9IA9px/U=; b=iMu3Rv0rHb3pir9dfEXjv6ff2o1LbLMJjM64SZCAU8x
        5YQKepeJfH4e6PoWcGl+pozTWs+QlylG39XiORO4inBCY6Et564KBwJHTCgjtA7K
        2w0gf93w11s9HqEgcK+mhDPKYqYJMizGG+0pJFn2q7VUcdWbKL+k06vga+rRi88K
        DYuMeHuf0kyL+mu1jPemf38HYoZO2uqH+RbXUE3Z4HibFNhYyj8iUSGKMrjDrzNd
        sLx2UUrcKppEz3ntnPiysZe/7QrLHuglMZyefUAUgmoMUVhHKphdBcgJSo6QU5sR
        lM50elpIGGE3g7LlKIAARXDAbCU4gyl+rlesmazkb4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=M4uM52
        5A9EdEenfyxCSJtV/CbcvIXk+39bR9IA9px/U=; b=bswJFF6a1D0WyWPTe8CpsT
        NP/Bob8ujcHOUY5RlnKWpWqLElVFegnizJtBU+lRZxmW1w0MvQRkFc79FuoEhAvA
        C1kJwy1ic9sqPvl2t0HDhnS9wd0qlHnN3yw4q/WPkYSpfOgVfaJb8w5ytpzZexgA
        yqQIXxUoMcMw9dBQ1B9OAPZidWDKTuZiB7woaAJG8fvcwyYKJ5nHL/gxNgoOfOCO
        VpBS2gFCASvFIJELJFCjHXIqQpYgVdWfJk+cBOlqZMh15/eHMqDLC3LfIzaCSYgU
        8UanokcIVa46kbqZELbKWrPNJrbdXf8iDS76BG6ZmYwUBTqgB680Vy7+u1bnsmYQ
        ==
X-ME-Sender: <xms:npKrYCJlDHx4cjgsUHnRtbxk3cCjyFNEMCSeffxlb2akbKC9GoVo7g>
    <xme:npKrYKK3cfOr3r34JkXL_dETk1Q7kWa_bSHZh39P1hEHWiKh1QJQ_0BBCjVtLxQIt
    6Q-Ba1ph1D0XU62fxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:npKrYCsUH49U1F8x0TFg08IF39GvQvUKoLdeqTEzRHZBugKJ8df8jg>
    <xmx:npKrYHak4QJRgP6B1DG26CVYBX9GCj2agLrBig1vPZHkFuJp917dUA>
    <xmx:npKrYJbO4CBCosN0qrOnGH9UfqZK4rihhZ1pwquqim21F09g7rgyDA>
    <xmx:n5KrYIU7wE7lfz739K4RSLbdMW2XXDQ_Q3xl0FVYbV5jwf0X1Jb7AQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 07:48:46 -0400 (EDT)
Date:   Mon, 24 May 2021 13:48:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: display: ssd1307fb: Convert to json-schema
Message-ID: <20210524114843.ihhgdhup7crskf4j@gilmour>
References: <20210518075131.1463091-1-geert@linux-m68k.org>
 <20210518143317.yy2sxxnd7yt6cyrx@gilmour>
 <CAMuHMdXKaLpLL5Q1FnjHJ5kbs=+9Mm-QHXZp1i3M4zNr7G=e_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kawgr3kfamzs2jih"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXKaLpLL5Q1FnjHJ5kbs=+9Mm-QHXZp1i3M4zNr7G=e_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--kawgr3kfamzs2jih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, May 18, 2021 at 04:49:45PM +0200, Geert Uytterhoeven wrote:
> On Tue, May 18, 2021 at 4:33 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > On Tue, May 18, 2021 at 09:51:31AM +0200, Geert Uytterhoeven wrote:
> > > Convert the Solomon SSD1307 Framebuffer Device Tree binding
> > > documentation to json-schema.
> > >
> > > Fix the spelling of the "pwms" property.
> > > Document default values.
> > > Make properties with default values not required.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > > I have listed Maxime as the maintainer, as he wrote the original driv=
er
> > > and bindings.  Maxime: Please scream if this is inappropriate ;-)
> >
> > Fine by me :)
>=20
> Thanks!
>=20
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>=20
> > > +  solomon,dclk-div:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 1
> > > +    maximum: 16
> > > +    description:
> > > +      Clock divisor. The default value is controller-dependent.
> >
> > I guess we could document the default using an if / else statement?
>=20
> While clk-div has only two different defaults, dclk-frq has different
> defaults for each of the 4 variants supported.
>=20
> Do you think it's worthwhile doing that? All upstream DTS files lack
> these properties, thus use the default values.

I'd say it's even more important if everyone relies on it :)

Maxime

--kawgr3kfamzs2jih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKuSmwAKCRDj7w1vZxhR
xQUrAQDztdpV83mKelLkQAL8eURDG6cd9gD/7Ntvbg03LHwmWQD+JLtjeb3ucmns
yhOJHM5mokmAm7CAdDYGH4BhqetBzw0=
=C6df
-----END PGP SIGNATURE-----

--kawgr3kfamzs2jih--
