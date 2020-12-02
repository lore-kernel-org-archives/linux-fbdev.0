Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E966C64E8A
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Dec 2020 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC27522203
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Dec 2020 08:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgLBIaG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgLBIaG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Dec 2020 03:30:06 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7855C0613D4;
        Wed,  2 Dec 2020 00:29:25 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id j205so2872241lfj.6;
        Wed, 02 Dec 2020 00:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=biK7JJVrreau9v60BgcXO3v9ensQ2L5LMNNBA6JmLGw=;
        b=vJsHOZE1VGNGGjXjAMFMN2aYZJwJR+ZOuokoECcXK5H/ZFVBbjSZGdLT57a+9H/CpW
         IWrmh8mJ9xAHDaTGBDjDoO2lJs0ihc+dvgLh07ra1kVbsDNDVv6hLRg3Hq6yBJkIEGFH
         Pd4bRalZQ/mJ91nkKmhULTLLPzWZvgVH4xByoIo82lBuS6WH9btpULOhvLgMHqOM/RWA
         MFo1UyjRMWSEDA+htq4ftjm5Zq8cflN9VQEjAmu0ASQA15pOuK4Tt4gFVrlLLroOtmpt
         wwyzp0wsSZD7WQi2PmnH2ZrJvjpom9090eexqyKynWWcanuC/lBp/cPi2bf/mqzA5Rn2
         sMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=biK7JJVrreau9v60BgcXO3v9ensQ2L5LMNNBA6JmLGw=;
        b=MH37Fsm0PBPExsdxurvB6aXNzkP3Jn540d1HJn5vrU/vhoYyMuM+7PoMrbf0yNk1Md
         QDVXEcXrCTKm0dKZ8jzjRZUC+N7rvdvmPVV2Mmt2x9uicL0iE49qnaJZ29QY96D7SFKD
         dYoY0WV2UUvVWsvkAE3KHWsBIeDq4ven49eE/jjlm3Wv5IydWfsXdaSQbEbEOqqZs49u
         Txj2V+9FwYu/AveRfdxq+AwODCiPNmAFAT0RYgg69yisI6t3TM8hSowdQdeWbZdwxW33
         bXw13gWiwQROUMpnIdpFAqdIJBrIl3Aie0KcK28h1cADUvLGADL8PA/6m5c1FZ8BM3g6
         Pb2g==
X-Gm-Message-State: AOAM532oMpLRiYqvj0WVxa1V9PM6zVK/El9lYk3kjRPlZBHyVlyUb97G
        Fsj8fZwYIIk2rdWW1+yezvw=
X-Google-Smtp-Source: ABdhPJz4+SJ0A3xVoyju4k3W66QVlnXZ9Z0cwsNeOmZftsdzyArYcaYS75SUI9RkA6V2MLnCefXsvg==
X-Received: by 2002:a19:c191:: with SMTP id r139mr783336lff.258.1606897764254;
        Wed, 02 Dec 2020 00:29:24 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id y14sm269379ljy.29.2020.12.02.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 00:29:23 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:29:13 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, geert+renesas@glider.be,
        linux-doc@vger.kernel.org, daniel.vetter@ffwll.ch, corbet@lwn.net,
        bernie@plugable.com, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org
Subject: Re: [PATCH] fbdev: Remove udlfb driver
Message-ID: <20201202102913.56baa457@eldfell>
In-Reply-To: <9e7cad29-a9c0-2e02-04a9-3149d7e15838@suse.de>
References: <20201130125200.10416-1-tzimmermann@suse.de>
        <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
        <20201130154147.GT401619@phenom.ffwll.local>
        <alpine.LRH.2.02.2011301241470.21432@file01.intranet.prod.int.rdu2.redhat.com>
        <ac639546-d97e-b197-8998-180b0535fae2@suse.de>
        <alpine.LRH.2.02.2012010615080.1371@file01.intranet.prod.int.rdu2.redhat.com>
        <9e7cad29-a9c0-2e02-04a9-3149d7e15838@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ub9bu0HMJ.BX_LoHkrBsRqE"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

--Sig_/Ub9bu0HMJ.BX_LoHkrBsRqE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Dec 2020 08:55:52 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
>=20
> Am 01.12.20 um 12:20 schrieb Mikulas Patocka:
> >=20
> >=20
> > On Tue, 1 Dec 2020, Thomas Zimmermann wrote:
> >  =20

...

> >> And why can links not run as DRM master mode? If it renders to the ter=
minal,
> >> it should act like a composer. In that case it almost certainly wants =
master
> >> status.
> >>
> >> Best regards
> >> Thomas =20
> >=20
> > How can a userspace program acquire master mode without being suid? =20
>=20
> For my understanding, there's no easy solution to that. :/

Hi,

there are several ways, though whether they are "easy" depends on your
mindset.

The best thing is to connect to logind D-Bus API and ask that for
session control, set up your session, and logind will open all input
and DRM devices for you, and logind will even handle most of the
complicated setup, DRM master and VT-switching for you.

Or, if no-one else has the DRM device open and you open it, you
automatically become DRM master. AFAIU, after recent kernel changes, it
is even possible to use dropMaster and setMaster after this without
being root, as long as you once in the file description lifetime had
DRM master.

Since this is about switching from fbdev to KMS API, you already have
all the tricky, complicated, arcane code to deal with tty setup and
VT-switching.

However, doing all that patching to all apps you want to use is such an
effort, that I'd ask if it would not be easier to just run a
light-weight Wayland compositor and run your apps in Wayland mode. Of
course, that requires choosing apps that run on Wayland to begin with,
so maybe it's not for you.


Thanks,
pq

--Sig_/Ub9bu0HMJ.BX_LoHkrBsRqE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl/HUFkACgkQI1/ltBGq
qqddsw/+KxYidO3CAHQE+G+VtuSREAtDTVDUxAGMOzOlIue7rYw8Ldf+YJnbQ/VT
vH7ssslBy3mfYEjAPlYPQW2MbFAFjiFyIcJ/qk42QmOagrdBsFJBIK19tT7nJobb
4E7MuLo2EYZNAyAaVg+qtRUFuZ/Cy5HedAVb9f8Nvka7exEXOW+UMaUPvTxz2ai5
SQBvZXU6rgmudc1Yo1BRvBPBg1dRzixgS43jAMV3TnrJ4y9lASlpfntYjugsELln
h0sA6RYgW7H6WsdiAwaRnMgq3UU4L1dM0QoOGViI9cM3tXgveQ++EYebRZ0dDd4B
ByTp1fl+ULY0STvWRx02Beddz1b4FvpoU5p2WABCD6yDKzEzIlNwnNejFeDtMBME
9FUBZoFPXSUuj1J/ol4dOW6zK4ua/8g2Fxmltvg4+MB0+LCZLR0N95gB9iyAtX8U
bAzbrY2vHxxLVjrYXHY+pieTrhAku76CPlBtpZuKdlbJT0ZdEiz8FuHupSI8qm2C
WFFzEXSIweA/6KX4W7j4WSP6cr8u/Uxy3Q6PExUkV7hBDy3mZqjDwiGnnB0uLKrn
Z0GKiUt9ATq1B2XiSq40qs0xxroJgsRaeApI6AttFLQFxa4AumrWRWiAsqIxpbkB
cekof+u1hUPt6UlKpuRE4fAW1ILO8I3ekb7oqcKiR64cCHGm96M=
=L5KJ
-----END PGP SIGNATURE-----

--Sig_/Ub9bu0HMJ.BX_LoHkrBsRqE--
