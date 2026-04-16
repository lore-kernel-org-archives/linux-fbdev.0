Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE130C62D
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363669; cv=pass; b=aaZBCDaTris+I7zNfXbeptuOinNtbqhbb53OBtGSk3OShEBNr2xI8aqrg6Tpvx/0JRCWnjd1HPJSmaLBDr/w0YSHseqC7ylgDUVEJiF9v5ePS7oGggwjqPjbOufKaat9aPL8+ngm6mmSg8BrUYg3i+3nA2Sh+TTBL/DBp6fYV7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363669; c=relaxed/simple;
	bh=zljY96aOpcZXaU0TqwGD9ncObvim4QhmFBnzHQtRmuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuSVzlB3RknE4Zf9+JAHT75iTTpAh86iTNFUppcbYlYkpu3jsQjbyEPHOupBvn+La7PLY7uxL3u/QK4pAaVvb0gWKhtEMBbukXOrP0VIeRtBGSYziXci3lmFwmene2u0UCS9Cys/BHwGTooEB1XnXV9AwliJDo/x8fcGdrx2hTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv13w2pi; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv13w2pi"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9910707d82so1068795866b.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 11:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776363667; cv=none;
        d=google.com; s=arc-20240605;
        b=Ksm/XMC+yRVOpSNiSUHTmWIpCO1r1y5wJ9pkhQr2wZf/eZaT7gQZgEQAgYl0jqYMIf
         ucYoxB3pttF4VcBam8XMl4a3m2KT/lnYu6bcDy66x3OXsu1FwNkHVB24TkltbeH+Sy0p
         382BXmptvVFq52eTM5ljQSyItexklWaRAdvkycbYoao7KA4w2T7Ol5NqY/ldjzzypR/E
         6Su+jAMSQtKO4xP3bdmkrJBfE/3nwBSUe91WjRz1RqaldQmlN/Xb5sZT7M6jAaW8G9ah
         eXqE9opDwza+LwuFeV+Hcr/hyP2YpglnLle9SAkX2lOCmkZuEd3OgH/Ga7mivbIHUoWG
         YPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=axbeRxqT1s0AditMUtuRbScbflsIyHPPu8lfF8iZ5eA=;
        fh=AuUsU4bYIcN+MHTpipTHYPooYLXAIl8JAboEVA04CcI=;
        b=fVCxGBwFFX16CjWcokyjuu44zcRWH2oohBVyMI+1gGwxd1ai4eLPWMhjx6BxO78v+f
         RcwcQjJi1RKO+EIOm0OCcCBlNR4IOP9UySVNS83UAQWFVOu95tHt68/4r3ZBP2owQHOS
         /mpF91V5d0JOWG69PMdT2gzOUrSM/hPHYJhw+JVyL/4f8Vr1Zqdd8BQ3lNL5Xiy2a4vP
         5IudmM0KvRaDAa924XXWUFW/ZLSuuwLAf42dOb9F3sA5sSIcbTdGx6V+mTDpXClpP1UX
         lwG28MXPAghPq+7gL/YLE23JsFBHrNJOIWkbNLEQTaeUqUe1JfI3ij+UF//ZHROcerLK
         KUrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776363667; x=1776968467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axbeRxqT1s0AditMUtuRbScbflsIyHPPu8lfF8iZ5eA=;
        b=Hv13w2pi5xYN8IpmS2fI6nvMWcGjAMUIqYbimQRfFib5AgqSSPfMcslHzZS3BZvp+g
         35aiKZW97CG9O9BXuXd0V/xybiwxJKyuecTgLnpeumNzLNNRIQBPi6ArReQPi7VWIAxc
         8M+S+ddt6LpfmD8/U1unNViycdbP5HkwgdGJlqG9YX+8WXxH0FSLInPXTdXauKAO9jAd
         iRwmhAM9wAnyMw0MsBk2mhphi8RZW4GkCq+KDYhE/Bs0I8UBeqfRoI+jmhgelDF+rN4N
         w9+rbai2dOX8aOGjeleIAcQy10R1FMLJe2QTsinWI4zqte39Om6ASdTtILz9lTVskDSC
         epRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776363667; x=1776968467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axbeRxqT1s0AditMUtuRbScbflsIyHPPu8lfF8iZ5eA=;
        b=reDwi+xqj9cB2ZQ2aYheLFlseFcVtpSFuFc6C6ylZHWkkjQbYFBh3j5cBBa3zHbTf4
         OzCyc53EclWw0yKHWwL7ZaZDMvUTrcumcMw+zhfjLDKlMXbnBcltZ3gb/UTiEhO+Kdw+
         o6LLK3+pslKcdya2Ps6GOoGnnM9z0FrkOVD2FtfDRSFC4Y6NaSoO8K7lA36fmsPYoU/A
         OBtxK2U5hbBfFWM4EtuCvhdzBWQkiO7cVCizMAl1i4mEBNfMg/ozVbPmCFzarszjLTdp
         1+E9uWDDZ+2lZzS+mGcgp9BVAIxeMwVLBxCNaF9iCLcGGXYi90PtZdXEDuYgbYx9j9dG
         XyMw==
