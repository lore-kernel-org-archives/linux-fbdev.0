Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A611A38D0
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441860; cv=none; b=Q+Re645xxAOX5FNi7h30XMYkhs0O85dp36Ih6y6tfCDgoAdXOriV5dsm5OPOF6HrZ78ATuTkH19J1CAgVuUVZeUeoj5POH3VXFTcSyKPN79zs6ilhztD0yw67ATP9F1oWYbbMrEsH8DPTv2jtto2KDJ2jkBtF7EzevwOnC+sxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441860; c=relaxed/simple;
	bh=kJz+3GphfQRjGfzcUODxvqODVcMOmDoo08SCKA5W6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7B8VwWToDuuLxvOAC6JpdtUd3Kx7zKrSbFEVZjbUqV4YfqJs9LUH/p95xPbo4SmEU+hy4kcDITL0lQpS7FGiqEoElwEdss3V8vsi27j/5lBhR8EZNxjQ0JWvWNAyfRqMhRUyRMECLYzDDtfSg8CNMQ9gdcCEFqFv/hJzOsEUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHyFf8me; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHyFf8me"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso777410a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710441859; x=1711046659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJz+3GphfQRjGfzcUODxvqODVcMOmDoo08SCKA5W6Co=;
        b=ZHyFf8me7VHmlzIFBAo5o8TOnNDuNpxgC+zLYRzMiBFlb3T+RHGA2TjLX4++kMipMt
         cOQqgMnNCHLgaKggGMeBB+85rM98Y+3ifztQgGK2Qs6A5ozVHJlO4XZLFALmXKiLXzsM
         5QQJDT6/LXHw36z5KCc756jhXfX/gc7Ib6KP0O5j1gUv4zSyWGsRb0DE2ejRIH7cqYjg
         3rbOXJ7NyRKD7n0KnOrItP759FqgX1nj7gAhdrMm1c8KMd9tyw1UWbXedjTmynNjS00b
         yS6tToW/H5g5F//Tf0x4G+IK5O6z2O8VXKl9ivGvLvdsrW8ahP3kw08u4OfS/D3vkmsD
         KUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441859; x=1711046659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJz+3GphfQRjGfzcUODxvqODVcMOmDoo08SCKA5W6Co=;
        b=GrQUGq7jrgQyOA5c2Y1skBb7d1q2NC84VtJ8JKWYe4L8uIenE3OBrd0JSH2r4Hf1Zv
         jFUl2OODqbu5vhhdH8gywTAVS9/9J/IyGiGinUJH7oJU7k0wfgfM8gyfH25rt8ZlmWG4
         u6mYGXDigK+NgJAMkxbREzNFbbekMTDn2EWL84Lenm/AnNHr7EjOsj2fcQC+liu62C7L
         pvjGIBRDdrhJWb5DqMsPPUuE2Prd64cGXuhe118+i0nEztxcGS14oMlxuaaeLTSvQQ89
         TcaNFYaVYTdJ8VFZCDkDAObPLDaBW2OuXgJSvrTeSYH3GF2W2v/0SK2OCZb3WtubGvcg
         RG3g==
X-Forwarded-Encrypted: i=1; AJvYcCVjrMs9II7476zmF6yFuhjgEIaFeQ5KGO7WzI4Uc+DxHPCz4omKsUKSpSXTKJRO7wI159vEgnA/1nKBXYRysvoAcGoSw0NOLzTMkG4=
X-Gm-Message-State: AOJu0YwNSC7SaIjES+PyoqTGSyiaGiatvrr74I2HCTGFAKkNhgksZ/1G
	mp+pYMp1fJ0psA204NRqUK+OzMTjucrrfSUYPJD8FPV5Q1JDC26C9m5kUDRDFi278o0PK8jduGe
	XLqqRTUN6o13HRvRNNe36It69Kto=
X-Google-Smtp-Source: AGHT+IHVh0RTfRsRb9qBzH00kDp5190hZcjprlGA9pYXBm6DQD2MCRakmxgYPKjHRPex76AnjnKvRQ0FLazeWULWWyg=
X-Received: by 2002:a05:6a20:9745:b0:1a3:17f0:c4f3 with SMTP id
 hs5-20020a056a20974500b001a317f0c4f3mr1010234pzc.35.1710441858697; Thu, 14
 Mar 2024 11:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313154857.12949-1-tzimmermann@suse.de> <20240313154857.12949-2-tzimmermann@suse.de>
 <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com> <20240313175434.GA96726@ravnborg.org>
In-Reply-To: <20240313175434.GA96726@ravnborg.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Mar 2024 19:44:06 +0100
Message-ID: <CANiq72k0yhmEh3720HBDaE8dJt6wUNrcxCopbNvc096DJhQsrQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, lee@kernel.org, daniel.thompson@linaro.org, 
	jingoohan1@gmail.com, deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	Robin van der Gracht <robin@protonic.nl>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:54=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wro=
te:
>
> The driver does not set BL_CORE_SUSPENDRESUME so that part is a nop.

The driver may not set it now, but it is still not the same logic (and
unless I am missing something it would not generate the same code
either, so not sure I would say it is a "nop" in that sense).

But, yeah, I only meant to say that the commit message could be more
accurate (e.g. mention why the difference does not matter) -- that is
why I quoted the message instead of the code. Apologies if that was
unclear.

Cheers,
Miguel
