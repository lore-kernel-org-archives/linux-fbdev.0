Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4B31E82B
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Jul 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571531; cv=pass; b=TEESsoomynipEjwhTmIQNTC1MRuGIFyKRHu52WftN6LmZKY+1SDkykcZKUiQ4lcZaifoKrvcW6y7qRkx5xjzC9LcDDwG5TS1kL6YtLRqk9cLw36T1O9lUoX8opJJLkYj1WCLCjBT58QXA5RulDqovcKccSX9iNPCTiwiNK80X7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571531; c=relaxed/simple;
	bh=m/fEhPlmCHnFc5IcQj7KnWeRuvZDxbUo1KvQrDQOiYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NP1QGXokQJ1JIAR5RYtsnvIrqJlpDgGgOGspD1b1wBuwoX3xOua3f015i8CdLg+6LVfiz+AmCB5ZllFmkEbyUSxRhz3bJ/FXZn/XZkHiNJKwBdKw55CY56BC9c6/URfIZA4AdA3hn411QGNaSpX/N3ISNGWjpB3lxdBQXi3y6t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9qNjvjt; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9qNjvjt"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15d111ca99so1092466366b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jul 2026 11:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571528; cv=none;
        d=google.com; s=arc-20260327;
        b=QNVsELpRaSt7uAHw42gqWSXez96HJaXXL5VgHYTmnhAMM4BQfDDilBBJgoQXF8rEFn
         GxP7Rw44xqh+ErLipe2iLQ/Tc+lfA0aeybLph57ydk1/wIyeehPoc0TyLyNDz34NSzcP
         Jb2v/EEBOZHjLnhOMG6MD+9/3sQl6BzxiLLOZP9mzXB/2n0+RCx1VeAeEwCO9W12Qd+w
         1iHnEFohZucIL/m5o8twa0IfPbJnqp/ey6evGxl1vlWyFRqEu1Gv55lMY1wg72BFbI44
         WLFtHtJNuwsYG0QgqWm2KIQLvByXphmv1fMFjwByTWEeAYJ9UccYB/lgNk9MCqKnjikK
         aXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/fEhPlmCHnFc5IcQj7KnWeRuvZDxbUo1KvQrDQOiYs=;
        fh=O4hys2UmG66e9espZx8CNrNtqvq3AcVx1YUChUY34t4=;
        b=ddR6vxsUEE1DBMdwB8wK0MghbIY2G+U16bBAmdYut5uM6INV2daV2cowXt3z/oCXkK
         sn7T3TBdwWVQeBJtMwmwopdb9bCU0p3Cl6aUBFcZJR5GIr8R6C2+lKAac89zfWjYXMf4
         89CO5zVOPIBmcX8LEkGzQF5tpqvdV8RYeqGAS3KZLBNQJa5V2n6K/SSeYqqnSTf/J+fq
         5dpdQG74eoViye4svilnDtWFYBkLtoW9dCn4jJQlOLuBiXQUdHJIEUidh7MvPIL4tMzr
         4OdFKXqoD2RrM9ez6CHBKplVWnx+yjCDzmh7v5zreR7wteW47MvtuqX3525UjOKw7pFU
         38BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784571528; x=1785176328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m/fEhPlmCHnFc5IcQj7KnWeRuvZDxbUo1KvQrDQOiYs=;
        b=O9qNjvjtNfYF2g1UYtN6s08OlJSHq+QoG/MQEEMIIUUC0rlJ0BTFdhEAWNudyfmKFH
         01HDPP1raoGDLInTC5dCola65zY9UvNVvjcO8Xkm++gxeAD2dS2QrGfuQofiuv+DLdgV
         ovsS8I7Fvi+AMPLaT8UuB+OIYfAT9MdC9APqDbfeKhv8s/S/HppD7QFXKCJ2QBZ0dW8j
         9yajOvb0qt9fqo9IKMjxUpMJxrlKji9WtL3XsxxhdDwCt1jAT/CSnVQDBL2IFjUdiT0Y
         sDhJgVDNCwGQUUJs6i0kZe1sjixp/P45QLCEY780SM1+QF7LJ7Tm2DlESt+LqevYyS44
         l0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571528; x=1785176328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/fEhPlmCHnFc5IcQj7KnWeRuvZDxbUo1KvQrDQOiYs=;
        b=V5L8XyyR4CtAKDGF37Ku8hCcscG4Z6nBs3hTb5YX7sHj9xISdZ/gKsvsCFxjUm7Pn1
         SpPlidArS42o6i4iRSYqWPr3A6DzHOlSGenY84Xhh4pfeVOziAmyoftj1SDvrJvJJzg8
         MO/60ZrbICKmttIgSdsK6tje3HumkPCgDMILucA2gzJVcTdjxf/i5TYan5hUce5H/t1q
         hsayHQ3GIdfEEcTR+dUOehwDhry0lDuhCrKMkTLJdmzUNnAcS2Rv9sf7dghGgXGHeRkw
         aip61hM9phrnPuqDGk9efjtxVO9ru5V5L5gSa7b9JqRl/0XKv0mKzug6AWcNHMyURbNM
         aUAA==