X-Forwarded-Encrypted: i=1; AFNElJ/ymt9KByUo3oeYEacX3GGfa1vFY//WsL11K9YMjfZc9e+TRqU2yWTjHQx+UYBoRBIV94qahY6d6SogSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytFOM72E5N3N3pk2reUhv0kSzDSWjhbSRX7R6rusMz80RxVY45
	4x3eauDP3aPJFkCbCEXzsxBa8Ptaa0I7thmYd7kQ8N8c+A42Pzeco6eyUqh0s8iB0CNUrKRtYru
	lcan3ZwCInhLWINeu99ay3lFXbYHtWGQ=
X-Gm-Gg: AeBDietggi+vzKpF/CGrVOqkpvKhKSws7ngAPxhghTv/sB6szKj9qYE9rqZoz5WMoQ2
	5iMgMHPaepGAHMmJRwcWJQLoh8RLtHSdJbPNFqxoY9EKddlZ9xUs+VKdMbf/z+3nVuDxcdrPd58
	wClQFwUItos/d0z8aM0Evuh2dQ+ubag131VDfXH/7XK6LmfQY2HLSJ12JMeKD8+LmOw0jfx5rPY
	Lhnugie1Mjl0u9NilhBfgy6Q4j3bINF6RgCbfjk8fFXB+BtaDQBjc+pzTcl+FZxg8IK/AQ54qHw
	ZF4f38ocSW2+TVkQarG88m17lD0LCmKobBJIHa/qnVnl13fQQnyVd5Xd9PQ5Zp/Ob6QTB38OKGA
	I5ttECztIPZb8LJpS+A==
X-Received: by 2002:a17:906:5191:10b0:b9d:ffb1:17aa with SMTP id
 a640c23a62f3a-ba3dbbb5f29mr24027266b.24.1776363666733; Thu, 16 Apr 2026
 11:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416164643.153765-1-sachinkumar905846@gmail.com>
In-Reply-To: <20260416164643.153765-1-sachinkumar905846@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 16 Apr 2026 21:20:30 +0300
X-Gm-Features: AQROBzCvDnFVFO9FhekHLkJwL2CmVDwz0QoG_VeE5ZobTgU6bLSZcij0D7r5CgA
Message-ID: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: clarify TODO comment in fbtft-core
To: Sachin Kumar <sachinkumar905846@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:47=E2=80=AFPM Sachin Kumar
<sachinkumar905846@gmail.com> wrote:
>
> Improve wording of a TODO comment to better describe the
> intended optimization. The comment now clearly states that
> only the changed display area should be updated instead of
> refreshing the entire screen.

...

> -       /* TODO: only mark changed area update all for now */
> +       /* TODO: Optimize to update only the changed area instead of
> +        * refreshing the entire display
> +        */

Wrong style.


--=20
With Best Regards,
Andy Shevchenko
