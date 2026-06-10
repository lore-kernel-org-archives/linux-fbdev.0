Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB61FA859
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053110; cv=pass; b=Lcp9KyJF1dpM0sCtUZ+Af2MA4YuRm6Jkn8xx/TXslgjB6ZCgj53vQuCeHPoUPRGvgAYP1pRRrDg0s1QyhnEl2XATSnsE7lbpGtcSDzukShQUxyS71vv9WC0y9czS82ZbvL5op/LHSg52Zru9DSm519jZxGae0eMH1IcPKTwMTnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053110; c=relaxed/simple;
	bh=Tpl6l8U6i2ihTMI8RqZ3xiY20L9OW4IKGRcDKrG5+6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mN/cGuDI76YLNE24ECiYay+yGr7TSRWhx2LVNmjyD4bkItCfU5kpZC78qHbTt8fn0Ikn77aYFDMHNwE5rzNIjXgcxHzXzZigYEFy7Mz13+Iw57BquzIL+gI4CI8tBFrjiiilE07wX9eVbMrzLeZjsbMTxPZZpOfJWsgqllse1a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+zpi7Ek; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+zpi7Ek"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-becfa735b9aso825188766b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Jun 2026 17:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781053107; cv=none;
        d=google.com; s=arc-20240605;
        b=HHGs/kIVvN+BEhMQ151IZsowf78qQAa2qgpwXwlp9ru6lllmzKqoIRL/n5tF1qwNKG
         vzknYTKdwJzRnNoKVpkhFpGvE9JnkKuc3Oe1bt2nfWisafJqoDtqv+xjiiFyb+D554Ez
         7r//ciPOIMMlYmXX7pcMC47Jji5gZxoPnJdhjriDLaSWOn+DINmcqhtghLANrFsv2+NE
         n72JGuAMFIDnE3O/AnG5v4nvcUEqJ2vB0NbXeq/FBTYIRmabNypACNMrJuibMKMOkJRo
         xCtc5FYjvBRLjMyw+TyxGmL7eYmbLCqamzYVWAeWI+NfI+3eSekpw86ArpXWuy7jPSlA
         dNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tpl6l8U6i2ihTMI8RqZ3xiY20L9OW4IKGRcDKrG5+6Q=;
        fh=19ow7fK7QYrlrXQz287FH703msYXtw74FwSr5qqi8AI=;
        b=WlOf4i/xC6PhK2gsueR+dGt1ddOwBN/bD5O5Q5XS+DILbMiNanA63VsWA+gkclTN0d
         Qb8jlPU/xY6shRVmln/pWZpSCRflVDu0K70jF9Y3jpDkFmHPW5aMJMe0bOkgsn7P4UEn
         d1AXRaWD1iIvAOue66J4B3BYlpoW0blbM8SM6j0JCqTcrzgQO35vBRnAAVRUyKZ7NEgr
         N/O0IpiKSUJTHB2dJTUsmIY/30VA4t3AKFPVwHq5RdwNdMMCWMXh6tkS7UshspyoJ34A
         6dkEcJkyIIhBxubyVOpNn8JGEf8Ky2aH3036COyE4Hut39kQV4bCpEMdvv+PHzBpkQZL
         yDwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781053107; x=1781657907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tpl6l8U6i2ihTMI8RqZ3xiY20L9OW4IKGRcDKrG5+6Q=;
        b=S+zpi7Ekuc5nqyelQgxK07igc+JKsnHVEpL4RpjMRAdJjqjvuxd/HIidXFnnmrd2cC
         dEA569mhpCwDClw5h669wHfr7ct/expnkX5r2oAX8M6/87Je5Hkg4y/InkkGcbUdaaoS
         kHwpAsjLXJK98aNQXIGlcc74gXKAEvqgO/p83CpNovT81svy2nRXOS9J98hiLm6DmuN1
         Xcw8P3KOJBUFXagL39CucSnmw2FgQnYcHmwRlMiUPEyeGoJoeWI+rYA9Xe30ZXzMgI5G
         i+Nrzx3GYfn4hDC4QlvE19HnMT+lbvBvE+nZ/+o2zFUhETrTUts5qHwLD4aZLE7U2wBT
         ED3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781053107; x=1781657907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpl6l8U6i2ihTMI8RqZ3xiY20L9OW4IKGRcDKrG5+6Q=;
        b=jN9L2IUapB6Roi5ZoI/Welnk9LE6CJ7NHFtyOI21r3+EIZHnrJ7Z6TeVxZNaZNCnee
         FkhYk0rNFM3M0bnyJfI7JiiIwl/QMgavrxVdpGtuAZxthpZOIAphygg7C+YjfnKHxebs
         Jw/6hKW7U5mXjgANyIgShDz6lkgxTdRmu7n//0WNhUztyYoR9IPeEFko1EQvbyfZgPoV
         bF9Go7Gjxk7CmDEAyzgR2085MhppsFSYcZtvSAMHTNPyAlbi3NNCG/4/P5DAvNuIRJMi
         fVFJNDTXNCxKMsn3nzomwYt7bjopTDPVs3UyaKt5meqORX9DnucukP9pJXapYBsgOmaa
         F3Mw==