X-Forwarded-Encrypted: i=1; AHgh+RoD4wQWSx/JK9FILRul0zw52A8+zGKcYPD/5luTTAy245VkhpF9bun3+EO91ngIeNVWmUMB+q3T9EMdeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXx0w5dA4bT87Nxq3XQhAfI80aeev6ehgRQBb0LKDFJQ0b9Fha
	OWJZS8FUIzSihS6XYXKECk32q0aJXsaRAXad53wH5zjKman2bmaqk2wGZ0/V9THyhblf898/YnY
	7F3LXTJPjvmaaJ3u8odXzav8v8iYhaqo=
X-Gm-Gg: AfdE7cnoU3HnHY1idquLZ8LNbwBZTH0YgS3VPl24SsQtDN8kRajZANzM3OHP6FtNoCi
	0E3XMDWywq7LhbYLt0jTS7t8o4U+Y78VBko9AMGmPA+4KWQAhxFv+93hCzGuljenYa3r3tNrEsK
	/fHMJOPKrQnCIxYjNUmHz2VARIABLH/ZyoXJHRmDwud9JNGdtsqsBa82KmoVwzRA/TWqVuDZl8D
	IKYYLpEKzXLJw76Yu/ZPlqwGr8/LtfS04DM6vv477nBOmYEG0fC8g/PZrPzLePS3AbMPCZMiIdc
	1RPJ/cyHmtS32fDrcUMKpRW0oo/7F4+OQXi7R5Km0Klm3dqsjBWq2Sv7urpJgApoowaIww9+MnQ
	kl1nauZiaKYvDY8Rto5N5/a5r0gxAcdXhcBr/6JTi7XXFzQg=
X-Received: by 2002:a17:907:e90:b0:c16:209f:d48e with SMTP id
 a640c23a62f3a-c16b477c680mr647988866b.30.1784571527740; Mon, 20 Jul 2026
 11:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720134324.239391-1-panchuang@vivo.com> <20260720134324.239391-3-panchuang@vivo.com>
In-Reply-To: <20260720134324.239391-3-panchuang@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Jul 2026 21:18:11 +0300
X-Gm-Features: AUfX_mwTy2WT6DYuON66_1rgaXEdx6DQ_MN_MwvGATimw2bJv2PLyRfTTwQNNyM
Message-ID: <CAHp75Vfu7tuGsH0MS12dwSn0uAWJsfuJtTWzG=TztU08i6oQfg@mail.gmail.com>
Subject: Re: [PATCH 2/7] staging: fbtft: Remove redundant dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"open list:FBTFT Framebuffer drivers" <dri-devel@lists.freedesktop.org>, 
	"open list:FBTFT Framebuffer drivers" <linux-fbdev@vger.kernel.org>, 
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 4:44=E2=80=AFPM Pan Chuang <panchuang@vivo.com> wro=
te:
>
> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"=
),
> devm_request_irq() automatically logs detailed error messages on
> failure. Remove the now-redundant driver-specific dev_err_probe() calls.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
