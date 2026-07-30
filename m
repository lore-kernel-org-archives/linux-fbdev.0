Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FB3D3D10
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402711; cv=pass; b=CABSmkhtE0zqz76w/5dnPXAVqVU7vqoFXttaQvnlIxvPXMyRgLh/QmKXCXAN2cRWxRna9hEPuqXRmpBwbUEIsQTK1sg7XIdsf5An6pvahlPncteefjrGHD6fifg03DdbQsDjPeykiUK3u6pHcXt64UO5DPqlgg5RRNfhSwZVof8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402711; c=relaxed/simple;
	bh=rNT8uuAYIOIz9by9aY3qoAX6TR1FHkQuOah2tZDQCkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEFTBLGSMLzlbxqAVlXSmG+/h5+5idzaxyjVoRc+GH//QQiW/+hHkPWLrT7lRB8U0V+tzQ0ZxsaF+CFfBEGceMC1CRxMqkf5RvaUO8WzZdCS0LbIyjknKfCQZArcc/x1qKUlwJGDTba8zMuqMGIg/RM/Qq2zZdPIrHT+3u+7ZTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfZzEIeQ; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfZzEIeQ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c12614b81c9so338935066b.3
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 02:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785402708; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMuis74npNq2/B4BKlRgcgaBhbfeAFDLELpaYyePyHy3KvQU1/IyKt5EJ2FLObmN+b
         RyWJ+K+8Yhk0sRmEFwLK6KWAc7HSS0WO2MKJhu/CIta3cZVg/mo6v3BIGnC09EOn2YzS
         cqRZBlFS1wCGHlvC4+5Vl+MCVgJ9z/UABobhBkQk+hJLQ6+oi/StBzMzAIsz3hGa7S+J
         Wii88rJY+dfSLI5mDQovespenVGVywaCwcM/w15WSdl9oPmTmAOe2yEfAoMbGfbfPoc8
         /9SBIy9n3yKeId6Z2yv/XJWQNmPE/p4bUf9d5pbSfm+l3q6hdawMMjTD0FuMzy8jKQD3
         uTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rNT8uuAYIOIz9by9aY3qoAX6TR1FHkQuOah2tZDQCkE=;
        fh=0Qs9nnxSRrTeH7JAiI1M9EwfadjAk/6skM1xKvdgubE=;
        b=kO4Rek8jotSjOxo/G4pI7w7B8bn1BwF0OL77JNvdCxnLHn2NNKP1PVZQhS+vIE+KP1
         xQ111rmInrXw9l9vMuaAr8bs021pPWjlnWS24ibYgpxzjCddZmnjhwz+JGdFa2YxQwi3
         8cW/oAEKDPoClQrThnmBiwSxXQ1a+pClDacZqmq9It1lYELmfuzw0DsynVf7MS+/Ocuj
         qxsIuzsTFJhnG/C2NK7lYSs6hH1N/uIvA1gEb2Mb1Janm40vAxQH1RZKbF0v+EinHUJ0
         S5VwLlMCB2NFOgyVtRLfd/kz9jxFLZqCs0FgMmuSD+tu2vQ5QcMib/tKVp1T/x3prMtK
         c+8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785402708; x=1786007508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rNT8uuAYIOIz9by9aY3qoAX6TR1FHkQuOah2tZDQCkE=;
        b=RfZzEIeQBT65N84UE/w0M4NeymShgP+ypv938Sg3tUpIkw29zXaLhd8vsTOFFIdWMu
         6UC9jXFh0zvcLrave0O7qdJ4G1lMPpgDS87ZVwfcvL8ZGbUDIBAFbQYtoS75znrhg0fk
         N/s2q1nlBCFGpCJGdQtw67pXfBI+tKHkXcY5968nGCyfYLOfc9E4K3SOPZhhWcRWtA1Y
         hjWxBb+KtV+FaOy9GBa7qtsVNADilgzLiVSqaLQWOveCI2sBq7kA5YmhFTNx+bTZwcV2
         qDL80E47sGfufU2Cp76XVOhyUHkyHXMSj3vWme/o3DLLniZuhPtMaNh9HPVeT90jjiCs
         QgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785402708; x=1786007508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNT8uuAYIOIz9by9aY3qoAX6TR1FHkQuOah2tZDQCkE=;
        b=ScdHNr3W75/sRMSlo7t1RAi45RkEoSj0s1AycvtqOzTck2ewqZiiOjMeg4cLWYYpEG
         a5UcDdoHBvXNJ6yZ3O85W7IrwN1jhvvEmWFLV0YAUJdL6K2b2JQkPjzN3BiCkLwMUouP
         Ws0DE3/K4Bvkhv2Y8M7LGbIpwpsRVsW+eQZO8QbXbg0JNmGeZCnYzsZT1pK4MUYXxyan
         dlVhUB4AVUR1BMjvnpdkWhpETJizu7PL+lFiP36YNdp35rJGDjOTpA51R4tKh8Qpozws
         OPFYMKvtlMiB+tAehmqV4sOqSozjMv3zWBv5BQinaymNX1QtL5L5jxxMdmfc0WovJwgd
         u+lA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0o6ZPksv1XjDXOsdbN+1Z+yhtnH9kBLnJg7MJvetkoIUTir/1qdm0boLz2igcZt5lWvoO7OUjVIz+SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTpJDNH+lFHm8qqzFKos2Jh69wRxeCQH19y1QwEWIJkDoMT6i
	TbX2UX2TdiWcPTv68TuEX53mkIaFLW/7X2Y6CBNF5Ax+ZAGkDIfEZvplWRvEEo8gCfziZupXws7
	Fptzw9SHC3xaF03PveUb5LkaZF4yfIpS0jnK8
