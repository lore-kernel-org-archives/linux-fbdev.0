Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638445275AC
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067934; cv=pass; b=WEcyV41M8BOVYT2GW+NrSc5lKKYro78oVQ1dSnJLbzttQ4laAyqysQjrIN/xie2RfJa2lcKxjBVJLhPxOu//344+sbHZzmoLexOcx6Fyvis799fFZxw+hxIn2ycLhSHp14wHSMp6jjuPg9S3BwRR2BBtRtu9rnSTugonHg/mM7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067934; c=relaxed/simple;
	bh=6VxrMknAVb1vDWNanfZgZOBYSwjkUtQT3TOXrqHvrks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ8lUNVvakuhyQkrjs46uIImb3eEnmE/e2KW319ot+t1CNEgVYBN6SPfvIiBlfrgcySDDyz8qYd6h2CkvoleiW5oqJawL6M+kBvbmiv5586oMVBllXx6D/yPmyMoK1zu/0AqKntEzEYVt5CwPoop6eBGr21nWrattEv4oGjiZu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+J0/W8O; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+J0/W8O"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f5603a0so519482666b.0
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 02:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790067930; cv=none;
        d=google.com; s=arc-20260327;
        b=k0RTl++4eOUxC9jDa47RTEwjmsZIwPb3UwijMet+YUAj/lvqBZo722KIPPa2ItZIjA
         q7HmJrfWPAgdg18s5FNzxKbmny2rmHP6NtSUW4TTlNGmwZW2+XtE3odISWvpFr1xiCxY
         i0x+nCTiuxwGALA6bNzHcGk0+lnBLrJBUr/uQOPdLNPvtqo+BPRyOuzkcrzjj9kawScb
         9BPk7GmjgpWJOdOH5qvPCMKMsCaVlNS+LYiavY8bsFcShkhJYN6ppoLYrWTKjRjVD8lO
         rKhBGXSuVuph2wNSjf5bnFFUrFcNG/3Zilia9EpXkQsL1emtOwWf3eM29e6H1F4Cs90y
         bFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6VxrMknAVb1vDWNanfZgZOBYSwjkUtQT3TOXrqHvrks=;
        fh=B0rVrQoWSN3lawO7IE6mX3bGehTUO0+UKR/V4ocCKmY=;
        b=GyH6sylityuUL2lUUjFFS6Q4+SieuS/35GH/SqvxgBRjqhBfaEJwPepQj3eIN8Ykv3
         NKm0/yLRH+pzxC5vXNxqWoLs4HP1buQUaLgqPS+/NuxPg44own7JDuYrJWEACIjZuiCa
         FE/SenYksYSUqF5DpTXBwhA8NNY3VHtafAAyZKmGFI/xKyZs6rH5MHDHaJsN3dzxR93M
         ct/7MZtRUg1XzscM1X9dWH80REgiIB/Wkcvy7p4HP0B5AwoKevcdYkgk7EiSZLHMVfst
         H4mdDHVXez+ZvXgp0pPYNoGt4ziVbPg0fQnU086W0gPoss2MestIiywj9keUrkEyWmP9
         s7Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790067930; x=1790672730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6VxrMknAVb1vDWNanfZgZOBYSwjkUtQT3TOXrqHvrks=;
        b=b+J0/W8O+194uMJCZtlLWUWNcTzaoRLF9m7me91BpuFxnE0bcySpQmlrrLOSCBfPNG
         ixldLOZd90yWi0jRTFDD3Iv8KeXrd8syp9MHOIaGb8Wbimq00JWH2djDWKAHnG5uNC7K
         w1yh7EJnOdhjXA7ppmXdBiZFZusH8KUp77mdEYnUVyv94KBNm6sUhW5Z6u8fa3/DVVxu
         Hq1XzHwe/vZG/8Stdst213sCA7yL2MiMtH9xfa7WVbcFgdgtvYhDY2PNunNRUxmNpOHa
         xsk82i7rt5ZSeQ2YZ/ZnpVlPINX3ezqqqN/GPYa2XbIcF5Z1RUXTCcBA4uv6r7n7GJ5T
         jzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067930; x=1790672730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VxrMknAVb1vDWNanfZgZOBYSwjkUtQT3TOXrqHvrks=;
        b=J3i4oN58fvut2RKsgQxIDBpANPGqMi8bOHtv0Jd+iM2eAcb6F79t+OKEk8io/LaueR
         NdT16E0nOfJufYSWBSi9vbC7n9aRHmU4SCZf6lswnEmr+SEz4iGTRfJbwAT6k2mhLjVL
         f615vT2gJOgugLrWPb4eLswaY05T7h5f6x3Euun4+DjUaU5u+MSFSa3VQ+TaQdJdgSkw
         c7m3Uxhv9RbNRJMXY3t5MWtGHIPAdK9Lpi3vtO1cpfFuyq1gPF2oyPgalyrTOL22epk9
         HDuq2gDZ44ZFgV8EZwJAkiHYGYmb/4ubB7tRW2Zcf8+zusfDbAXXG2M9czFCNnStOgRw
         i1GQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1eYwIbRm9R5rryT+ifzdFzczZF0ivX8VN5KLcgoU/Whs0b+JEkEwdLYJOW1HhJ8DIWYtfQbfcTpOx1Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mWUW3xXSAif8pI/LuIE+nMT8lhcmrOKjMv6pISLK62dc1xF0ZY
	zV36D8lV+5Gyb09ULNjKpKvDgwe0apEnOOysyUSNyLoZbR7pJDFh3BWVJeqdZ7+7r8sLGXJLEI3
	LKX7iv2dbIfuTGR0GtuBr2XZOPYoeJuM=
