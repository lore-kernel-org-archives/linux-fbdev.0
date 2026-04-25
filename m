Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018C4315A
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Apr 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114961; cv=none; b=B2FbwhDvetP6mGugpoQ7JflnxRYbDebsgyRa+tHmUkDksiw1kfXO6np7dlkXD6hJ/WCGDd5/0qVaefpaqOu5fNTDZtr/kziIUujykRRuuY7IsKqSR95HQgS3VnHLEWf/o1XPHc1Nwh+PX92YNyCP+Upz8sJcEcj/HrmeLSwDmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114961; c=relaxed/simple;
	bh=0Hl10w3oRmON33yMhRyufkLV9NZ+ydMT1q3LCnmE5nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kz6quqPFoR1Iy3iYoxy/k4QtK/SKzNIm8EPc37nGO9Z+R0ifS1K9jzJL4JTcMYMO1CE6luAx/x6h6A6uJY9igIIVSJYZk4XlSgkAJJCuEwFGoByyLUzONS8Lx51UFCMmptOZtdi58ABZ+RChX4/WCgaT7ZHZIo915FB/b4Lr/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHSxUDCv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHSxUDCv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso86448785e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Apr 2026 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777114958; x=1777719758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krEC5W4u3Zy98qJoM/+vZPkJBJL5qw1cHHHERcq1ubA=;
        b=OHSxUDCvZ+gQMXs1YhXZbN1B7B2fvk5rJAotUytKyfo88p/k3L/DoOA7tONqrbh3OB
         KhAcnj1Apq7wmkFgcXRKfz13uE/FwrkcMborqmq9NSr9EpyNiHXHQr9Fc0Smfstma6u4
         2h7iGB+D4EaZR3lpyv9PTlEFbvFDogEA9YcpQaz6VpJSEGZhJX7/tbZ7jf1vQDrSShBV
         CoaBYxnJymcljIbwUQRxHB0R1PCwzMUukitwEuBVTGEdhOe/Rj0WRcmFrBNl/ONxXPV5
         +S1lo0boaJenWRLz0pDnvfBIzI+KpcD9iZiYFpHWp9DVMRU5U3/g56AT0l7Cn/xkliOG
         0SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777114958; x=1777719758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krEC5W4u3Zy98qJoM/+vZPkJBJL5qw1cHHHERcq1ubA=;
        b=rsdc5Q6jC1MbNVgOoSmfsDTnDnNU/ru1H7qVb/p4IFy3+Sr6pIHa7gGxdjvl/1sMfn
         c+oUgkNdkZWdl5U1yxkPdn6QesScuPav6AJtxvr1Az0N9A/px3yJvC+fQo2YiCw+ivSM
         rHjgWDzn5dxAlC8hrGLSkZIryW7zHsOIn/Wc5MLZ9sOxXL+jFTGjt7WiSCZb8GMiX7xD
         EvX4Bujs+N5TPFPprNfsPGN3v2POFnj2bsyD6rRvGaDVKY3DGT6YgoPCKHrppo/Fknjy
         dEb1PKt7DCTPn+UOlsc4upQig0w/RjVJK9FDJBLFOCz/n8jqXY0ieqAixHtmMXg127Tu
         Dh3w==
X-Forwarded-Encrypted: i=1; AFNElJ8LJFHgzHCjKS6UlMd+b7jKw3UI0fJsYF3Q0uzdh0TjaJR3iqj0UOMvdri0uIwrP3M4uZX7vPOGRlQP8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0stYsSi4zLgCyHj0GoIHHooDxtH9QmHb7U8FiAE3W1x1T2xq
	Kh0FTEBfAkEHhj8qNjKDj0jwF3Ygcqdi3D75GnRsUSx8CL4+463sZZ/e
X-Gm-Gg: AeBDietE74Tn6+46j0V8dzbmPxiZul5df8tbCtI61YZJ8yz1dC70QobH/RIuPvXnAOO
	ck/bJ2U+Rf5B3IL67n1wnvJxZVQ4pNoPtD+gq6d2DrSWT6BDIpLETk/1mgcX188QxWPPM0MX1Ws
	KEEtzlUKwJ24gD6oPd2lo9yHgWRoJ1Mumoh+5Pc0cwsQQuWowGIXyzUYkEV3PuVJCymWknrq/ld
	jvMzc7GLMgstiERtZR3WHw/BvMhyO2Rw/eFMLaAr9MTsbUePg8QPvM2e0AMRuS5jMdSWhhuh+Em
	OOjfQiJvxiZGJatuB9a1T8pmtteW7f4IKdpC/hC/X4dnIVzOJROm6ma+Q459XfWwMSE9FEKawT9
	LUirxYsxOv4OVjBKXny7O5djOTLGZSat/Pmd4pejXjq1oAu76h6xVAe67GvMpqt36Y+wcybTjHn
	1LIvw3aIaMyAddIBPiT4MvDqmq/beMpZP0xShKF4ffHHEUAseBAL32vPhSZ2tUddVxE73ubG5E7
	85vXKcPTPcoTw==
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a53390f6cmr295415295e9.9.1777114957837;
        Sat, 25 Apr 2026 04:02:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb77b001sm312125075e9.3.2026.04.25.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 04:02:37 -0700 (PDT)
Date: Sat, 25 Apr 2026 12:02:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Ai Chao <aichao@kylinos.cn>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux@armlinux.org.uk, dilinger@queued.net, adaplas@gmail.com,
 James.Bottomley@HansenPartnership.com, FlorianSchandinat@gmx.de,
 alchark@gmail.com, krzk@kernel.org, kees@kernel.org, rene@exactco.de,
 tzimmermann@suse.de, rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-geode@lists.infradead.org,
 linux-parisc@vger.kernel.org
Subject: Re: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of
 strcpy()
Message-ID: <20260425120235.2ec10089@pumpkin>
In-Reply-To: <ccd01f97-d4b7-4bd0-92c1-adc3b1136cbc@gmx.de>
References: <20260425065926.1091168-1-aichao@kylinos.cn>
	<20260425065926.1091168-4-aichao@kylinos.cn>
	<ccd01f97-d4b7-4bd0-92c1-adc3b1136cbc@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 10:08:08 +0200
Helge Deller <deller@gmx.de> wrote:

> Hello Ai,
...
> > -			strcpy(ivideo->myid, "SiS 730");
> > +			strscpy(ivideo->myid, "SiS 730");  
> 
> The compiler knows at build time the length of myid, and the "SIS 730" string.
> Using strscpy() has no benefit here either. Contrary, the code generated
> because of using strscpy() is probably even larger.
> Don't replace such code with strscpy().

Both should get converted to a memcpy().

If you increase the literal to be too long I'm pretty sure you'll
get a compiler warning/error from strcpy().
OTOH strscpy() is more likely to truncate the string (I'd need to
check).

So leaving it as strcpy() is fine - and possibly even better.
The header files might get changed to error strcpy() unless the compiler
knows the source string has a constant length and the destination is
big enough - but that hasn't been done yet.

	David
 

