Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB02AC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 11:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938A860F6C
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 11:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhI0Ltx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhI0Ltx (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Sep 2021 07:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF3FC60EFD;
        Mon, 27 Sep 2021 11:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632743295;
        bh=r6M0+88pXzTTjWbgeCRwzSRe+5vX1+h9NbCl4Huh2VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjQl/s5UCzi3u3mhXwkqLQLEUzE45IIGqv6RZ6oKp3TQFS6PtUgGMeXHSGu3CqSOx
         J+c3baOwCVX+P1IQ00HYjKznpQRzuuCKJSHqmtRhxq9BWdv6QYbQ/6qmw92IE5AiNr
         2fp1PKY6Uy66do+5p3CZfNUBE2kHPk/zU4YBYpOdnqEY447gsqkX5RRDWV0HQPVY+O
         4x4DTJAkfWZnuhsQ1szGHGW/mpMt0d+TgjyKp0uguzdXmMrVacp9jQesSciri1i9xi
         OZYVSNPGeBxZ/siyhB9ZKhLtirf1uCRa3lISsMuctkIUpLQsaG65DW7h0THkd4lmLJ
         bmkOidr9JjEqw==
Date:   Mon, 27 Sep 2021 12:47:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: hx8357: Add SPI device ID table
Message-ID: <20210927114727.GB4199@sirena.org.uk>
References: <20210922151014.49719-1-broonie@kernel.org>
 <20210927094200.a7d73sl2k4x5xjch@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20210927094200.a7d73sl2k4x5xjch@maple.lan>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2021 at 10:42:00AM +0100, Daniel Thompson wrote:

> Based on this I had expected to find spi_get_device_id() and a ->driver_d=
ata
> somewhere in this patch.

> Where will this .driver_data be consumed?=20

It will never be consumed unless someone writes a board file - the
runtime match will still happen based on the DT compatible, this is only
there for the modalias.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFRr04ACgkQJNaLcl1U
h9Cf7Af/VgDQZFZr2I0tn/rlQJH5fGsssPODLj14w7OyuFbiRkDVkkiUcBfH/SUq
fVCVl5YLLyXsYL40zgxjgrOxA2hojUAmRcEdwdkFb3/rG/S9fQvXP8S1rKHXU/Lr
wLqjFCaltQTWUJF106ftCLbMHWRSuKTxuyzspT9pcDv4hSSLPjVfFZBcjZGQoLfb
itiFWMsotg9ZENUG7buWsSS8RzLuq0Cb1K7aw5wFoG2w0SYM/cjWQC/XNtBDcugF
18u01ACkqD7Ml2wDPAAs6h6RBKeV05gnnSf8hvyxdGlN+26toDdy+fVw0c2PYbdg
8WWG8N66Zu8YhUep3BMGEhFeCgrzHA==
=QX1Q
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