X-Gm-Gg: AYBFou160bmqEjWotztePVxbfX7PyC7Gt46REZAwOPMYYPeHDXccoQnAkK2dxL6W9B2
	I4mWuWW/42MjqpxDde4ThO1tUXjJGoYZayGkbtXkIJEptRSr/9dCHO17kpZZarRxVrlKTkhJn4J
	e158mhLe7Es74fmMR1tEgqBb4UZlky87mCSmolxIHTrBPFJuL9SnTamxCJutvbBhe2awLGwlCxE
	kuJeP2JUr6KKB7IIKLEMn1QNESMsGYgVMOsLls6es66m9MVdyvXidJudHLK1cOaORzrl2lrhTha
	GFYLBe8HUGx+HTY9RmagiipKHyp5JECbZwRFU3dSHj+A8vWq/JLhnRtB6um9E8LiE/IuqQPrAct
	jxORU4yc541f7Rvf7V8p+ETZs+lwWW1qH17egh2Xv4p7uvxXYOqPDcX/coBjnvcpDZAxDI44Doz
	YYsyBtZpbSWAxs43Q34/d1hWEmHJUKmi/2fRvHrMvXZwWZ+VEg1qFH
X-Received: by 2002:a17:906:c10b:b0:c26:19de:9139 with SMTP id
 a640c23a62f3a-c2a15cf8ea1mr1261725566b.44.1790067930361; Tue, 22 Sep 2026
 02:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921183313.92795-1-hikarialiyev@gmail.com>
In-Reply-To: <20260921183313.92795-1-hikarialiyev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Sep 2026 11:04:53 +0200
X-Gm-Features: AcwNN1X5O3CnNVl33I3dVh03PNniNtuSKukKjtL-OpPtcpVg5gCiGP8Rn-l-Dyo
Message-ID: <CAHp75Ve=Wxe=2VjuEyMaeigskU=CmWDLN0baFbxwJ54pKDponw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: fbtft-bus: remove space before close parenthesis
To: UgwuRhema <hikarialiyev@gmail.com>
Cc: gregkh@linuxfoundation.org, Andy Shevchenko <andy@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 8:33=E2=80=AFPM UgwuRhema <hikarialiyev@gmail.com> =
wrote:
>
> Fix checkpatch.pl errors regarding prohibited spaces before closing
> parentheses in fbtft-bus.c while retaining trailing commas required
> by macro definitions.

It makes no sense. It's a false positive of checkpatch.

--=20
With Best Regards,
Andy Shevchenko
