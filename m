Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792938573;
	b=yjDRm8ksG/0/9gX/wle/JYlTO+8JVe6WwGOkqBwf0CNbaNTI3Gc9YWNSfy4hlyTVyZjh
	 GqT2V2lgKx62uezfHBSh4683PRX3rsDiumaS22/piIR6LLjdv4F6UTOKMYBus+YMgqkN2
	 J6JS/ADG0FsFfllGqXUIpX14W7C9h+e5533Ly3YhNzD7icDLDyM1vp1Q5vn2u1pP+n8cZ
	 WlAHrwrF5cIrt2d0RKPgN7GAo7m25ISL9seEH9t0qW780hCfIYJ2pJ8e+JWRs4lRnLHnv
	 8V+/e83KcGxJidygETHJ+g3jty9MNyh8Nwgrcgyi8kjeDP7anyC4SBqAuUsxZ8aZS6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792938573;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type;
	bh=2BKKIgxIPoZr8J/FUp/cedQWkiYMf1a2nkly3MRtnMw=;
	b=Ue9hp3xrquXsPBnUXrFn4hR+cfiwecL1+KsSp/O5bI4LZpkbG9mNpaozE7cuAeN77Xge
	 iRdd5TvhIVPbilKpIFaNOUhZTr0gG+oh9vtJR+Di0A/OxQJxRt5X+2BenrWgTDpVMSFS+
	 l3kzpGBlTNFXA44U48E0whojW4eozva/9QDHTOO5sKMfuVajPphdAeecCwyUyknu5Q0z+
	 xhEtBHKNzkIkeas5kJ1g32mTmDXzfvF/unD5dDfog5k3XbVtmrO249L1mpBmHVx5+jvG6
	 lCiGLimtOnNLhPhMS+CtWezgb9J7tSj37lTcBiPJlEwUbd9jpZHH3/XMyP1+wCF3V3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=uNujRV+9;
	arc=none smtp.remote-ip=192.134.164.104
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88703606A31A;
	Sun, 25 Oct 2026 14:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88703606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=uNujRV+9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2BKKIgxIPoZr8J/FUp/cedQWkiYMf1a2nkly3MRtnMw=;
  b=uNujRV+9XwZ9okqEusv9WApetp+/Zl4stto1YJXWr19c3csujUuE72s0
   5N3FroebNwBgxJbjRDpjEZqCwPR8/tCYfB8mX6yMIHdaWUQNedWal/1R6
   rd/YZ0lNMoqT3+fHeBzgAhNiRZhXoRpmZ4IB5htoQB99OT7fe9ZALHoui
   U=;
X-CSE-ConnectionGUID: NtLnQcYzRAyYS63qRgeptA==
X-CSE-MsgGUID: 2Mafx0XZQR2gnyYycgdMSA==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,178,1787004000"; 
   d="scan'208";a="160810323"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.53])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 15:29:26 +0100
Date: Sun, 25 Oct 2026 10:29:20 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
cc: gregkh@linuxfoundation.org, andy@kernel.org, outreachy@lists.linux.dev, 
    linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: fb_upd161704: Replace udelay() with
 usleep_range()
In-Reply-To: <CAHxSwT_bdBdiwwXpGpr9+rGizZU3p+RsB18hPH5TxqMuMZOsQw@mail.gmail.com>
Message-ID: <7f65e825-b6eb-e7b-6bfc-a7549140c49c@inria.fr>
References: <CAHxSwT_bdBdiwwXpGpr9+rGizZU3p+RsB18hPH5TxqMuMZOsQw@mail.gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 25 Oct 2026, Abubakar Musa Samaila wrote:

> Replace udelay() calls inside the init_display() initialization
> sequence with usleep_range() to avoid CPU busy-waiting. Since
> init_display() runs in a non-atomic context, sleeping allows the CPU
> to yield, improving power efficiency and system responsiveness.


The patch fails when I try to apply it to the staging-next tree.

julia

>
> Signed-off-by: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
> ---
> v3:
> - Remove raw git headers from the email body per maintainer feedback.
> - Add a descriptive commit message body explaining the rationale for
> usleep_range().
>
> v2:
> - Send patch inline in the email body rather than as an attachment.
> - No functional changes to the code diff itself.
>
> v1:
>  drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fb_upd161704.c
> b/drivers/staging/fbtft/fb_upd161704.c
> index 7288140e7..94ae5bbf0 100644
> --- a/drivers/staging/fbtft/fb_upd161704.c
> +++ b/drivers/staging/fbtft/fb_upd161704.c
> @@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
>
>         /* oscillator start */
>         write_reg(par, 0x003A, 0x0001); /*Oscillator 0: stop, 1: operation */
> -       udelay(100);
> +       usleep_range(100, 150);
>
>         /* y-setting */
>         write_reg(par, 0x0024, 0x007B); /* amplitude setting */
> -       udelay(10);
> +       usleep_range(10, 20);
>         write_reg(par, 0x0025, 0x003B); /* amplitude setting */
>         write_reg(par, 0x0026, 0x0034); /* amplitude setting */
> -       udelay(10);
> +       usleep_range(10, 20);
>         write_reg(par, 0x0027, 0x0004); /* amplitude setting */
>         write_reg(par, 0x0052, 0x0025); /* circuit setting 1 */
> -       udelay(10);
> +       usleep_range(10, 20);
>         write_reg(par, 0x0053, 0x0033); /* circuit setting 2 */
>         write_reg(par, 0x0061, 0x001C); /* adjustment V10 positive polarity */
> -       udelay(10);
> +       usleep_range(10, 20);
>         write_reg(par, 0x0062, 0x002C); /* adjustment V9 negative polarity */
>         write_reg(par, 0x0063, 0x0022); /* adjustment V34 positive polarity */
> -       udelay(10);
> +       usleep_range(10, 20);
>         write_reg(par, 0x0064, 0x0027); /* adjustment V31 negative polarity */
> -       udelay(10);
> +       usleep_range(10, 20);
>         write_reg(par, 0x0065, 0x0014); /* adjustment V61 negative polarity */
> -       udelay(10);
> +       usleep_range(10, 20);
>         write_reg(par, 0x0066, 0x0010); /* adjustment V61 negative polarity */
>
>         /* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
> @@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
>
>         /* Power supply setting */
>         write_reg(par, 0x0019, 0x0000); /* DC/DC output setting */
> -       udelay(200);
> +       usleep_range(200, 250);
>         write_reg(par, 0x001A, 0x1000); /* DC/DC frequency setting */
>         write_reg(par, 0x001B, 0x0023); /* DC/DC rising setting */
>         write_reg(par, 0x001C, 0x0C01); /* Regulator voltage setting */
> --
> 2.34.1
>
