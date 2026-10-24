Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792852007;
	b=t9cUxhOO5jrEmDdhb3gMTD2lWGiv9x4KcupE8N7Yn9/gRuZXn1sPcDEX9rxKdsrXJ3LS
	 HQl5EagzcSEmD2vPF/9ixdhMA4KMrHno42TCF6u9cx5yMqrHwjE9l7xBquyzI2laCxsGU
	 ErN1QGvAP0xPPVOOAZ23oL/nF6HCucCN5WoOyvr40ObDCalpmoyUPbNIqNBZAozguM7nv
	 vdGZqOuidUC/0aXUJROTNLDwE4jf4ihu1v1muB7IgllZ+78zN7/GK8wcCevKVJ3vopP62
	 CvBvWNDOSUiWZo5JkQtVBdHhjgz0mKmYrou7MZya02Brq3zxLX/4LgYiyZ6TvPykMQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=93XTeLUJKmkMQYlViuECaN+uLdlXc1eW17xeu0ZWGzU=;
	b=iFE+0vfCvRVeCkVbdYlPFzka9amrVvJ2kWpAXKLmtHo8FeR/YR32/Df3uAG9cfTYl+I8
	 T24WPShfWy4VHfHeGarR+07yyumiPq9hudOXBXe6/Z1oRq9U6EdWHs2lgrLQvhwbYxTmG
	 sODQ6+rZ8wcXEHcoN83do0tx/zervfEC3/5C/mDUmj668g6sMBimvxU7Asc5gPZEeGm0v
	 7IRlrhGPC2qqxHxLOORlUhb62uFIH3yZCPkCFlEm4O8mGI1LWoArpRF+GyCSYj+NKCBSR
	 PhicX1iGsc3MUNetsL7N6M2hq6K5Lu94tuELg0RRN1z+V4M2GJJ0Zkw7wpFx/j8zqRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RaNq+7qO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893A606A31F
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 14:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6893A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RaNq+7qO
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6e560e00a86so1163399eaf.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 07:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792852006; cv=none;
        d=google.com; s=arc-20260327;
        b=rNN3/6Y4h+SDzWYB4+Y7jQQF4mMJKIHvIvvTS2W6QRQSo72YPin2Y4ZL6/+FbpAI/2
         ySiIkdrmzqqSawisJ7wlcY/OHFJaCCKMy25zp56L53dN4+2Af+AGhqJl+D+ipVk4vB5p
         xYehXp0GSolLNlswi0Ju2CZucyOKCbldbHpvygMgmEfK9omxfOVwEXs3FqrtQs6Tkz7W
         iu7DBOgYZKd2qM97baoxsG6wLLxuxYENKvTiUph1w1fpzGsaD6bhYvy2hZHbaRFZVLsa
         VaqZGj9v+t6UDi/XnVXMaIuvMTR8a6vdsuHxLl69YjOStY9D0fzRsG2EOPRdnonDxjyk
         pfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=93XTeLUJKmkMQYlViuECaN+uLdlXc1eW17xeu0ZWGzU=;
        fh=w0RZ/EfbRUWpig09RNiUYgz7gUGfQ+qhh/qfmWV2IOk=;
        b=WgK6ZZP3FN+YWi9gT8EmFBCnOHev0xQjNyDFULNHo5lM0JnKnUp26juYZrlrsAb7Dl
         qeQrwoRKgcVbybGzt6LnZzmd9yrPonkGKTWyLbm9B71KRXEDMcmvc7oygsFT0fSrxJMN
         G9HN+pipfIuloQnKzmIu7cp9JwSnIfwx/eGDswuPTbNgSw5bEdBjcRSu/toWtPYI6kRL
         8bue37qoLuJoSUJOzyNOq5sT93xGaLN+Aef1t86ESwD381l/Xa2O25gesOBl/vkvzPRh
         suCPoEkU+z5IpBic0gaUSkrZWtHSIoWd5+FFbCD+fBgZCfCibEDvdguYYkYPWTkuG3Wh
         9tcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792852006; x=1793456806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=93XTeLUJKmkMQYlViuECaN+uLdlXc1eW17xeu0ZWGzU=;
        b=RaNq+7qO+0JZjvIFSzJ1cvRHhvrgLaPwkcTdK6H+ubodwHYEFy4K0l5T2xXs+UQRJM
         ku0c/21oTI6Fmlzrf1aLR/MwkK6WEp/EfAzayFPN7oKoMiMvTCdSKf9zKbI9gVwV465q
         zZcQWRIRxNFCwJBz1/Gb7WEx2SV5YlhXHCmrEzHDlYsEwXrv2wz/yV2auXi8+gURiudG
         3T0xvCQgB1f0KDKLYUb19SlStQy/sNZdCDCAHADHPHEQCZWFR+RahjanT3JyaZqbsfid
         p60o1rjWvY0LZV5G+TxXQlKP+ws46XaxtsdgiZRgSVdHEHBatE5IQlQr5fDFShfhQpYS
         ta+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852006; x=1793456806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93XTeLUJKmkMQYlViuECaN+uLdlXc1eW17xeu0ZWGzU=;
        b=xDXatxzDDaXDrvCGvM8pYHLmM/FEWUrywwloYEpYdOsSBEsF1VToEEOq/vQR/J8mxZ
         HtG829Zm6nrGO21BKHJrsTTLKlAc2Jbae+K4qdyRm7lXTsMJHyP5zjNPAIYHBX5fUdTi
         wr+Qe3S+4YB7eSV6+HI0DIm+0lHD3UxaMPsw9sClveqIJ2WkyMVCfan+cLY27bULJ6PG
         RepJrpWNU14p/p+86eXajatHb0vIaVWKlIMNdIoIbP+jLtPd8LAhdOJ9ec/mHGaRdskX
         J1DeB3ma5a30laENPGEzyDopvRAh9gElphpo78LzMItSXGJgLiE+QgrFNQKvy/8DHq4I
         mrow==
