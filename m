Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664467;
	b=bkx5gnni2EzT+z5qAdThQnM83y8JSXRHgpeN6JKh2zlOi/urRnfUkG2pC9I1F3nWJe55
	 ib/9KEsycv3lgy4YfxzZc1dsDOrUF9ckGjGdmsFc5CoYIU/Rdb1GVekRNfQ2fxayJJcXw
	 7hrdDgeqvOV7qlso+Jd3RppBahnQJ5QSEOpzToFz9YClKMAXkMfOGqZVMw8G8VOj0+aLQ
	 PfHzsmMj94wvSIgdfzeXD7D7O6G9Zz2HY5SUCvZbQdeY/jTjHex+SuP8IJVnznMKoWJSt
	 wEyE2FJM2IrrisMTj+gKT5sudfQlM95Jk0cb3ZROBA+menEQSdayCZa8aCb1kxqoVsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=TvykTUk4R7T/uqrKjXDjIuLrA+PfKRZ6+JNOrXkof4M=;
	b=pDcxYgcAQQljbup/p8/C+Fdb09S1lZ9JvEFUQSc9Eoq0Ex/ClUUfyOxenmoGxndsrHk3
	 XgRsTe5mPzH6vDQikXBD5BHx64YaKv/gZOAtDeRUKuQGsjGZA9YA71HgYzj182Iv2E+E0
	 HF/ULDiPsKEqL0q252DABSwmcIcEi9E4yjFtkTtk+ZHVfEyAr9REUtb8McDdHMBZuhuQw
	 uX/9wLff2rg8Yup6iFNRVIXnGJelwZlw0FU1LGVBk/WBfKNmR2xEocH/X7iLtNfVk5Z+Z
	 uYBiKnAh0LbLeXZyd0+ZYIskXS1yx8zh90E8IbM8uQmFtoCZZiDLJkPHoKfzvvV2lSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxHFrEFl;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FF606A324
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Nov 2026 00:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 797FF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxHFrEFl
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-18cdcfc05ffso4295409c88.1
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 16:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664467; x=1794269267; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TvykTUk4R7T/uqrKjXDjIuLrA+PfKRZ6+JNOrXkof4M=;
        b=VxHFrEFlEfJUyOT2QkXnqh3iBZKJ2SPDhFPadClLKn9a6UJhK5ZieO69lEY56iCdlN
         VFM30bA6H+i1ZYpssXbYPut8JwB2YhrFcBxezN4tXBJgUoJTLyKO5XsICgeQ2CGgQNlq
         Q0VkUSWsWY6HNx+KAkbiOqGhksA4EK5ZjJxQhYm8H9QAESH3SCqCG0vLj+gE+a8Y/jT2
         5rGx9q/Ii00jbRGt2CeQeuMN0r4WGZZpAiQj7CnVFswtXWgD148CJYMrNMgiVIRKoMl5
         fhsgwNsBuvUqPxxlpibUNnhMzvsuoefwX5z0YusL4qnY3Z8iC/Isxs4Gi1scxE+bQ1i4
         k+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664467; x=1794269267;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TvykTUk4R7T/uqrKjXDjIuLrA+PfKRZ6+JNOrXkof4M=;
        b=Nmjp/B5gI5+bG3oDgv5ejKOS2nhVkM9rxfKvw+jLO/LRGcm94nayQZrvByry/x1gI9
         10v5rdAw28wGsFhBHereBGYTki0zsWAgYXRhmGDN2Zz7a8meryriIJMMIiYFB1i2xrml
         duka2MVFMj/ANTYteQA1g+vy6FdAN3mC2DuqYgnkkerAnbS/+cxEQ3fKFZT+qck/CiYS
         8OhoZbp/9/xOYx6RHLbjwlEqbEib1bnXnXWWXScjM/YvDPm6FSxsd/8zI4sYwfMvrylb
         Q0fKoSIiHOjQ34uku+jVFTxlhObLVAiXa6jmwROWYE+b9hYiFreiWy+bonPUvY156WOB
         HWaw==
