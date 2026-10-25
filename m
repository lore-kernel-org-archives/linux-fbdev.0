Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.222.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792908047;
	b=DJpLo4yJ+SOTcKBiaNuhimIDoc87ktzZodq+cj9xdLMH/KqVDpcbZapNsu114OvqEHYX
	 g3o+RmNy7Vbct4lpd4b5Zk2FNdrpb5UV1WIfzZUfTV3noRYqNkwJCgwjOf95C5A4bV9ED
	 Z5g0FUSUqbr+KcQN69cQSfqbh9T9wfwl8wn0l2wVA02uYoo7fhe7RkoY6BNJkhv4V9Yhl
	 ZzYsqm6xH2md6WBLg/2XCtyjsnTLX8yRaaqvriLl41My7H7dQGTkBzvOs+A0E68yCJtYq
	 0g8uEUMFSKdFs2CsiqjZ53r6IS4G576HVXEQViZJf+0BPJYWjiDNL3gTYLqfnXBEiZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792908047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K5aG9/sUaDY/v6QVU25+fMMSYhzDkzcZSaaIiSDMnYU=;
	b=e8LzwM57U1uDbmp3mvIXPnPu4WwcjO1VjNi5Wj1Hxf/Cd59uCs9DVDKxbbeTfVdbCT/k
	 S12Od+Azg5rMzoIbLG2vFcuQO79ilqH/vWBPHU5cl3tnXvRN9l3b5bN+kZcd+1RuVMck9
	 02FukVy7GkFWsNFpP7j/8zupzEP5k8CRr3W1PeCEzdtAt+2NnVfwWLWFtSfijP8Qt5Li8
	 +PQlulVUc9m2axmrS25NIByGKxBHL3ok5zEi8/VcLyDYxJIZXvoFx8bEsjKXtX3zEjeoo
	 ji3PzPJJkWcLMvjD5zuSywR1PY9/lDRYLNYBpKa018kcER4x8edqX5otLwm9JfKnRVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBDJCHJr;
	arc=fail smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187ED606A31B
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 06:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 187ED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aBDJCHJr
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso1202640241.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 23:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792908046; cv=none;
        d=google.com; s=arc-20260327;
        b=mQhAhIdRgXPZRWVg14/vg1YEY9qsczDnhdiUT2iBDcNs1ynpg0SCjswHD/14StERI6
         6eo1mKRMP+HJK+ij9GCWh0UfUjODiH/48hPCIjfOY4n1JXU1ZTuBNfMUfmbn/Hb+gCGn
         5SAf3pZtSB8CVi0JAHep6UqG0ZJEEXxsGR5xuEKQ2Bcg3LlrrU6jAWOOCvHiAlYX3XrX
         Zeab3L7/6iHocPHjgNaHF5BwahpzgbcrQ9w7rRwAc1/bS4pp+1ehD6xxc4s56lTYFGaR
         xyEVhA72C0852KljqbDJMwxgi95526SfZEo7bKGiG3aIjqIpQlIdTzylcJZZV5R5Bkm/
         jjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5aG9/sUaDY/v6QVU25+fMMSYhzDkzcZSaaIiSDMnYU=;
        fh=5lBsuZ5Z0VexDpFmT4fEDsY3XT9mNoTZ5kJKYx3Ab28=;
        b=sbsJxXr1qdliiRr+BvNuxGwRPDyb/zsgwtSFukfDWmcZAAGYAh9U+sIYTDdaEcx4ur
         hU0uyjO/2khmVAkEzDke/xaSt54f1i8Pfb9gXl6Y+bghXOKOtxrz7ZBGdq0bR+x74+9p
         AcycbJdNaAXnF0tGoj1A1kaC+3GohZx3MsBAOWTrkiHjrFfX93Pxw7ZDYR/Sx54/OcI+
         kSlVYq91ebMRRoCLiBtjdzTU+ayvNZUo/iFcsuknCGGvOUam3rZ8JeCTYYr83yJtMgVq
         kMpqcPPEH7q/hILRuLIl0qeMr6oZCAWNoXNqxrggrNEy7FyEdY9n5mS4DnNXzh/UqOe5
         FBag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792908046; x=1793512846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5aG9/sUaDY/v6QVU25+fMMSYhzDkzcZSaaIiSDMnYU=;
        b=aBDJCHJr3gs5UqlwO4qkm5b+/q3qddgt24G0l+wj+ZVgzOa6uo+WBuTjtx3y2qiGal
         DnDcHliM2p8YUOMeep0mD0M1cc4Ke5wMGUnjdYG206YZMew4k6DsPtzuofGfcjGK7EZ8
         I2ILArKvpvwhFfW8J2NO17Cj9vOcYcKXRkuCy8CI0zIZJcvnYT2J5bifp6+W9u+pu8Zq
         JtXl3LBTHpQrAkrRhvNH9s+j5WVnhQMPv22OK+QrfbEfV8zy3p7BCTsAXEhoWLRMWm7p
         c6uVGhTXFDUmYjHZajWiDelmLoly6gz/zz/8PdANaUj2iPlaprdwX7bpfPSlSMr3TPcj
         MfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792908046; x=1793512846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5aG9/sUaDY/v6QVU25+fMMSYhzDkzcZSaaIiSDMnYU=;
        b=qPqgigDMq9QnP4mf4R8/ajuMW/rAOaed8l4Iv/94IFkOiVYfd3aVkN+UL8Z8jZ2Uvd
         Fk3uzjzDlR0un4w1ooYqlRNsYNwXeCaBOvyYizbYDBd8I0wDwmEVysH+y6Fgu/ahup00
         sJNoQLLcykQUjRgdkSbOZkEZGAwmrZxVRxqiSKcepN4rjw0Ef2pxaWPYhWgNevRCs+QF
         pjQ+V5vVrb/oyWw5l4Oo4OE+5jqzzEPo74/exBCUXqf01XXE2SEBcJiQLXVExxYVvSdS
         +hKXbW4WoYpFlEwtcmxTuc48felXqlBxRzJrnGIfLajrUhArKe9kL0lLY6wblfBJt3mr
         ux5g==
