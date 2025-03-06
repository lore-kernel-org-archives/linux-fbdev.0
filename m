Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2482DDA8;
	Thu,  6 Mar 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290012; cv=none; b=tY59qxdE5ZnYni5yUHI9VHMlJExq7+T94AbB1xfcu8UQVeEQKr3NJTl4F1w7Td57R0sJkDkJ1zE/FlKQUb1XwQ5QMWId+w8H3pragInVT2sH9fKRviSdW9XEgwd2ba36VW3Zlwrl7Q7j+M1S9ZaXGeOAbDnc9nF3495FzQOHLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290012; c=relaxed/simple;
	bh=CFtDuLIpuU03+nhtMAtX9r4UPxfCF/bDqSWeFl/X5vQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9He2uyBHZxAoTPeHxSV3PtOJyWXBMYNfoN2KmJDcRCYbT6VKltOcrCZH1VMgRP98fNnz+d2BEJlBM0PRB6XaTl7XEwtOEwwMhhElNOIvu40aHSPSO8VfIq9LAEldvL+9Y1rovJnW8bJilSzZHh9qIpcIx3OzI/s4UumY8xrVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOfGrryq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOfGrryq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso21134605ad.1;
        Thu, 06 Mar 2025 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741290010; x=1741894810; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ewCB/nm+A9ngd0jnoOxdtVcsF/YbNlLGD5eMN+wHgAQ=;
        b=DOfGrryqhsvUzUrcX9Tmg22AtyKvTGuTxsIyAzNx9dY0y5J/VB8L51QCmEXwbK5OkC
         A0X/KI6DR8R+g4EEXdDSUjLwpzKw4Pr5DufQ/rR/RNewHCx7qCZCORm+BrQ1kzOM5ubS
         KrR58S4xqPiwZEIVresT6x96KHzte43t1QhWwJXz2mCIq9W7207r0oETY7J47qJjbyaP
         sWz8J66cfaX66lesjcMOr398QRIZuzuiB31akNLJvQDhc2vNWkC2+wQ8tv5RHLhtmPHj
         1SPGKjwh30EmBO8W0N3cURWcS1bhLTftpmcZdej/xhKQR5NJANNJxA1hQDWio8HcDTg7
         nFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290010; x=1741894810;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewCB/nm+A9ngd0jnoOxdtVcsF/YbNlLGD5eMN+wHgAQ=;
        b=eoKxulrFb+nkMiyigFM6GR3TuBynozEVdzqlrmC5ZuutM2wzIFf8LaeO4ZIXMw3C61
         97QvNctC2qMiCf4G3CYBXTRuvdEIOgwioETSdD9acU/KnXsdluxUHRbCflDuLpXiHTZF
         vYz39mzm2b8EZDTwx9GOZjUUCqk2hs+SLVqIRhv4J77232T+HNueKsEhLLJv68wYIjs8
         tKy9frN6mQFOrLPcPOX7CHdvxbmCFA4LhQHnOeGA66U7J20iKiA4VkyaJfARuF8uVrrv
         7abntL3oI9HwxTnRI0tjJAtWcRFhGbS04uGtHtC6L7BLrEQOZIxgDCbq+nxzBfU9J2na
         Oqvg==
X-Forwarded-Encrypted: i=1; AJvYcCXb8kKuOjO4QNkeqLL8Y5k8xzEOZJN2v9AO7AsN3bERNnBetjwng1MGs2uyPcd83eHmc/Ue3qK7zJBsgy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoI/dPivPqLbJUBiauZeNgPygyHAkzGUbaf7YLkt9eFtW8Bzqt
	OFOzwDPtQX5N8tqSXY3BqGWfCFl02+Z3QAsuOpaRO93rBSF/NWzB
