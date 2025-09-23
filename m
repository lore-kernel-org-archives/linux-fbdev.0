Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1C257437
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643397; cv=none; b=uvIuFrtxfwo2tAF7A28DgTtwB8HOWjtmzLFkXn5rFvVfMJGQu4Yjn52npjdagqtAdHuxP8SN8oqgL982NmGqsOLp/2cPw28wNVgSKKqDK3AaCrzQJ1wfIIFSLqv1a7dkSQ+i9HVPntU1CeITlGtGr7UrETEjPU1jrg8GysKBhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643397; c=relaxed/simple;
	bh=+eCklkEo4Dd5/86Fex5KOYIdlbYxcz9vSH+N6Bhs0v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro6WNSWBIpaYg6nA9l1IcfRXyWKs+7wMQiqZ7OM78DzxVADphU9msO368IJENHrJ6uJW+sy4sUxr6pwKWkMeXeWDxSzxKYEd577HyeR1t+i8adlYEuTieXuXKzTluGgYxUKoIOExWkr9O/C280UMFCil6RaF7hm/hEWHP9t5LYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Dr6a2p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Dr6a2p"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-267fad019d4so12335025ad.3
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643394; x=1759248194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2ROfUbxr/KN7oAi0rJA/6LeNf8GF4G0Z/s0Uz4C+7I=;
        b=A0Dr6a2pjBftbkzQl7rGy3HsyD/T6Yv684SAy8YMhxC+ulMAJHeoodfcw2YzdzA8Xy
         xwl7X8GVSVpkcmq4y6mU5ypg/IMNvjQdEWWNpA8UcSidn4Flg9+EFbBEzQTH8qAhFDDZ
         W9STtdzRW5cEabf6Me9orDlu4B0BcNQLOOnetZteYCVx6PdbCIHaSuDzmsQQYx2a9U4v
         Huk9t7wrUfZrkEohDiAVkkdlKx1YitvydMLg4Mmwd4wIWSsuFVuXgWdR4g/AlyXXXiAd
         uakXeYW7kHqsTkgFGIgS0F/hnhaE+GdXseDM/nuBO4lrKsx7/PyZEBGlUnH7ZD/47QQT
         3LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643394; x=1759248194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2ROfUbxr/KN7oAi0rJA/6LeNf8GF4G0Z/s0Uz4C+7I=;
        b=WiDLG2FlOZq4DXNh1yxbyRsaZm1K9FrokPDZd62zjf74HlhSefCs87KI/wqwNNznY+
         hQCtjl9e3mxDXgRHyXMBQd52SbiDS5W2Fa7YxNqEDIJ/L0r/R6ksmm02vqlOQW2e2CGb
         XwClp8VhUF2NEs1NeSHKGJfTS0YFRAOwrk6sGzbnEZ/P3IfN36GJa0KhoG8ko36Q6TdY
         p/KGICi8NWH0o43M5wUUh8NqZ7tu190vlgUYMJrYvIyTUCNG1sJ6huRJoRmRi2wkpvaI
         vLG9NZDPFlKVPZP5Hn6674zN6ATKMfc2lgdfAjV8pnMKVHCJbf0zEFveXpckUj7p79kk
         42BA==
X-Forwarded-Encrypted: i=1; AJvYcCUUdfqPmJFdrhR0jaXrJOcXPw/S3f4AtGmiygswHDibq7BDmKHS8YrmXblK6z2hR/C6EFyXZYoBM7l9yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FRMIZ1teTx58peNwLZF3eHWtZf07Lll+9Q+iA920uEjZ6Xhh
	CkIggE2CpD0sVPC10kEsYtTTkFBuxy0Xfduwk25kh09zAUUaSE3E9E6oFxSZZgrcPGzbuGLXBd4
	QtxyNmiF5V6qgrf0MeZtLwXUE1xbtjeI=
X-Gm-Gg: ASbGnctx/66sRcndk3iqO8FeKjih+Lzc+EEGVULGo8f3N35CSgyoT67xb1TKgjr03o7
	Bm4NdK4WPDW3Ysl7pWk5AYSC1Oo+KlHMrvJmsBnOXHxwUCSepX6DjCVbE9j+vLD9rUtPYo7veH4
	L9pHEh/8f8Y1V5l8hTyZSr9ehLo8/RroamP9ZwYMjF81TuTSfcorDS0hsEvKZz1Vk+f0h8RLLzd
	Qt7QDA=
X-Google-Smtp-Source: AGHT+IGBbiHkgD0/2labtH1NeFTzXLVqipenHtdKCLOlRtkUCqCDTMEK1XiJMTv9TX8U0v9Y4TZdy6Zkg1xfbYYFpBI=
X-Received: by 2002:a17:902:b695:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-27cc712154dmr18207895ad.6.1758643394109; Tue, 23 Sep 2025
 09:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923084157.11582-1-hsukrut3@gmail.com> <9fe75192-9260-44f7-8f13-e024e2bbd731@suse.de>
In-Reply-To: <9fe75192-9260-44f7-8f13-e024e2bbd731@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Sep 2025 12:03:02 -0400
X-Gm-Features: AS18NWDnCIuE4uDg0qpAn-RzVENplvgl1AQzC-tA5opkGWF7-LN_yd6zTJ3mypY
Message-ID: <CADnq5_NHu5=esJZrgy_S80jF68ZapRRYX4_L70DwDDSN3VXitQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev/radeon: Update stale product link in Kconfig/FB_RADEON
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sukrut Heroorkar <hsukrut3@gmail.com>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, 
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:29=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Hi
>
> Am 23.09.25 um 10:41 schrieb Sukrut Heroorkar:
> > The previous Radeon product page link was no longer valid. Repalce
> > it with the current working link.
> >
> > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> > ---
> >   drivers/video/fbdev/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index c21484d15f0c..3037455adf48 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -949,7 +949,7 @@ config FB_RADEON
> >         don't need to choose this to run the Radeon in plain VGA mode.
> >
> >         There is a product page at
> > -       https://products.amd.com/en-us/GraphicCardResult.aspx
> > +       https://www.amd.com/en/products/specifications/graphics.html
>
> May I suggest to remove this URL entirely?

Yes, agreed.  I doubt any of the chips listed there actually work with rade=
onfb.

Alex

>
> Best regards
> Thomas
>
> >
> >   config FB_RADEON_I2C
> >       bool "DDC/I2C for ATI Radeon support"
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>
>
