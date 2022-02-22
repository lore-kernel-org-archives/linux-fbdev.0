Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F4C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Feb 2022 13:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiBVNBt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiBVNBt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 22 Feb 2022 08:01:49 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AFAAA2FC
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Feb 2022 05:01:23 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f11so11623664ljq.11
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Feb 2022 05:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=P8Fryrh/UfTp1Bt6LOv8QJW5oyWytViPC9OrCSUrMh0=;
        b=ZmzMcHsV4aFAGltbsqW1Ct43LoRMsjOPQ76v7zqeiWTy/Ozsv2kNXYAAWjighAaGwx
         1c3dbWLEbR3TboWjjkMFCovgaU7kdEtjndytJrgYvx8u/jbcyPjOEKrq+b5ehkJMWP+N
         5OvHQ5ot1IDrOAb8FeP229MSf9v3Bn0kgMhLdeYtT35lL115x6+PEjjoWyQgLL4gsgT1
         UaTy4eLdEwgH6qA2ywDFlOD83t4JalH8J3kXWVBm/muFXD87LsSgF1INo1QjVcmZqCXn
         NWFrX9PgYrZYSBoTOPpZ/05Ck0s9bsnGJsVaZTjdU24bLylGSCtp58BMRuq9/hKZoW4N
         eO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=P8Fryrh/UfTp1Bt6LOv8QJW5oyWytViPC9OrCSUrMh0=;
        b=mU5jtghyIb5USvYpf39MNpNljhkRa2+DPDw0RaBysjkVvxrktcHzvDxeAa+2GyBXiA
         if1AkKOSSfuS0SQgoIyjPEYLfSQsTRjkLz9G7lJOWRbVXf0ZKCXxk6oclieL1ts5aWcK
         7CWP0+fDH9f0BLm2Z8UHqXjwtAOtVI4U/79k+v0ZlQSEJavy0q7baiVlBh79YtJGGT73
         AZ6H1Dj4qd7HYl78nbRoeXt9/mwuzGdG6n94VaEOlyYGvcDeoX8sDdfeGR1MeUN7CrI9
         LOOtBNnjjEQx5EYdw6a46V/rMnHrD1mSWMr2J6dPiKXAYN6JsUQt+F5dnQ1+srJqD2/D
         Krhw==
X-Gm-Message-State: AOAM532KmCT4zw6j8S71BN4WICR9JjxX0dt4lb1oLTT8qce9Xx4K6IC2
        TUTVJVKFwd4qvXivCRRsqiQ=
X-Google-Smtp-Source: ABdhPJzu/yaIHb+pfJz4hSjGly2b6k2dPD29gtoRhayM+5TuhsABdfw6L/DEKEWI3lj3Des9pndb0w==
X-Received: by 2002:a05:651c:b0a:b0:246:46e5:ca20 with SMTP id b10-20020a05651c0b0a00b0024646e5ca20mr4383876ljr.66.1645534882032;
        Tue, 22 Feb 2022 05:01:22 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id m7sm1679595ljb.87.2022.02.22.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:01:21 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:01:11 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, sam@ravnborg.org, kraxel@redhat.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/5] fbdev: Improve performance of cfb_imageblit()
Message-ID: <20220222150111.506d2cee@eldfell>
In-Reply-To: <20220221195410.9172-5-tzimmermann@suse.de>
References: <20220221195410.9172-1-tzimmermann@suse.de>
        <20220221195410.9172-5-tzimmermann@suse.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2klQmeI41pZg2jcGNXHFF56";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

--Sig_/2klQmeI41pZg2jcGNXHFF56
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Feb 2022 20:54:09 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Improve the performance of sys_imageblit() by manually unrolling

sys?

> the inner blitting loop and moving some invariants out. The compiler
> failed to do this automatically. This change keeps cfb_imageblit()
> in sync with sys_imagebit().

This is correct here.

>=20
> A microbenchmark measures the average number of CPU cycles
> for sys_imageblit() after a stabilizing period of a few minutes

sys?

> (i7-4790, FullHD, simpledrm, kernel with debugging).
>=20
> sys_imageblit(), new: 15724 cycles

sys?

> cfb_imageblit(): old: 30566 cycles
>=20
> In the optimized case, cfb_imageblit() is now ~2x faster than before.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/cfbimgblt.c | 51 +++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 9 deletions(-)

Just noticed some confusion in the commit message.


Thanks,
pq

--Sig_/2klQmeI41pZg2jcGNXHFF56
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmIU3pcACgkQI1/ltBGq
qqeoJA/+PQ3+xQ+AEeMfrDoRKb2l0q6AgNwSlCUkdpXEz1zh5LrCvwjBLFpSHKur
tB8dm+1+ty5bPBo5plxMqYmFDoX0RcLYadsOjw3TZ39zSBx8L9BKMCT+qrvf9Fy4
wy8YgUnVseEppqksg4+qsOSW1rPE1U4aOY3E3xEnTm8IU4zdv39nm3GbSwoYXj40
DTkai6qWurRV3+JBbsu8Pw2L9UrNH0ETkivEgxFIvTC4crjqr67oKP9yMbJGoYAs
DqctM7UgayLerlNkj5ubJybQEYeGYB00rhtNeCM4HXtT/x1ICz9n9TbG0JZiEVJC
Uwk0jSSZe4aQ2K1cSoqBHlAhH+9UrGPomWA+R7AW3ebbct9bUZKlyeIy0MzocKwT
RCLu6aZDm1kwxNBUErcxzCEb7MzcmO1zsgOOqYHCCLq/V8/rU3Pv1SSdKzL4G8bw
k67HQwp+onIZB/astL3sClD3j418xZ52o6A/NRrF+IQOlPd5FA3bmhyvB7nggvPY
aHxpt79Y2WX3e5pzPdIaicdn3Z2W+svibAvxe94oLUu3Xwssg7FVwrL9QDADcZk2
WoJnlqeN9cMFEPWrp/r+0D7KTgJ2tq54Y4iKKIvJen5d14v7Q69JpDa5+tbgpPG6
N/HOFWvzICe2nKlNmsWG+grtlD26r2VZlDqPgjlPfHaMqkILWJY=
=WKNs
-----END PGP SIGNATURE-----

--Sig_/2klQmeI41pZg2jcGNXHFF56--
