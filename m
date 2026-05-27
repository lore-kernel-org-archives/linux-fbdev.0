Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E63F0756
	for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887853; cv=none; b=Nr+qfbIzYrxHoFZvCqNN71SWNsNP367STifJQM1hd4DsOV9m+CBK9fysZ4G/cIgGwNMlXSFcWFTIJuSIq3cCsd5hfh3m6CSCPvj0RQacftbphqE3JLgJm6z1AZc3pTQKTvW2XVITN/RlGYLpEgp7bbxFva7SUiw9besq3OcSPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887853; c=relaxed/simple;
	bh=81bZPJ37mn7A1nrBTaGVCfLUM4t8SEKkTzKdMLIZgMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDKp4NsjXnW1VSG2spCLuUYBApvh2OkSxXLgRWfGPp8LoYlrOzgFU8rPopxiD0W5MK/JrAc+Kvp0i5KAeVMv5+iW4omZWhygUmOu/ph0scZ1CruwyMr4g1iSsN9vKG2avVLs1O1ySt/I0bNx5meYZWtugrcpf7Q0kNmhcsbQyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-631333ee9e4so3673116137.0
        for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 06:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887850; x=1780492650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRCmfpq1b4R+1qcl85pdAn5PhWzGoG97LYi2GdYmC1E=;
        b=bD9P8ApX7rnp5BtndiZ+VACYX+NbDzwMjNFKKx4wv6nq0JjTbbjt2q9wND6O6+ldKI
         94okG0GMZDM50YCqsF61gx5USqDZlLQvmxMZYrkRgnE3TYfikawX2zHdvyceq3rM4nQ0
         mBZ1mDmjg6NN6eVkp7VbvDugX9k/i9h14UJohUe4N4qxt5fuSwAKDL/Ks1lTFUr2bCsV
         nm6wi2Cylx+eopyKTrbJPNivtsOOfJ73CZxHXUvxClek2zDnhjk4/pxHVuHkIde9TR2M
         6k4FVxVD4CmRLr+9uY9t4YGjs7W03PFZW7D/CYjwiU8nlNKCewBWrj7/hFOxdgmsDO6h
         ZpRg==
X-Forwarded-Encrypted: i=1; AFNElJ/weDxp7UiySE/+CCVuiCO+xhye1og7h5xAOi0EQ8tuV5ZaxTaK/oA5fM9kU+QhCze1eKHieJupBzxt7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbrzgOEX3dBsdmgeZT6LIymy8KGkLnQYVsQv4Hw4emd/DV5aJ
	kei9YSYlG1mS52JxUxWzdPiT3yVug1ppsoBRC39BVZflXHAWIILV25v3Wlv4xjBqSlM=
X-Gm-Gg: Acq92OHDOaugVe9FjlbaiQsxFhNyaz+1o6EuxnDaSZGZNebbDRVr01v25rU7GYRwcTx
	Gudj4vA62K63XlDMtKgSrJWMMUPiyYlvxOqZVmhjD8BE93cw/h6Qt2WQUP9Ccz87p8UCZxxvbF8
	49m+I6BwWYZ7Rws+Hvmm3ggichkNvu8NCe6jUvw4WbaHRs8JKVjhttoa8N0rziZwnphWOds+v5+
	+a4GWxYuSY5rz4wyg+o5yY+0SMcRDw7XRDNVwCKV80DBUykBGjlg00HTzS0Ivuc7g5NGsFl9UC9
	CZqNY0tmrdNDram2pPUpZ68ENLf/URxfyjA+H72zoeoz3D/wOb8yVLUlosa8phBUHp6zUYtg5Lb
	dTLjwv3J8XyOlMFdb3kzseL53ROQ/3kioID2/jj/f7vIck23BcquXHcMeCIB60SfJ2jYLKJuymq
	afIDq35vhVKsdHhh6E1p1DG0cyFkLdtcAJaG8aVObFkC03DiyGXIUS1BjQhz9jSJBtF3bjEzg=
X-Received: by 2002:a05:6102:c07:b0:631:2f82:c3ce with SMTP id ada2fe7eead31-67c77ff1283mr10060468137.10.1779887850147;
        Wed, 27 May 2026 06:17:30 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm16977702241.10.2026.05.27.06.17.28
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:17:29 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so1316404241.1
        for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 06:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8g0w9+Als91rITW27nLTlC+G84dtOho9QoBuju1Bc5NH+IqDq9d5PKsDyK52N7kkjyKwKHv0+EWSAdCg==@vger.kernel.org
X-Received: by 2002:a05:6102:3ec6:b0:631:4580:6a3f with SMTP id
 ada2fe7eead31-67c767cb843mr10676067137.7.1779887848413; Wed, 27 May 2026
 06:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <12911d2a1dfc4e482bbc0a417df73748283d04ee.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <12911d2a1dfc4e482bbc0a417df73748283d04ee.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:17:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZZi9MVEnS1VjugLCY-18Rxq9FcrtzR7x3=MdbcmTiHg@mail.gmail.com>
X-Gm-Features: AVHnY4IGd02q56r2qfPhmxXv4tp6c-mV5aR4QFnr15yhVjYq6uruWZtcFagWHm4
Message-ID: <CAMuHMdXZZi9MVEnS1VjugLCY-18Rxq9FcrtzR7x3=MdbcmTiHg@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] video: fm2fb: Use named initializer for
 zorro_device_id array
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Using named initializers is more explicit and thus easier to parse for a
> human.
>
> While touching this array, drop the explicit zero from the list terminato=
r.
>
> This change doesn't introduce changes to the compiled zorro_device_id
> array.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
