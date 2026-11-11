Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794412976;
	b=ZJyCxtwhlM7D5w+vIA1qlC9LJu+XJTDA4nQ/bQL7pJRtJC7sQkbV1OAmIBBuSmSuxXSx
	 g2MyL2MdexZ6yxPpwBclwWvjA1dqPZFb1KjUXiKWw1DI+YaAhkGzuteb6cLBH4Rs7fad1
	 bSrEUYxB6bF64jWg8Ky+gdSZNTEiUkgvSqP252o70PprOG5i13/cKtkkbK0NPfmyD0/1T
	 LiaIwoBWtSwEWryfdkEb4Z5PailYGQ4x8K83WeNlDbjlNezNuGP6vDd33b+akb6POwtNG
	 XewjxX0sIz8Jx+DjoeYupS6Bz32f6ooNAQSi+H+Y5IXnvq3UfpvWzljQybnyF1q3vkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1MTb6+K+DiWbXH5syUxf48Q0aYKAf9KtSh4KBDlK36M=;
	b=3OMb9LSOYxIu+LJFLGj5ihz7XipGCCvg7dTkZI5a50NksIUmG4afNEwzdzzpVUELAHfj
	 4uYZ1TTsrwRTEllTS6I2FWep/HlfyLn6r2uPZsgTiuGwAODxbfUd08WFlYTh+TO8Cwk6b
	 atmD1Zi+kkjmviFyem8t8INBmMfFptVHFUbFefq6RpvxBWPgPzWegEptelUilgNcZEf/X
	 7ikzZ14gKU3hh6bxoCxevCkFT2rzcXyJjjGr1ufuTCAQg7YlzliTUO9WD1zrzIQmA44Pj
	 8N8vi+b43CceU/7U8yJ/TQwiZlGiTpWiiW7sUDYBGVBBy0MWwDquSYN4Q+PuHUGCh2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKJ9UTQl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB13606A331
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 16:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB13606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKJ9UTQl
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67bf3c6654fso3851105d50.1
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 08:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412975; cv=none;
        d=google.com; s=arc-20260327;
        b=B5Wp3Kdi7R7ulTXp8vbaI3S4UVFkSTf/1nNU6L9I4567mMDplOphE61I1HDp8Duw5I
         di1tGl4N4c0x1BOafohsAh4l7Ra4E62m8qZ1SAFiIVga5uZEFgp1HTKV2SQnVREOdkzc
         X6RmOzwpMppqMEcb51DS8Kwc/PGYlWyy7k/1sIXXoV6MyKaO46dXkIF53Wyc670LX+BE
         uhhBW7KsisnsGVhKix/h1aw+s0ZzLnjJTM99g84XbInneeehq9zi36CjbDeJnDj0u/9Z
         YY4YVIC5jHfTWXkGfO3WplSM3LRHmNN+atclyG23sosyStTBd0YFaFHW4ObqNoj1ficE
         Ef6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MTb6+K+DiWbXH5syUxf48Q0aYKAf9KtSh4KBDlK36M=;
        fh=eAIwHuxSYHo0iCoo8LSggRBxBV07mZQz9mZFz9XhcuQ=;
        b=c9ooLPaH8fh3Wvq6BIEFSR0Jz9IPdWzcOPqaPAanhicFWkCzJgxuA/0basnfnlv2Tv
         UBXb4MKTtXk3+PlzhQfq+Ddyk475+bYpuxErTl0dHki6JlwZGbUToiNi6al99edCG6V7
         +/49JtszLendVyRWm4Nkbw8moFYqUViagXRoczYJ8BMMdB48NL/VYJPgJ3xYMyONVr8U
         3P/RA73NNd9jhvHQzWyeUl0sddpfPKO7054QHMyQ8Yp5hDVBk3BC5yvHj/t/GUtxOy6C
         GR0WqyaasagK6DQa8hfG8Jr+0VG2uUL7Lag7PE7Zd/QjAPtuWhs6HYfkmsbNZCvUg1/r
         4Dow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412975; x=1795017775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MTb6+K+DiWbXH5syUxf48Q0aYKAf9KtSh4KBDlK36M=;
        b=FKJ9UTQlkrpHd8aeGx0d+LfMWpdS3QS9TXfFNCiStn36JKFVzAHmMK4DgPyjQLCbxe
         4Yy85tuKfsUxjhpsot4j2CyPm3bwTG7QcrgIW9oNa+8BJQfCzFg5VnxmLS7y6oJvgBfn
         VaQKBuTMK21izUqJTD5060QhtlStG7L2P83NhZ6t3CLaktB0l0oYDHStXijKSIMgJ940
         5DTHy5VKDa181kLWtuC7tm//wjmNVhoLdo8diOMuOIxd4PSR83PPwqHIsOHuNfJ/VD9K
         IQDRdXrELU4dQZOw81p+yE3KAeHqlrCgocrjVYrPYM/pxE9xgbYVSFnE9YchtIdy4j17
         lnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412975; x=1795017775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MTb6+K+DiWbXH5syUxf48Q0aYKAf9KtSh4KBDlK36M=;
        b=nv9R2iJtyEberF5KU00hDPxDtZruBQw2eku6Ouv8DVx60gbDWVBWbo5tEIN+KTXOxS
         bQdAZhCCuEhfFDYQHWMeT90c4mElCYgtgPuxYRdHcwqFdHbHjsNFR4UuCy8VwjlwfQDy
         j2pK/mzlA9TqwfIBzcmd6kBRNrLBxZJ4ZwkCSssJda+FVppOr/spW7NVhYaRO9ebQI1/
         c2+4f/gtrVtzaVrgVNdV/FMRTJCJShI8vq9bEVlalX8jNJYAxYJvv4qv/ucU6DL67GJl
         PvuOanAlnB6/zU+FsOrPl7jXJZ0NZYRk/8aGyO7l564sllKdnhZ0fkE4moE+x7s8Lqjm
         lUiA==
