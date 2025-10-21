Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DF252906
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Oct 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036650; cv=none; b=bbVGGJ1d76YgoMbxU74zDrxSTipmsTHIixgJrhcbl3wU07W+ZoJ0tzPBXXgezH90cGjkYf1GebsATy+EB+o6vr3JkPf6i9xDPMVcd7PF6JSI3VgK+NUYipkmAzA9xNcTmjvBzGb8t5UiQHBeojBLdStipW2XzqlLHopgkjfmEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036650; c=relaxed/simple;
	bh=YYGwKIw4DU78XjYwaYwxke2dNDi4SH+1u4WyDiQEDQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTUuifWE4wwrckva99tAFYScMIynqgfvm71B2xhjNGiATqK7i8CmjfoEFmWI03dxAcuedBE2+6IWAcRilC827rMz7ZT8BHiJuOlKNiW/dParua3NziHLtZSRB5OgBBFIrpAXyjxLJI6qGCeKi+B+cTa7i+1mNMXvbFBC8aaFt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exNdML0O; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exNdML0O"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5e19810703so880581666b.2
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Oct 2025 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761036647; x=1761641447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3LdkJEpXUwO+NWSEZVny0C0q696Pa6fK5D8TjFSc4w=;
        b=exNdML0OPXuIqL5e6eBhFDWo1OgUzlX+BD755VQARhdlIH+4Z/yM9D7x48MY6N5dWv
         W9pmcjas3RYwT12Bi2yFaawqvC+oS42k4ehaP2mbTjvhJbHtmLrxmVrgIEVHH7C8QB1o
         ilRZ31H85bDTblvONh5GG6ZjIFd1LhbAxRfuAQYjgsh3XZuHZVrVGh+gjuJDfF+WVZGu
         pzY2kOFTiqkf+OgUCC80kTckEAUdE50YH4Fc07YBEfLB1JOEIWKJTIw/tZFSZO5bJlHb
         szN4IXbjbBIlhTxdNvHfsC1jlSmWDSgCfUaavnCDhupYwxKhKF+i/+YZVkc6JbE4Ysg+
         5QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036647; x=1761641447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3LdkJEpXUwO+NWSEZVny0C0q696Pa6fK5D8TjFSc4w=;
        b=XIXlHJwWnzkOS0FdfaC/+euU1q6pDJdqEnJLAgOjQ/ppxIOLSAFstUYtqb3L514QNM
         AwRyzkci0mXc9ORE+zHEgdkRi/A3FuJ7grcmcjSGe+XiarTXPybOkJxDJ+qnfli8UMZd
         PKte4ga/rZ25D69O/scTr6MJpY+9DAH0g9Ni7eXY9l5bfy5cD1Lmztv/8lasiEKKQKt3
         Z8ZOPLNmFoQeonyvDgHsP6i5hNx1OHvy8lyM2MmJRgQWk2z49LYGmmdivDQ+zFDdZKR3
         9sE9X5Vhbf5df1KtTnIuilQwlUq98hm6g0boFfMPBqMuMwLmzSbRZJJti5f1zRX0Vomz
         +T6A==
X-Forwarded-Encrypted: i=1; AJvYcCU32xLtQ1QQLWrxTW/kyqqZYP+fHPhfbPyeqaVOKQLD2HA57nLNf9YWtMEa95OXFtduTLWodXkiHR7Z9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5Vog9tBXMHSsmnRiaMzqsbKmCIMI+59Tba/1KBUcBqjv2hdC
	Lt7eS3fwUI3BbGqRin5jNnTKdEmsuAe0ILn5wpxPNkGTqhZ+qJLoUPvyK5n11oYx6DyQtdgsDny
	H3cC7XnaGI2a+4QktqID1YA/TXkIE56M=
X-Gm-Gg: ASbGncu7qpW/6FeH0UGaOMhaP18GaifhoG4+3rx7h/Ou65k4oEVYP9gP7gTlu58WdnL
	9VZg+cHgoYFuHkS2G5sbjov+91Q/++jweGrrpupAl0LEmqsy5oFya/kxTI+Z1Atbik2R/f8Weea
	ko7J91RfLlrwh1JrPDl0U34CL+2FryIrwJBdiWWJWrTBZk2NPyta1UgnUeotY9ahust3HdisAUH
	bxHbkufBCLKpnhe1qtoeDQDpfZT6zEUj9Hw8S9H+KfbCqkWPI8yslqmrfJPbQ==
X-Google-Smtp-Source: AGHT+IHBY2IUN83Pw2ENBSOgJpr4Jc1uqt5wNDK5R+8Ap8x+c1BNaeQ/FRba66e2cv8DRUxHfZF+WnI79kMwhHazwpc=
X-Received: by 2002:a17:907:c11:b0:b46:897b:d759 with SMTP id
 a640c23a62f3a-b647443b9c2mr1867846866b.40.1761036647265; Tue, 21 Oct 2025
 01:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>
In-Reply-To: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 21 Oct 2025 11:50:11 +0300
X-Gm-Features: AS18NWBqAmjo3KOZJeoj3rpQJcbhQ65NoVyhN4fDfDmM2riHc6TQ9QZuK7Sh_wM
Message-ID: <CAHp75VeWGAyzAFBYSQS7FGpU1eSRo1Egrh44hUpXJgYZhFEkwg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with usleep_range
To: Olle Lukowski <olle@lukowski.dev>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:16=E2=80=AFPM Olle Lukowski <olle@lukowski.dev> =
wrote:
>
> Replace udelay(100) calls with usleep_range(100, 200) to allow the
> scheduler to yield instead of busy-waiting. This is the preferred API for
> sleep durations above 10 microseconds.

...

> -       udelay(100);
> +       usleep_range(100, 200);

Besides what Greg said, the function in similar changes should be
fsleep(), it will automatically choose the best low-level API for the
given delay.

--=20
With Best Regards,
Andy Shevchenko
