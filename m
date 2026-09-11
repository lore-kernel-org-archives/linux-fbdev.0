Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FD49E155
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085869; cv=pass; b=jzT4omVmt+PW3Z5kpYe3zcVxwhrd1rbeYiYTCB4GAkfqkAH0aXfuryJQubjTPN6ssH7tJP0dJ/X26W7HCp8/Uj4AUwnyxVQEFoW1DmMleAd4ZPKx/D53A+zzAXd1nyhZGl4YOdlF/wBW6eq6tK/Girmi5bclxHT6lHKko7ZeXtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085869; c=relaxed/simple;
	bh=n9SrHN+fgpLIqi8Itt/3HtMz4SuMQlkWH/sPrxujiQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvZ27Gzg8xUK6BC5QYtP2m3JynQp7iB3MyUfum/HJ3YzbxULPikbjkB3lirHYjKd+Rl/YqbFJvK3jzlGXRTgYfM6O5F2FXoHjGfsVdktjCVafYWmSo7n9hZ5FYA449fbzJqHgCRS5CTMP364RAhKjsYgnqPnYj93J1Cx/4QBK8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw7fOt+h; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw7fOt+h"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19125so291454d50.2
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Sep 2026 17:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789085867; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBoV15Tx4o2YFIQF54ydorRolmOlT77crtC4h5yFpmmus8en4nf7l/vuoSBtLQZNVN
         2bpDPhhBw8bb3xep46ljnN2j8wyhpar76hd/O3srOg4JjA0tdSJ2CfumqBWaWu+oEIoK
         Yz0x9nMVxxNe9G3CkxQzFe5irtsRCZaDsr/v9TN4fTIXBfXw7dcTxJET+lM5BbFzkoBF
         r1FEYF+qI4z4BKu1aSJGtWnVeU1WHxLF9eyus93Sb7Vj223DstP5qQpF2PAK9oylST8u
         vR2nqiH0JLk/bCNn74Ff1JHJpipzfbAY6vVbTmjX0H6URylJsgFmW3EYcXBVnKGgwAJ5
         D8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n9SrHN+fgpLIqi8Itt/3HtMz4SuMQlkWH/sPrxujiQE=;
        fh=9wYgffX7dYUn5U6MgCNIg0HS3ae9FyQE+rBlJ3bTBgY=;
        b=EG3wx6+FQSw+d8oGF54GuXFJ8945rEq4e1iyIdcYJxneVaT7NhRM3G662PmQKVRacR
         6TU8tFp42PP1EpvTdtirqPN147r1haispATfTMeENfIeSBBw8UDyXNBMUskiC18cBxiK
         5SyCGOGh6biUniCj3o8LULW24LFGE5OdcS0s0bd3hSYGTNLCoShslDLAY6lr6TE1D952
         Z6bob4nONYXxGHA/pbkm2dGdnSn2G07PF1KqIALUjT0jJPkAjqe/KSpFUlAmi1wZ2AzF
         J6zuCc8Ehja8EvGmV18pG+yQUoxR5N/ehy7y9M22uclyFvwOXtfhZZ/t8JpRMZKjOgja
         NakQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789085867; x=1789690667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n9SrHN+fgpLIqi8Itt/3HtMz4SuMQlkWH/sPrxujiQE=;
        b=dw7fOt+hq7HIFai0TMaJanw+O/NBLPkg4rJxQqxAARm5dFv8/OoJae2EHzw7ga+coz
         aiPssEzcMISTt81V4EhhvfPuqRWzzuDUHkS8IpmXQ0qpA2SpMCz8YUB9kOL/7FopDlqu
         MTdf9ralrZg5mTKSEYLLZ91J/bdNFX9T6UPQViMr6wfjHCKtcbEShzetJz1/lZFNU3Qh
         l7YxyjrotxiTNdmuZeGnU4NcTwNJSrwL5pij3H22RyoCccoEmApsI2KPjC/QhT2ayUaN
         WAlKNSjaF4sWJ6TxfFxROaJbuP81wDajofDlXiZ5rGzSy6He8gnIOBHO1jqpHHzA6Jex
         UQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085867; x=1789690667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9SrHN+fgpLIqi8Itt/3HtMz4SuMQlkWH/sPrxujiQE=;
        b=OdO7wHeGjFQijS572MxidjoRdcLnI9x+x3UI+UlHMVNSQ0Dn0beh874CU0hXXB5xxl
         SBDD1H5H4+jh7CkMstw67eQidnBXQ0Ief0VfvZtzCyfOk2h9FRi4UxdpYl8RK4POrrYB
         4LUIki/xVTch8VZutBIy9Gs/cT79DWhynSZ0Mr8myPqepRK6hlXCPzf75orld6er0iDY
         M3OjJgObKibr9VWGGkmvkQovVy0sC5CP2gLq7brS8QTzS+in/BzdF0a82eIQ+A7Zv/HN
         vMuztCyeUsjbowiGFAZOcU3+SihuF8JIQsDkEDdBgIx/+BEYVp0GbWG4W2sS68QX/Ku0
         9Pqw==
