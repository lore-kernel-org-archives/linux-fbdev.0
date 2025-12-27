Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2B31A062
	for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845515; cv=none; b=TRrFkfHnWZ4lKQD/8mRbB3F6vEMQkfaTE1igFWy4DctD7YeS4ADMLRpPvT9BAQm90ZtHvlPgCskYpJVXMRCwHW/rB0jTk5oBOuSSQZZv0Nv6jGzBKGtleNrGXtRjjlfCH63y0Y15Lg4Ug9L0ZUdL4qkEnKvR6wtoPqiDcLcljw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845515; c=relaxed/simple;
	bh=J3Wwr64QQ2SpOhKfSDoML0fOFqI1wTu0FLnX32HL/bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL8Us70r5lUhpaXVaoxO7Yy6vdD4bExJk4EoWlY001JGxkcjwCbO968rYWhWqm9BKI2PDGwzP3yhaF+apJtQ4C1J0Mf3dNaR+T7MokUg0Gr2OduQlwQLQPCRw4U7bjGFglY7kgp0dQK7uSoobmYF+lWnwMsakhU5BkoDmodM5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5KDKziY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5KDKziY"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b76b5afdf04so1172462466b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766845512; x=1767450312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3Wwr64QQ2SpOhKfSDoML0fOFqI1wTu0FLnX32HL/bM=;
        b=S5KDKziYarQsEMA4FnGARVKa+hHaOjmlqfn3x3cQPpcxaRkdGDNQ26wZj1c1nu6nP+
         gSibASiBehu2FDSOyHkFzSuEJjMU6xLvESBhqrIQ9hb7ZbVDm5F11aMIppeLdCDV2zfk
         A/MFV9US5Skiz5LrUVJbT1xWbfU/mvAMSC9E6cu8r9nvKztEqtMesmTaUczmWlNEh6Bq
         EgffXEG5GyYQJicYSCPTjrQfXHMuzp6/ALj+D7MUkUKnQMLERdQkpaD+Lnc1ubiFXdLT
         JYH+1D/Fre/A5uqPNZpl8RxcCnJ/Uz2tcF2wD6zjcFLyzS8QRn0CaGtxbbciWelyEGnX
         Crmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766845512; x=1767450312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3Wwr64QQ2SpOhKfSDoML0fOFqI1wTu0FLnX32HL/bM=;
        b=a93jtMcwXH1rVaB/JZDytrdVS9KEzJtATdIcyindEcn+2ZsfvYFuEIcT2adppjKHlH
         +wwC+0adDLztasoB+v3X4MC8gWlkV6phEqpm3WZjSveg8aJUIAisayMi2u+lKNqlrFOV
         8AkVXx0mSUBnUp5SwPqTrGNl3oRt2020pPtn6zL04LV2HFMW9PmyNKd3WfbnS816PjnF
         xaLfV3/W07lY6dP/Gwzwdof9inyjXEN+PoYZHio2gzaCrelBApnQtiMp0W3hzIbPJ9lY
         b7pU+QkrWyPw3wWMMs/o4fyWL3APIxJeMIXLGVp9w+tl4OMp7vCs4po3PdNEkZSUdQCJ
         vkMA==
X-Gm-Message-State: AOJu0YzGOpYQkqFgY8BTAIwWpA27RVpTEmc0iyag/KhUCzB4WdSocwlK
	ggyNgQIrL2TigEirs8hC5ETlITYzlaqQYBWnApXvVA3N/h9xB80mBJdlrjxoM9eTMldMPqz3/Kn
	tERlvsM/aWoUBKO1aBxA0Cyb/Ju4BNag=
X-Gm-Gg: AY/fxX5pkGIaLsu3z/wtewKi7FClZqrVYRG0eD2+q97cfqnTFAqpsssc2lowlYFOLjm
	OOZFaXJL8pY3NDHaxbQPBgdIy+MaPxUznio9Ptz3ITcuznb4B0swL62U8c45Y3IrLzk3VAk8I5H
	s2WR9eGc9eFcMGvitv5bB9ooEFL78hqK6MNqMVkebH3JjSMXHzSyTpsqyYtYkw6mR6bNW/KkZWp
	vbK4X2TBenRNujYQsojDwNxoNzm4Ts7j2DE443rEwLHOxxSXkiDB5ilFJZ/esBCpjsiSRnO4ZW6
	CfdWvz9sSulcq0bDujanwyUzvi7+WN+lZaDXXWkq9mHe9+umzL6epBffR4YhL2K7U16aoSE=
X-Google-Smtp-Source: AGHT+IFX0lsgc4AotttgNOJdIQxVyJ6emc4QU5YPq31MHVjjCSjesmYFWIps47Gzc9uXozCoxrNAzwJrn4uIVEmnK7o=
X-Received: by 2002:a17:907:3faa:b0:b79:fcc9:b00d with SMTP id
 a640c23a62f3a-b80371f353bmr3038598866b.59.1766845511630; Sat, 27 Dec 2025
 06:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219054320.447281-1-chintanlike@gmail.com>
In-Reply-To: <20251219054320.447281-1-chintanlike@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 16:24:35 +0200
X-Gm-Features: AQt7F2qk4lZCeAfQafLC_2U29jnpMMyMdVKvtqDPeHxqHBPfiIH3Qwz7nSdnytw
Message-ID: <CAHp75VeiD518W13KU+vn1yykfw1pXA8Z9Co7t5bXbB+KhCtqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fbdev: Make CONFIG_FB_DEVICE optional for drivers
To: Chintan Patel <chintanlike@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org, 
	deller@gmx.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:43=E2=80=AFAM Chintan Patel <chintanlike@gmail.co=
m> wrote:
>
> This series makes CONFIG_FB_DEVICE optional for fbdev drivers that use
> it only for sysfs interfaces, addressing Thomas Zimmermann=E2=80=99s TODO=
 to
> remove hard FB_DEVICE dependencies.
>
> The series introduces a small helper, dev_of_fbinfo(), which returns
> NULL when CONFIG_FB_DEVICE=3Dn. This allows sysfs code paths to be skippe=
d
> via runtime checks, avoids #ifdef CONFIG_FB_DEVICE clutter, and keeps
> full compile-time syntax checking.

Please, address my comments and I give a tag for v3. I pretty much
like the series, thanks!

--=20
With Best Regards,
Andy Shevchenko