X-Forwarded-Encrypted: i=1; AKwUvByaSOebrdU+hLpb1HTlAuJL4vfaTiU/oXpQcDePzNC+1MVB0RG54898dEzy8dr70RbnhUy+Hm4W2/KYFw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKnIGj4VsxRRZSTGiOSODT+HvMzpT4nVx0NqqDFJcZRmWK46Gh9
	r25Y0ZXI8s763cLxgDA1fIbIRkAJ7H33FMTsX4QcXdiZIQXgZboV0sDa6V0h344VeqZ1wUAxPK0
	ofz574CSwmOYXe2Jn1FcsuZG/ZVKoo7M=
X-Gm-Gg: AYBFou0Gvdt1wSMpn5q2ZY+K8Frhr1uOlwlXFw7Jk2z1+XDT1H55CcHzOcBOTN2Ggey
	soIUEaW+67+Vx0zu4XJnsXQTp3fwdjzYSBiEdvl8x7JGLoLyyBU6ar/X4Jt5HIuPl48voadLsnx
	W4H3sv0eRrD7I2ulXrIPDEYwPUW8/DDDZ1/s3x9Jm+wNldTuz6mypyXkt4mM6sdb5SbHRZfr5Om
	wmNYBn2vHosNyWtMm92svGB5HQN6ErFn8t83TfTjfyV0AhIOrPzxKIoc9dKGLxCIvLI5kYYxp6L
	awg1r8SaN+5LB6B1hAdeT7gxCXLeJakhNbamak0zp6MVHSMjjoIoDyd1Kx12qLk9kCot857dQq3
	mWJQ7rnrnbO70qIfJSt4d9TaCWS5X0WBbWVQ=
X-Received: by 2002:a05:6102:3fa7:b0:7c3:3f26:8785 with SMTP id
 ada2fe7eead31-7ce5cc37c83mr1116161137.7.1792908046029; Sat, 24 Oct 2026
 23:00:46 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025052136.389541-1-dev.adityanagar@gmail.com> <2026102519-polymer-gorged-bc90@gregkh>
In-Reply-To: <2026102519-polymer-gorged-bc90@gregkh>
From: Aditya Nagar <dev.adityanagar@gmail.com>
Date: Sun, 25 Oct 2026 11:30:34 +0530
X-Gm-Features: AclHuK_TcOcKb9WAKxu1FqX-QDlLrI_sal7kxnj4OmX_2Ibk9PcCncKk3AAFZfw
Message-ID: <CAHLX7j6Ue5gVxc+bLZS5kphO39bs=Jf55Pc4nEyN-aiqtnmndQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: remove unused argument from FBTFT_SPI_DRIVER()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-staging@lists.linux.dev, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for the explanation, understood the message and I apologise.

Thanks,
Aditya

On Sun, Oct 25, 2026 at 11:25=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 25, 2026 at 10:51:36AM +0530, Aditya Nagar wrote:
> > The _compatible argument of FBTFT_SPI_DRIVER() is never used in the
> > macro body. The device tree match table is created separately by
> > FBTFT_DT_TABLE() in both callers, FBTFT_REGISTER_DRIVER() and
> > FBTFT_REGISTER_SPI_DRIVER().
> >
> > Drop the argument and update both callers. No functional change.
> >
> > The argument has been unused since the macro was introduced in commit
> > c222ea5d2f33 ("staging: fbtft: Deduplicate driver registration macros")=
.
> >
> > Found with checkpatch.pl (MACRO_ARG_UNUSED). The change was prepared
> > with the help of an AI coding assistant (Claude); I reviewed it and
> > build-tested all fbtft drivers with W=3D1.
> >
> > Signed-off-by: Aditya Nagar <dev.adityanagar@gmail.com>
>
> Sorry, but please read:
>         https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