X-Forwarded-Encrypted: i=1; AL+hErHGVACCI6mbvxpLKT4CmEEwePKgSUMm9PW6oKVD/q+9g84jA/Qg1QB2qhMjUeIVzwzfC/ZqdHlkGaxdmw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8eNSBPB7TUShFfBXuOVdyHDuM43VsvpH6ZWQ6Y3r33/IN2r45K
	cdSUAwm7yNatHxcAK7QY/0c8Psy2fVm0nzNJLCgiRfDZez7d5esYkTbF4CiMfN9bZiLdWBuci1t
	l/XrXo/ZHW0XICPQBwYj4wzfChP3UDkQTp2khBBE=
X-Gm-Gg: AYBFou1mWPgzXQiAO7IFNKDuqViM6tRw6hzbS8CgDRWqWDCHGpns8skK9sWzhzDU9xV
	gXu1zIxnxoZVBPfoLIHRucP1krOax3O1WHElFtv+iSAiltxcPk3A0CTkvZGvGMoS4V5XvP3UnZR
	0kxwGgwhboTQuLr6mxo0WV85RX6gbXeXyDKi69bhY9CAimnAq7CAHECNsjy+QjeqRmdG8vveOiZ
	B7QYGrXCyWzXx/lXx3MkTelPojaD6x/8eAQcrAG0TvfH3tN/rs5Vi6bRtYLORky15oO00MlIg/r
	TiSE9cyQX2Uf6DgSwzt+T3ZQOi3u9pZskl0/GoQdnCcy4jT+mCy/D2e6bf5kY64X+hjfY3mnvHR
	16bZrdirahNTIcH8Tdib/WVOSg3odsTAwMZuv7DffM343tsL38D06bOmIaJmMZAUAflRnVg==
X-Received: by 2002:a05:690e:169b:b0:67c:33d9:7927 with SMTP id
 956f58d0204a3-67c67cb7cd5mr1503453d50.12.1794412974424; Wed, 11 Nov 2026
 08:02:54 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
 <20261107-lm3630a-led-max-microamp-v1-1-ec9e441d9b2c@gmail.com> <20261111-cute-impetuous-otter-0d70c2@quoll>
In-Reply-To: <20261111-cute-impetuous-otter-0d70c2@quoll>
From: Michiel van Beers <michielvanbeers@gmail.com>
Date: Wed, 11 Nov 2026 17:02:42 +0100
X-Gm-Features: AclHuK-qKY6zTrJn_1i0uQfpLRmaZpJ8hHHbOyKs16JHL3o_cT2giJuDjxuxfRc
Message-ID: <CALcvxfH8N554Pn3uN+cms5zuq+LPGj4rnV39-5G3G9yzhXTfgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: backlight: lm3630a: Add led-max-microamp
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On Sat, Nov 07, 2026 at 01:13:54PM +0100, Michiel van Beers wrote:
> > [...]
> > @@ -77,6 +77,14 @@ patternProperties:
> >          minimum: 0
> >          maximum: 255
> >
>
> I do not see in this node reference to LEDs common.yaml. You need it for
> any common properties.

Thanks, I'll add the reference to leds/common.yaml in v2.

Warm regards,
Michiel