X-Forwarded-Encrypted: i=1; AFNElJ8zM8+p/A3aPa0d+9quM62Uo5Pu/1JU7nFoxG/dmL3mdDaMud2F83JXDT1cOLCl/AGsMB9d5YSRCOtv/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi95yu6fpeLXN3RyvHv/rXVClcfdnLK2BcLjeJGY6pvIGuDXGw
	H1CqYfG6fuTxoxYJBvwaapmzOn+FuDlgonSnY/D/wJ0N8usrn3tzuyVF/c0qcnw1MdiPYXv79SL
	LsfdusCGxYBvtHWESnrNcYkSMt4BkXVw=
X-Gm-Gg: Acq92OFUM2X+DR1dlwVjiuezk0SVDfgTcjPhY0EFtpcq8VuuAU+w3vc6ONoM1fi8wMW
	nDal5BQRO8TUu8Mo1rC9BCpCjswPTUg//SCLYkZEfTiFoISRF79Kt99yV7fqj036buKMjU6T+4d
	ud9bjYVUFna2xGXIyGcZ+gBtInDeLiqSD5B3/uCuDfalhGkT1GRgbWMX/5Iyro6JqrwPxlTg2OZ
	2SUWl1Jt2DjKQbV+Syr+eLYU1AgSmnre6ICNupGrQh26+1a8r2h6VPdbiFaoPPIBgt5E0XtZtvR
	cBZTW3qHtQVchQxTvX6l+okdWknAfPQVPw==
X-Received: by 2002:a17:906:8a76:b0:bec:da5b:5a6 with SMTP id
 a640c23a62f3a-bf370e6215fmr809390966b.21.1781053107289; Tue, 09 Jun 2026
 17:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609011736.17401-1-brockhaftner@gmail.com> <0d8d9f38-3cce-4da2-9ba8-f8e99f7b4dee@sezginduran.net>
In-Reply-To: <0d8d9f38-3cce-4da2-9ba8-f8e99f7b4dee@sezginduran.net>
From: Brock Haftner <brockhaftner@gmail.com>
Date: Tue, 9 Jun 2026 17:58:15 -0700
X-Gm-Features: AVVi8CeMcVJS6rxYbZttj4-L01-KcgRMD-E04JG978tAB95OThDR-UKWQ5st8N4
Message-ID: <CAAYiRaNgyHvtd34H1hR8wQk_5NYRB92QsnOWe9810mNYiZ6+8g@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array const
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 6/8/26, Ahmet Sezgin Duran wrote:
> Did you compile this patch while enabling sm750fb driver in the config?

No, I did not. I apologize for the mistake.
I ran make drivers/staging/sm750fb/ prior to submitting, however I
failed to realize the driver was not enabled in my .config.

Cheers,
Brock
