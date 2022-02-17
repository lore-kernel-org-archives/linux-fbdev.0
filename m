Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274D5C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Feb 2022 10:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiBQKQc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:16:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiBQKQb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Feb 2022 05:16:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5312AB504
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 02:16:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t14so7489523ljh.8
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=Nmn0JSXYFz1hIDL1/wW7UG7AeNYS6zrR/HrLEhvymsE=;
        b=jR5xb9r/gmmYnscXhbvJ2QQFvZ6Ss1wVD9Vgdl8RN+VGj0IvjYWjpCjQnnW2Xp115Z
         33UAKaPW8ddVE9BCglp69WejxAyB3gMkg4k710k7R741WZgG46RUpRvo8i6a6cdxxlhs
         QGM7xHRKGoxZnr/gNaci9GzhUr6ItBwg307/59qxzryDHvTCsTf+RbwTBJjXhBVPgkFd
         hyi2WNIaRGkRHhxMKSARuoTE8ZMGhVhwtlZLDRs5IJu2DSXTXmMWwiD8E3jvvD6BplSg
         0FCWayja7aYhNPGvYJjoAyPzdIwUvuCHQUnvowYB0/MvvyJzWXHPlxppq/yTIq651B13
         zwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=Nmn0JSXYFz1hIDL1/wW7UG7AeNYS6zrR/HrLEhvymsE=;
        b=QP+RM3IML4Hf+jZ/rLn2URCp0kQJj+iEN+SaXBGgF2PHkg2+cz2PMxeKkGJU+a9e6R
         f/UUcCqbu9HDPVZCVdfrwixoE4+lRwOV4K4Tuz7BnFxP5edG8oa3L0NfEc0ILinP0bVn
         yhKqTTvS/xc5kmBoQ1Ao1sg3Btq6G7KYc8Kln/+07W/Cwt/7FG10DSGQmHZuigUmILRR
         2Q88IVo+J8augnrJSsOZY5Wa8PdkGSnpp21zTiqCngiUij3jURm/JpFqh7xWKB/DBidu
         TxDT6OFttkE4IqiWpTcWoAeBnF+VSmUqBgSDSfhgDmNwK+k5Q3hkUJyeFYJqevYi8P5+
         +B8A==
X-Gm-Message-State: AOAM531ZTa9xfdgsYiVWH01SchQa79xn7gM2RAfcPKpfT1w4eErPxd2G
        d0BOXj9rNlCeY9dPRs1uNew=
X-Google-Smtp-Source: ABdhPJxge2OqSJsRoRKCis0JK1JOOZ0Hr2b1Ohcf8DyG+ZIs9S178aJsxYZE+MEzrO8QphYqbbEt8g==
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id 7-20020a05651c00c700b00244f9d77c48mr1800342ljr.300.1645092975792;
        Thu, 17 Feb 2022 02:16:15 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id t20sm88159lfe.277.2022.02.17.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 02:16:15 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:16:12 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] linux/fb.h: Spelling s/palette/palette/
Message-ID: <20220217121612.66011b8c@eldfell>
In-Reply-To: <20220216083922.2913515-1-geert@linux-m68k.org>
References: <20220216083922.2913515-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_HUuAzPNnPIuJlK_Inr6/=4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

--Sig_/_HUuAzPNnPIuJlK_Inr6/=4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Feb 2022 09:39:22 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Fix a misspelling of "palette" in a comment.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  include/uapi/linux/fb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
> index 4c14e8be7267761b..3a49913d006c9bf6 100644
> --- a/include/uapi/linux/fb.h
> +++ b/include/uapi/linux/fb.h
> @@ -182,7 +182,7 @@ struct fb_fix_screeninfo {
>   *
>   * For pseudocolor: offset and length should be the same for all color
>   * components. Offset specifies the position of the least significant bit
> - * of the pallette index in a pixel value. Length indicates the number
> + * of the palette index in a pixel value. Length indicates the number
>   * of available palette entries (i.e. # of entries =3D 1 << length).
>   */
>  struct fb_bitfield {

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_/_HUuAzPNnPIuJlK_Inr6/=4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmIOIGwACgkQI1/ltBGq
qqc2wBAAimjDWNfhRvmN1ywJLVoX6Zm68Sz18nAxeBNxhwkSMOU02YP3CbyL2gPA
Rn0eL/PpbG9sJV1hZqHgskZILdV5u6rNTHY5HBYSV0PAIjSOpNUKHQkXg405vFrm
ywEx32oUFuUIGV+c455v6qy1kubU/GwBRdXvFiD+IX+VgenW6I9fu71ZPJeq6D0f
Vhb0p48pd03hBLhgs0405OvHcOra/4aPcFHhx57AVd7DGDvOS0PGmhElCLluKeiB
5CLtAh1MC1Y7nafoRNJ5hquOCx14kWPBk1cOmxGcZ5RP9aA/66gKnB7wE7UVYNP9
TIiKr68O6ocvuKy5iBYgjmXWabugbIvl+YozDKj/UvQpRcE5UxiHUjLu3mYYfypb
OTuOPTbJiTtTjvnMkwk16ex/SwLEd3tK1c0wubbnZ/RcW3vlrL23IX72b6bYohca
/jIIU3r7WCZdCYa5qmdkfAkm2sDbOw0YqHT1JseGvqdG53Cp+9YtUdsd7wXF3xhL
CWMLhI94FQOUmfOcDhBWvgq2Lpe5uhh/daAQsaZUfYO1oBQWaw1GRPLg6urnTouC
YSP17QPPkG6pjEY3XhQeWsPaFXxCTCu+4FoqZSpuC8lEjrA/ObuziSr8/uvNoZW1
fRLJYTvVwt7vyEPohUvwIwBImwajIV6rnJS7V8j4fQj+SdW+Czg=
=75si
-----END PGP SIGNATURE-----

--Sig_/_HUuAzPNnPIuJlK_Inr6/=4--
