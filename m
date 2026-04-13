Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C9391849
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060567; cv=pass; b=OzUh2f+ZcOECki4lULHt2v11GZXaqjqD/Pj6bYuXUeJ3PkLC0ivijpQfjM3g2Xgs/JJTVV8xgUN0Bzw8WxBuwXFhdyWI6hFL13zjkiZEHNHo0f7Ila1zsfxPfjarLuHp2F9Edx4Mh9bFo2y3hr8nXzpv4dxutPZuXQDeTY9SbP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060567; c=relaxed/simple;
	bh=OiV2w1gDFSOFwIi9IbkYMeKe/6rdSHAAIj+UVdB7T+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzkS249DwoqelO2NJfVuY0/ZAtTMY4FD9Q3ETRFFGMx9zctZhNyiKTlcTJZgshi5FQ7KyhpA/BeL+zHU8twcd5SxEPcjK12kFJWDdkWBZ2UsmIWW6kCzfg8DdwYidr6qJcUooc4XngHFWWr/YA6Tb/gI8UC/bGO5GUx9xfpMVJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbSGboiC; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbSGboiC"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-670c6c6e64dso3797527a12.2
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 23:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776060564; cv=none;
        d=google.com; s=arc-20240605;
        b=F0nv9ddjEX31oU8aWj5yMxVsWyy3555ucDouP+IVX73+Qa5qJ7L3N6jD0plHzf+Jc/
         Ax+BxLMk+hkXdnHXjFEDpqlpXX7R+HLHIbDuot85zoukbKfcBkk8+Swe0gXOCp6RJ15H
         f2HVBd2LC4rbcquOqJoO7gOBd3/mCnYz7LWjkS4fhhgh9C6tyj5b6n0dcw8+EANFjmvu
         om1+gq9QbHkpRc3b8CX74indR5LL9PvzsNjbS7WK114qDijNLxodu29g3jMjMgLSrBWj
         lB9HAnJs+zcBN8+OA1q4s+QgXTAqlkPE7kjSG0+/3223OTWua15pVbRKiW6GztRulfIl
         ozkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OiV2w1gDFSOFwIi9IbkYMeKe/6rdSHAAIj+UVdB7T+Y=;
        fh=ttAi/zdJyFT9dWSJANo9EOxfMf0MfeXNvwSWLsTsQPE=;
        b=kCMcp16bnS+tyD29dh2vo0UOIADH/C6wItmOfHTJol8gh6pHDML2DIYaX30iO3RxP8
         TBlThM+pezU9MhugkMt8pGmqlQ6uIaJC1Uoix5NHk3yv605N0jN0Ces+v/2lUc03dLj2
         WuFBhZAQpd45B1S8UMImzbt2H5KtWzRJMYmeGW+wsntwpDGLMW5K2sP+jMEn+eLK+046
         YILlK+lBLPW8gE+DkQu8oN+D0iK8Rlow1HOUvh0TOaxxNR6YGQIqAS77o5muvqEbmtj6
         WW3nHg1O1HqUAIWViM6J37IDygbm1zYJGpKXlqdHK8Y4CXjWiGhY5q7s5/yTn49GU/RG
         IT4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776060564; x=1776665364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiV2w1gDFSOFwIi9IbkYMeKe/6rdSHAAIj+UVdB7T+Y=;
        b=kbSGboiCb0X38bbnMIunK4WD7B2TfipjmC6UyphmuJHtJCgARAGKyb66UVQEMuVXgF
         4w+y9ivYNlJM4iKxIOawNAyktli8j5nrCACLEOiW0/rYL0ZgphFr5YQNoAdkeXT+OVcg
         dVET+5UB4b3X5zJPy83I2TXD6MsRCfwjNIhMKv5bdMor/hSmLxg3wrE1Q06swrxRlRcI
         v7iSlLIjNHQjTf/LCVh9TltNp+qquxAio6TTNPEDdiTenHY1gThENfnB+kKjU7SfiQbi
         dC/Dr4ME5g5moLZx6GGTtvbTaGpFgqJEu+lZ7veT3JRKuV8G3gW5s+xdJzYzXME+7IKQ
         fs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776060564; x=1776665364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiV2w1gDFSOFwIi9IbkYMeKe/6rdSHAAIj+UVdB7T+Y=;
        b=drc1cCpOAULc19SAR+Ea3CsztqKomrqHZEUwa/bXvxlxIbUjReKEfWGg1MWVCQ7WEz
         4l5HuGxKjFHhy6tCnzdcQTGHxLt96GG/VoV005QUjPWE7LQXbdqQfCEHTlCQ4zkH0NTQ
         M9Xz13gsmYfZK+r6tfaYdMp4a3Tuk4FUspF//dZ1v7K8uh3BGj82w09crfns9vD3dQfY
         9N7HGXrO/nKEWfCAio3iUCkcbxQKEhWcD99pn+uVPnF4yyPsx8Poc7x0P0qSbrG/k/2n
         B/ZTHDLDWfmN2EeYXlLjZVJNB5fv3O8ZTJkBFGK5J5+d6GvedYe4gK2EzGEFR4lgnyTU
         8ejQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm5QNNuuLIG+mCPu6dJtUTDFP0tleyRRglmTn8m6PepbDjhUoWwkGTz1FiT9/sGHzdc2AaOcIc4LmQUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUXx73N7R21nXDpUT5io/sFY8oDX+BjfblOqScXXWqP9oknqx
	VC9e74uf/qxLZnGa9PAgp6nMic/oJo8ySDYvRWF0bozlNm1w706Ib5TAI43aUveCa8+z6QJMhiV
	cpDKvTowf8xIxEGaZhlheoRxtot9AERs=