X-Forwarded-Encrypted: i=1; AKwUvBxt6yXY4xy4EbUnZtfMxwF/6CQJsU6ZftXgLZYr5N21x6LYnK54HNK3ldYR5tAjJ08RWS6ePE77yfSCBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/c1p5VOiUCPWs9q2CQOgwbPCYb5RErP74NFfU1rf2SEpgDI+T
	h3TFQQLFd1lpnqTiI1Ln2UbT/gWWC/TpjFjo2RNRcgjX0wRgaBf0Abh7
X-Gm-Gg: AYBFou2y+wr366nwuNBd+toe0IZm7ObxQ365RlEYgkCiwZgmE0srfqeSF/DJJP4Aq1L
	u2vrZMiJ2xWrmbv2OpiqsV2jrMkXCYJWCMttfp3gRbeoIM7AZw2sAIdYIapG804POjNm5dpqE+X
	iXCtG2XOgSKfACkoFDHa3iKRPPHPK/8Ke+8WfV6BDLJkIUA+pcLtO/DMZW5zp+fXbYYkdprSZLQ
	T6ev8O7zQ+Gj/nnlzURQncIYELUlWNBSspttSk8a26LNz5o8DtzeVh6JL35oxJLNN3x+ZWJSpxg
	RPhzLip1VvyPXJAtYAvwuUyL2x14MLRwwH+VSXjgFGo8yFIc3gaBAgcU9e/IHXYG49Xj17LDm8d
	MZK0OBbNqff3EInjCsjO3YBFLsDztiJlrj1V+aKAeWxCEMD+1qJRfd9UtyNa8CD6i5CoQMblX/t
	/FJeecxjj4KBzy9Ccvr6Xf4Iq1umcn2i65/IqtdNsnVOYPGz/ky3zqJJY7ls35ELn7odwrX++jN
	w8Zugudygi6WZi3RzSdQhZBvaEJn62BqQ+2OKyL55dMrGWL3nMbaxTVjKE43yBHO2voVHrO9P+l
	m7jQCwcmoH+ijfz5El4L/+3AE/chqbKh5Hs=
X-Received: by 2002:a05:7022:92b:b0:19a:8e3e:530e with SMTP id a92af1059eb24-1ac5bda7dd8mr22231405c88.8.1793664466566;
        Mon, 02 Nov 2026 16:07:46 -0800 (PST)
Received: from smtpclient.apple ([5.34.220.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm63335030c88.10.2026.11.02.16.07.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 16:07:46 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] staging: fbtft: fix space prohibited before that close
 parenthesis
From: Eric Lee <eric.lee0305@gmail.com>
In-Reply-To: <CAHp75VcvKkOmFTtJDHuKCNVUMXgjZLiNqmGcHFKT__dtTt_QJg@mail.gmail.com>
Date: Tue, 3 Nov 2026 08:07:31 +0800
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7B3C1FA-32F4-4771-BC2D-F97D07CBFFE5@gmail.com>
References: <20261031042315.1122699-1-eric.lee0305@gmail.com>
 <CAHp75VcvKkOmFTtJDHuKCNVUMXgjZLiNqmGcHFKT__dtTt_QJg@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

On Nov 3, 2026, at 04:44, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
>=20
> It's not a fix, it does not fix anything.
> Also study the mailing list archive (lore.kernel.org) to see what
> happened to the similar patches in the past.

Thanks for your feedback. I did check the mailing list archive for the =
same
Checkpatch error in staging/fbtft.

They either removed the extra space between =E2=80=98,=E2=80=99 and =
=E2=80=98)=E2=80=99 that caused another
checkpatch error =E2=80=9Cspace required after that =E2=80=98,=E2=80=99=E2=
=80=9D,
or removed both =E2=80=98,=E2=80=99 and extra space before =E2=80=98)=E2=80=
=99 that caused build error.

The key difference in my change here is to make that argument =
=E2=80=9Cmodifier=E2=80=9D as
variable argument, not a positional argument anymore. After that, I =
could
safely remove both =E2=80=98,=E2=80=99 and extra space before  =E2=80=98)=E2=
=80=99, without further checkpatch
error.

It passed my build and verificaton based on the file "fbtft-bus.i=E2=80=9D=
.

It is fine for me if you think that it is not worth removing that =
checkpatch error.

--
Best Regard,
Eric LI=
