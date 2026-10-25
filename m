Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792928515;
	b=tTlmgIjqp9eZjonjVCAbMS+maMTRdyRPH/z9oILKDWISXnAweL2acL3VFbC3UoLN52IT
	 k4ECq80LI/rytlkCu5mYgAap+hLUoo2aBg8Edqsjvai3L4F7epfYV5uufskJFPvq8sBjD
	 ah+9VG1+FTU6Ms3DmID0KMeDB2gAtvbUjLp0mtVL+8y723yDxFTUg6C94pgQjkTGuEU5H
	 kh33dcB6tscXHLYq1eg/pRCyptoxLRg6irhrj8VretqvuDgcWB+lNkToQlAisSGhmLswr
	 35N7UCviZA+8cDryTlv2b7A9Kqj3rBAzOxEyvuomCV71Jj8h7ilfpgjjRxUpp0Zseqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928515;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Content-Type:Content-Transfer-Encoding:From:
	 Mime-Version:Subject:Date:Message-Id:References:Cc:In-Reply-To:To:
	 X-Mailer;
	bh=KbsdRHpqg1KqFzqFFAQ9GvFksML0SMYhMlnLwPDnewc=;
	b=rdgjEhU7xnpjXbfLWr+CIe8QzHzVi6kdPNM+0AOQz00XSgLt0K7a/qeq+kG6XEB08P6B
	 yTsI88v5CU4aKi5snnnSNyuvr+9cAyEp33I86qVCUsXeWq/81rxYvzfwuqenOWBPYqCeD
	 DxPX8DbioRGcQuD0bSzRneuuY76eXO8jQ0G7fcTCy0BCt1ndS2jE2UJtQgqaNEb85Sfuw
	 HqMoSwaKNG2m1Wb5lZHnfbL/YOl2aEk+6kCgdan3Md3m+Vf8xkNhDXjIYfd/skF5V9hJq
	 iwfboqqd9FkKx4digPh/6ZuDDNGAGuS4owkC1E3vgvRt8nkDbSUlp0smUCHynVp5mNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=OikXoF75;
	arc=none smtp.remote-ip=192.134.164.83
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F608606A31A;
	Sun, 25 Oct 2026 11:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F608606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=OikXoF75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=KbsdRHpqg1KqFzqFFAQ9GvFksML0SMYhMlnLwPDnewc=;
  b=OikXoF755J/CTql/wDRgEMEgTZzmyMAOtLltc3gVl7GMj+YtdJm/opgT
   ctBtjXVv8T1ySGHs2BsW4HepEqCTQvrzNT0NZh1rUXvMCUNzOGw3Zbpqz
   qMeZls1BXT7utt0JsIQ5LqyceUPLTBTYHpF9Df7zKhck6MyP6+zsXH6xD
   Y=;
X-CSE-ConnectionGUID: DbtlcMypTCG9i3bDwhzwiw==
X-CSE-MsgGUID: Rb2sav4iQY2qd9gkiG63zQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,177,1787004000"; 
   d="scan'208";a="302212097"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO smtpclient.apple) ([76.123.3.53])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:41:43 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] staging: fbtft: fb_upd161704: Replace udelay() with usleep_range()
Date: Sun, 25 Oct 2026 07:41:31 -0400
Message-Id: <A0882440-865F-43CB-BA8A-FBB2A07B7404@inria.fr>
References: <CAHxSwT_ya=kxLdQkx5iY6DdVbxDv9MP5shRUF5-yDUvM=cFpKw@mail.gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
 linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <CAHxSwT_ya=kxLdQkx5iY6DdVbxDv9MP5shRUF5-yDUvM=cFpKw@mail.gmail.com>
To: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
X-Mailer: iPhone Mail (23E261)



> On 25 Oct 2026, at 05:53, Abubakar Musa Samaila <abubakarmusasamaila@gmail=
.com> wrote:
>=20
> =EF=BB=BF=46rom 778030aa9291e3a7d40ffb03b19e6877041cddc8 Mon Sep 17 00:00:=
00 2001
> From: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
> Date: Sat, 24 Oct 2026 12:02:25 +0100
> Subject: [PATCH v2] staging: fbtft: fb_upd161704: Replace udelay() with
> usleep_range()

This is still not correct. All of this From, Date information should not be i=
n the message. And there should be a log message describing the change, not j=
ust a description in the subject line. Please look at the patches sent by ot=
hers and reread the tutorial to see what steps you have done wrong.


>=20
> Signed-off-by: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
> ---
> v2:
> - Send patch inline in the email body rather than as an attachment.
> - No functional changes to the code diff itself.
>=20
> v1:
> drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/staging/fbtft/fb_upd161704.c
> b/drivers/staging/fbtft/fb_upd161704.c
> index 7288140e7..94ae5bbf0 100644
> --- a/drivers/staging/fbtft/fb_upd161704.c
> +++ b/drivers/staging/fbtft/fb_upd161704.c
> @@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
>=20
>        /* oscillator start */
>        write_reg(par, 0x003A, 0x0001); /*Oscillator 0: stop, 1: operation *=
/
> -       udelay(100);
> +       usleep_range(100, 150);

You need to also check the archives to see whether the change is welcome. Gr=
eg tends to reject this change unless you have tested it because you are cha=
nging the behavior of the driver.  Without testing you don=E2=80=99t know if=
 you have chosen the correct range.

Julia



>=20
>        /* y-setting */
>        write_reg(par, 0x0024, 0x007B); /* amplitude setting */
> -       udelay(10);
> +       usleep_range(10, 20);
>        write_reg(par, 0x0025, 0x003B); /* amplitude setting */
>        write_reg(par, 0x0026, 0x0034); /* amplitude setting */
> -       udelay(10);
> +       usleep_range(10, 20);
>        write_reg(par, 0x0027, 0x0004); /* amplitude setting */
>        write_reg(par, 0x0052, 0x0025); /* circuit setting 1 */
> -       udelay(10);
> +       usleep_range(10, 20);
>        write_reg(par, 0x0053, 0x0033); /* circuit setting 2 */
>        write_reg(par, 0x0061, 0x001C); /* adjustment V10 positive polarity=
 */
> -       udelay(10);
> +       usleep_range(10, 20);
>        write_reg(par, 0x0062, 0x002C); /* adjustment V9 negative polarity *=
/
>        write_reg(par, 0x0063, 0x0022); /* adjustment V34 positive polarity=
 */
> -       udelay(10);
> +       usleep_range(10, 20);
>        write_reg(par, 0x0064, 0x0027); /* adjustment V31 negative polarity=
 */
> -       udelay(10);
> +       usleep_range(10, 20);
>        write_reg(par, 0x0065, 0x0014); /* adjustment V61 negative polarity=
 */
> -       udelay(10);
> +       usleep_range(10, 20);
>        write_reg(par, 0x0066, 0x0010); /* adjustment V61 negative polarity=
 */
>=20
>        /* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
> @@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
>=20
>        /* Power supply setting */
>        write_reg(par, 0x0019, 0x0000); /* DC/DC output setting */
> -       udelay(200);
> +       usleep_range(200, 250);
>        write_reg(par, 0x001A, 0x1000); /* DC/DC frequency setting */
>        write_reg(par, 0x001B, 0x0023); /* DC/DC rising setting */
>        write_reg(par, 0x001C, 0x0C01); /* Regulator voltage setting */
> --
> 2.34.1