X-Gm-Gg: AeBDieuATA4eSLXiZi/n66o724zNwsCDi2H8YFbXuIfvgtlM75TlK4h+32NfGhV2KHt
	77dt93oOlgEqmwpvYDXe0Buzl9GR/ehc+P+nQGa+t3tS09gyNvhgwY6S7Wx+RKr7XKvNH6W17+c
	fulQ+dZhqZr6Afd/sNo69SUCtKt9Yhe2pzVVNaqI9OC0NlbLXiOjZ94i+CYj/pcsW7J/ifrRalF
	GUJaUYmiIwm1fNp0hVh5g2CkflYmAEBFq4HpliAHylie+iNXECbSf7Q1F8B80jfEtgd5hXYD4OU
	+TScAJyi7EbcdrxzRyYpnnEKOuahd/BoeTU+Dk84AY+a0VfzL2SBzpWPUF/0WuNEq17Jb5BlKw/
	V24/z/98=
X-Received: by 2002:a17:907:1c97:b0:b98:6984:6630 with SMTP id
 a640c23a62f3a-b9d724362a7mr613445466b.8.1776060563823; Sun, 12 Apr 2026
 23:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412173317.3329-1-mzndmzn@gmail.com> <20260412173317.3329-2-mzndmzn@gmail.com>
 <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com> <2026041338-guiding-concur-3831@gregkh>
In-Reply-To: <2026041338-guiding-concur-3831@gregkh>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 09:08:47 +0300
X-Gm-Features: AQROBzBRxOFTl4Y0hRK_IfrGAfpqN1gBxS94tU4qKCixCJahw8eu990-6JlRl2s
Message-ID: <CAHp75VeME9eDOZ5KosN_sXTP5CAcOGqPfh4Ld=mamaO=jOJ37w@mail.gmail.com>
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with identity converter
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Baker <mzndmzn@gmail.com>, andy@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 9:03=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Mon, Apr 13, 2026 at 08:58:50AM +0300, Andy Shevchenko wrote:
> > On Sun, Apr 12, 2026 at 8:33=E2=80=AFPM Baker <mzndmzn@gmail.com> wrote=
:
> > >
> > > The define_fbtft_write_reg macro calls 'modifier' as a function.
> > > Passing an empty token as modifier is undefined behavior in C for
> > > fixed-arity macros. Introduce fbtft_no_conv() as an identity
> > > function to replace the empty args in the no-conversion cases.
> >
> > This trick is used in the kernel (usually for u8). If you really want
> > to improve, use _Generic() instead.
>
> No, sorry, this code is fine as-is.

Works for me. I suggested they explore the possibilities, it might be
helpful somewhere else in case of the similar requirements (like in a
new code).

--=20
With Best Regards,
Andy Shevchenko