X-Gm-Gg: ASbGncs2BBnSJreHonI2r3+A2m1XwwEuhSScQOHq0vtkzPWYVqIToDP0m7IqyLvuAqN
	3A5lEZw+zSlQLi69006S1Sx8p/61jTJ0qBvD3ZHN6C2N88DmGhJ2WIs4jTPFWrmOePuA4l6xkdz
	vkVWsShR9Q494Fm0KAKhPa7Aov4Qhe8b1TsoM56o/8lyhiT9tQqlUs1ndz0FwLAukPgA9Td4fkk
	ZI7KZcRXTRj4BeKzF2cHPPZYd2vGHtOe6QDiG+0bsmLVzP1ZF+hpTX9beJPVHS/cU559mNHkR5B
	M+2ZShpT05to153ZMbViTLPaybGlMInrZceekQy7/BRF3oTBqAtBq7AIkpQFqMxngf8/v+rdeuA
	H4GmznR5dPyyjbLu18bA=
X-Google-Smtp-Source: AGHT+IEQMyjX97Nt8KzVYICwQGtL7t0fOwHtki0gYYS+FzmLNhfE7q4pmhk2ZkcLJLMumQ0lloKrXQ==
X-Received: by 2002:a17:903:292:b0:215:58be:334e with SMTP id d9443c01a7336-22426fd8525mr13145525ad.10.1741290009936;
        Thu, 06 Mar 2025 11:40:09 -0800 (PST)
Received: from ?IPv6:2804:7f0:3f4:754:40b4:b78f:5cfc:8620? ([2804:7f0:3f4:754:40b4:b78f:5cfc:8620])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa448dsm16304945ad.210.2025.03.06.11.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:40:09 -0800 (PST)
Message-ID: <635f849e14854b0db1f53a0d0bf329c3070e5859.camel@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase variable naming
From: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
  Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  ~lkcamp/patches@lists.sr.ht
Date: Thu, 06 Mar 2025 16:40:05 -0300
In-Reply-To: <ba45d980-c6b1-482a-8bfd-457a92d3e24b@stanley.mountain>
References: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>
	 <ba45d980-c6b1-482a-8bfd-457a92d3e24b@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Em sex, 2025-02-28 =C3=A0s 20:40 +0300, Dan Carpenter escreveu:
> On Fri, Feb 28, 2025 at 01:23:54PM -0300, Gabriel Lima Luz wrote:
> > Adhere to Linux kernel coding style.
> >=20
> > Reported by checkpatch:
> >=20
> > CHECK: Avoid CamelCase
> >=20
> > Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
> > ---
> > =C2=A0drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/staging/sm750fb/ddk750_power.h
> > b/drivers/staging/sm750fb/ddk750_power.h
> > index 63c9e8b6ffb3..33e852fe6949 100644
> > --- a/drivers/staging/sm750fb/ddk750_power.h
> > +++ b/drivers/staging/sm750fb/ddk750_power.h
> > @@ -3,10 +3,10 @@
> > =C2=A0#define DDK750_POWER_H__
> > =C2=A0
> > =C2=A0enum dpms {
> > -	crtDPMS_ON =3D 0x0,
> > -	crtDPMS_STANDBY =3D 0x1,
> > -	crtDPMS_SUSPEND =3D 0x2,
> > -	crtDPMS_OFF =3D 0x3,
> > +	crt_DPMS_ON =3D 0x0,
> > +	crt_DPMS_STANDBY =3D 0x1,
> > +	crt_DPMS_SUSPEND =3D 0x2,
> > +	crt_DPMS_OFF =3D 0x3,
> > =C2=A0};
> > =C2=A0
>=20
> It seems these are not used.=C2=A0 Just delete them.
>=20
> regards,
> dan carpenter
>=20
The dpms enum is used in the definition of the=20
ddk750_set_dpms function in ddk750_power.h file and
this function is called in ddk750_display.c on line 158.

If I were to delete it, what changes should I make to=20
the function mentioned above ?=20

this is my first contribution, thanks for all the help.

best regards,
Gabriel Lima