X-Gm-Gg: AR+sD119m7eQvDkKrpaLOcq9ApsFr1LG3eYRixExG+PqIjTltjnajjQ9BG8QYslr9Jc
	REPbJPDhvYG4dZMmEoCi1LlyPmA12/2NGBEGK66S4UfKDttIykIcO86/kRO790W1PmLzeQ5EbFd
	cZ7hrF1aPQ/mJOCU9yNqPYIuoiEu7n7v1x8BGyppvMqZdMCEj0kKbOghjtGCZaAjx5MAhCBC3id
	3y+baFtsbNBkKE5fjWToAzT2ovK3hHj63eD5wAtzev7MQooEdgWclSWwYwb04wZkUWx6Qdn9EMz
	4nCIp+KmloNJOTo014VQUEyBhs9Mr+DgiEMmFPKaSKUWTcx2duSkzXRwO11d3OFGEZzDzruQDYz
	I7EkSK6zRkj3q60pe4W0vc7Uw/FYcKlM6AazCGAE9R4sfVQM2kwKvvgb/43r118gr8FCQu/E6x5
	1Nr3NWhJqeEImSt8KdIq2Ld93peAgUrFxSoUsSpVEraqKJl3WOV1l5mSUljhhIzes=
X-Received: by 2002:a17:907:3ea0:b0:c12:631c:67c6 with SMTP id
 a640c23a62f3a-c1fa554de59mr85960866b.1.1785402707552; Thu, 30 Jul 2026
 02:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-upd161704-typo-v3-v1-1-69c962e35d59.ref@yahoo.pl> <20260729-upd161704-typo-v3-v1-1-69c962e35d59@yahoo.pl>
In-Reply-To: <20260729-upd161704-typo-v3-v1-1-69c962e35d59@yahoo.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 30 Jul 2026 12:11:11 +0300
X-Gm-Features: AUfX_mzEOHyV3oJOY8-a69g92QJquL9A0mM8T77huwsnnp9py7IaA1ToOIFpAFg
Message-ID: <CAHp75VeHW7bB+0fSqO3fX=Wkb-216cdLfmd2W8dYD7Q2_hx1eA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix typo in fb_upd161704.c comment
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:49=E2=80=AFPM Tomasz Unger <tomasz.unger@yahoo.pl=
> wrote:
>
> Fix 'cencter' typo to 'center' in a register setting comment.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