X-Forwarded-Encrypted: i=1; AKwUvBx7ipZ+yYYdr5vZqwK/d0yT9sMtQjDpU2dhaMu0qdEcJghqmnZOzPfI+tQyXMRH1SNN9QRwlPkkdBEiqA==@vger.kernel.org
X-Gm-Message-State: AFuF++mMKuc6t9/2lSAF4jsMKKQDaYcwH+TuJaM2JdsweyP8+9cocpAi
	Lu7+9vUNrDdPYZqPbudBlftLmv2ydEQvBwIzgD7TwUyKg2yzjO9BP1hb3+yOV9fn32q7TucBYQe
	O+NqM67RJbKh7pfLtAtehAP7hQEsdiRdRew==
X-Gm-Gg: AYBFou2Lj5IQnY2OuQi1+jCsvs/nWucIij0V/l5vCCSTU38wp+isBJgkm7L46ixvj3d
	9nUDLLtZU4oyik0IqIGdphsngmJs+yylNBFveyD0zs/IB1O1rWBKjrwvELZd46zqmhSnC57VqLv
	oSc7SMDhkga4//3Lc+PUuD+S5F4XCQey0SeNwNnYxaKxehRNuTKNbkxYf/25mBTJkoo0M4QiTuU
	1mYsF0HMDnsEQ/9HsgCAFMEdYEQ81uybf9AxNVfdze4/jqjfacEOqvo3ufV0kBQNrBXDrPDPe4F
	yOG5x7qg8t3cXHDvVVdGQtj6jpee10xxrLi3PQN7G2wPd1hpnWmIX46Pc4ElXGJFaLf8TZxEdc0
	3nDjMaFxEVa6UYKbzzGm2sG+pnxFgD+b2uRspHK/Nh74p8Nb8cP9b2OwGtHCdJix6vh8mSOxfYu
	c6C7tQRu+IyNSQYUz8h5rWK7x6ytFZBZFY0HOEYR7pJETgwEO0lQj5EQ==
X-Received: by 2002:a05:690e:4501:20b0:671:1feb:199f with SMTP id
 956f58d0204a3-6712473278dmr616377d50.45.1789085866400; Thu, 10 Sep 2026
 17:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn> <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com> <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
In-Reply-To: <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Fri, 11 Sep 2026 10:17:29 +1000
X-Gm-Features: AcwNN1Vors9QLM8_x5o0_B2FetldnvezlCJ6C1fncIRSIhuR9h5MtKq7gbNFw8c
Message-ID: <CAN5rfbQaXnYJszenqQvP3i9TSE500UJTgTQZUtQVxmRsqwQN9A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Helge Deller <deller@gmx.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Linmao Li <lilinmao@kylinos.cn>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sept 2026 at 06:39, Helge Deller <deller@gmx.de> wrote:
> But I added a
> Tested-by: Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmail.com>
> tag, if that's Ok for you, Miro?
No problem.

--=20
http://mikro.atari.org