X-Forwarded-Encrypted: i=1; AKwUvBzOXb+7iB/76DDKXK13DelD71hSDt1AxsnI/46Qbc9j0p/wPgAjIvsNP9g63U0hi7EoKvZhPR6GkGcX0g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLKAzXEVqYGvo0nPSJwaRPiQ65omNcVn64X/1/465w3IOX9Lcqc
	NGnwZoFzeIpjhHVqoSWE8GsPXLC8oTcf5c8kjSzQzxbi3m8tcais40JG95xEUd6oNCJnNxrX24g
	2v+njo3zdxjbrIf4cIYyes0p7URyB424=
X-Gm-Gg: AYBFou0R8mwFGmjqxPW6IqkUa+0pfhY/dGQscPzbahpEBPBxCJl0LlNNvr0u6EVaYVs
	//oDEx2/pCe4X+90OWAyqpnoM1A9CD5k5wDBY8Yvu39PbVdXu4gL0+nuWNDhbcE1Sx/vM/ujS6c
	xHp6K+ltGjE9J37/hB2MbOMaq2aNtQDSijTM91ET0BP4DuAWDOib9QQIRTq85XA0HgA+qr596x4
	gCr3Rqv+FgF9zbgbTNgJb5RIPvt0YOZA6B6WBtTWyoqwzUGDR88KTR3Rm71ZqB+3kOwLXyaGj/7
	BJrwXg+2TlRJgei67EuJjainr7i4BlrYDtUln2kYl5Fq8uleg2mOAVvH36kCeXvRrncQvJwv3LC
	DEeA32BuBRzpVXaKPuqcOS2NJ24DZMgoZ/oBDecwjTlK9ZYop4ZgCc1zutQf/nEGpo9CKqdTCeh
	qPcvaCuSgdrgA9yXLf
X-Received: by 2002:a05:6820:740b:b0:6cd:3fdb:fa6a with SMTP id
 006d021491bc7-70ba0f580e0mr687530eaf.85.1792852005887; Sat, 24 Oct 2026
 07:26:45 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024073549.29531-1-himanshu.bakshi478@gmail.com>
 <2026102448-tackle-footnote-9ca0@gregkh> <CAGLmz9+J-s98cT_ZFHF5EU7t=beK8m82fjq20+n5dmncdrMSEQ@mail.gmail.com>
 <2026102447-exhale-overarch-8ce7@gregkh>
In-Reply-To: <2026102447-exhale-overarch-8ce7@gregkh>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Sat, 24 Oct 2026 19:56:33 +0530
X-Gm-Features: AclHuK8JmRrrQFyrUfEN_DWwoARda0TGIesVXvInZouzCX2AOxXXYX-vfgnqmK8
Message-ID: <CAGLmz9JS1rGR+fM7Rm5FXsFx4aDZuMoYYXH1HJ2_8B+WT_n4Rw@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: clean up PLL calculation code
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thank you for the feedback. I have read the discussion you linked.

My motivation for this patch was that I found the existing PLL
calculation difficult to follow when I was trying to understand it. I
wanted to document the formula, make the candidate-selection logic
easier to follow, and reduce the nesting.

I understand that making code look cleaner by itself may not be a
sufficient reason to change existing kernel code. I wanted to improve
the readability and understandability of this function, but I should
have explained the concrete benefit more clearly in the commit
message.

Regarding the LLM, I used it to help generate a standalone
differential test for comparing the original and modified algorithms.
The refactoring was my attempt to improve the code while learning how
to contribute to the kernel. I ran the generated test, but I
understand that testing copies of the implementations is not the same
as testing the actual kernel function.

I am new to kernel development and did not have a good understanding
of the contribution workflow when I started. I used an LLM as a
learning aid, but I recognize that I am responsible for understanding
and justifying every change and test I submit.

I will also make sure to follow the mailing list's plain-text and
bottom-posting conventions.

Thank you for taking the time to explain these issues.

Thanks and Regards,
         Himanshu Bakshi

On Sat, Oct 24, 2026 at 7:40=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Oct 24, 2026 at 05:20:41PM +0530, Himanshu Bakshi wrote:
> > Hi Greg,
>
> Please do not top-post or send html email, the list rejects that.
>
> > I found this while reviewing sm750_calc_pll_value() and looking for a
> > cleaner way to handle the PLL candidate calculation.
>
> But why does it need to be "cleaner"?
>
> > I tested the change as follows:
> >
> > Built the sm750fb driver successfully using make -j2
> > M=3Ddrivers/staging/sm750fb W=3D1.
> >
> > Ran a standalone C differential regression test comparing the original
> > and modified algorithms across 2,010,084 test cases, including
> > frequency sweeps, boundary values, and randomized requests.
>
> Ah, you used a LLM.  You have read:
>         https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
> right?
>
> Sorry,
>
> greg k-h
