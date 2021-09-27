Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA500C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C287A60230
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 13:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhI0NdX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234487AbhI0NdW (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Sep 2021 09:33:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0216D60230;
        Mon, 27 Sep 2021 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632749504;
        bh=Y7TpDj/QBqC2VlX8snx4uk+a31fqoGg/z2dM9RwtnIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnndhq1ZLNDnrS4JI1a41cuT7L9dq/UQu27xBALiEGCG0R4aDPdqNjEeFfR04Mxv5
         /9+9kIrlI00L/y3hxMHlf3puV3jvA9B7HOTW7hWm/X2HI4+J+dNgdmukkkiBvZURmg
         rlp/iS1+CF296B5zqZ/zYJEklMwIumrjhAtdGafBAQTurlYD0Q9XOyT4DHIIzSlS6i
         PAcIJurcAQAxLnmNT3U+CYZ96wPihh88tBnpndW0llNNZj/y+WTh4+XG4Nri9bYXxm
         P9XNomrkGquyugt9frmrORpxtygM9rIlSL1Alr58GGcmrH2vFw/OtdOnVf3Z2J6PgE
         RyLxmNBSMf0CA==
Date:   Mon, 27 Sep 2021 14:30:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: hx8357: Add SPI device ID table
Message-ID: <20210927133055.GD4199@sirena.org.uk>
References: <20210922151014.49719-1-broonie@kernel.org>
 <20210927094200.a7d73sl2k4x5xjch@maple.lan>
 <20210927114727.GB4199@sirena.org.uk>
 <20210927132417.lixg3ojhnwlleht3@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20210927132417.lixg3ojhnwlleht3@maple.lan>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2021 at 02:24:17PM +0100, Daniel Thompson wrote:

> In that case what is the point of including unconsumed driver data? Most
> DT centric drivers that included this for modalias reasons leave it
> NULL.

It's mainly there because it's generated fairly mechanically from the OF
ID table - there's no great reason for it to be there while all
instantiation is done via DT.

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFRx44ACgkQJNaLcl1U
h9Bhygf/ZrAsGNGMlXufnXC4Lxqiwpr+9XQbCSi/nvdknGiuHzHfVpkmV7JvCmvk
gGPzR92SoXIbsacWvKKKXeAKI7gfhc32FpPBduy9Sh7uhvtU5FHwViHildoRql0w
AqHnzhmnRxTfHN0/kvi8A0rFo2fMObJc6g6WcJmNTcYnbN10+sZts9mPHb718bW7
BmmLbZOGRMrWE5R3CkKuEKk9zK5aAIdIub2AzdAtu/4fz3Qj+w1N07QTdS9POn0k
C0tCbeCo0oaF7mKlBgWN9bGMr34JD/OuZu6g8PIDN5E82M+6Lwdyq98/S9Qj00G8
sMe31uVf0/QUf9cVpyiEy8niSGt8lQ==
=2j3H
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
