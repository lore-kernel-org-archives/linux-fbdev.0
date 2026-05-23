Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84817280309
	for <linux-fbdev@vger.kernel.org>; Sat, 23 May 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553607; cv=none; b=L5aCIorsWsMFvuzGpFaRy0UXFxHIvFnykRzxo8UOnS4Yjb9pNKzj6P5e5o8E5WTKPaLaTZdHGUbYqrFBxoYLJE/PI2KK9Wk0hVEX1i6co1IaOnSV2gRqctr4HzKV9Vx93a5jq+BSl3V9+6QrK+HtisVnUAiur45DrbJIA20jZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553607; c=relaxed/simple;
	bh=QXh1CChDjH8ohddaaQ6/VxWgyIzHHlocmmkcYT/MH4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJrU0MU5kpNmk8mKjdz9/Qm11qugP32sMckegSE4oGOKupaeFwTOMHgt9N/feUnNXS923aEHn9K+GHgmqzjG3nibXonQzvAPS5GLs9gAQfVHeVEmJLRZuZB4j7pTa6my5ELipTk+abbF8z30WY/o/I1jM+ARUxdCpsXgGvqlqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IExKACdK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IExKACdK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7645adbdso5520186f8f.1
        for <linux-fbdev@vger.kernel.org>; Sat, 23 May 2026 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779553605; x=1780158405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS7AaSnvi+8g347V46yumsct/iLL/yBRgoDzhYZ24Ng=;
        b=IExKACdKWijmS1u1Uc8rLyXonH6jew1tL7nsr7qmVWeK8I9/QiHxEa0ccRbfgIF2NW
         cgECGjLLdPxB9fG4QILCP5KHUd5S6udxCYHUdpiuFkXr/TArnBdnYIIjFlPwv5o3x5hx
         yqjPVEk6WVBGAQ2h1+NsuxrIQk+/LTGR83BeBynj/JvWAowoH9l1FQPNRhaveqrpBrAd
         GcxkfJGvBj3HG1Qr3Fr0UCKlnxsNU6nM4yWCHaz8ZK+Y87Fz+5fAedAcUM+gm5cX0tM5
         AZ6U7APiHSB1WnlIg6FBBkMODyHiMm9tUk9khzRHvmjpGtKpsb0e4S4U7eq0m8Rz5Qub
         YIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779553605; x=1780158405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hS7AaSnvi+8g347V46yumsct/iLL/yBRgoDzhYZ24Ng=;
        b=oeEL80Pxr5X+RqoOFkXrE1ZBMepcg9BX+BhJGvkfxw6KWzESYFneXmwb2pmNb1PGEh
         FlxlvsAD4WxLjCL1FWNUFFAQ0QkVHXyejP1ZVTQ51pSFijq5g8i5JFUukY5dcMLRhIBV
         HcVQhN5LJ7naOQMrPH5uzhwhooK9BduFKpOe67+BvFlMconTifHy06bk9W6XTrVwi+no
         U4UTX/QJF2r2xjtkH4WDr1yl7iTHy4QDMuP2aa+UaAVrPz27j2UapUXPabf2wXQ+i+or
         LeSNPqxIOUD0OfGtOFSXWlNaVdR8lcBvM8U+1J7GrEGCHL495BoqQXNr13XlCKbVwSzU
         UqUg==
X-Forwarded-Encrypted: i=1; AFNElJ9Zr17z7TDuAag3pj5QmSyDN/BuOdAde6g5DRKgK+VwC9il5tYZ0C5uVVxv+tKU/GYWr30WyAElNjOG+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9z2/ibJFSJQa1QYbEboavt6PE/LBmUCncqrkbo3ed4p/emLw
	daiuxIo/yZ8ckVx/jeOMTZ6PuyMqgv43EMlso5q2Jw7rxmTYfdPk1Gqe
X-Gm-Gg: Acq92OE3Ak9kEnUf+pym0h7QKI8On/g5C/YwQhxoEj1BCl4nLL9jw/8G1tUH98nuFL3
	OB5vqdUmfmyhXLKXDADKAjl+0+Tw+OnQ4dMGPnbhPz4h+tWI4brkKmBlNjStAqP/bP6xD69cAIZ
	ahd5J4FjzRu25VrZzM+C7C3odWX8ep8AkqPAu4PDdOBGDf/aajr7x8yQgeCV0/Dvw0hQz2DHVcp
	++n5yNY8lY+K7djhNhvciFVXB+ecudm6Ue0bQd+oFFB+QO0JEHSZzQA/whQUyakt3av739CxXmD
	QrKjuSpU/auz5aWVQwgN657qaUH56FTOmoRtzjza2GWPqlC7BrDNZeEO+LOyIHFDg97y182Uau1
	cbMXCg/MMBAiBl/FFttEI/cgpPwaWNJv1D+wq9oLpxi2kUUByrmuVb9qGUQeumvHnkE4SNFDlvJ
	vNNCc8jF38TBEjmVJpGtdQ4AQxbeu+15eqqD+ghe2uihNUZonLfiRPKoPWJr18sbds
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-490426cefe0mr95618465e9.18.1779553604681;
        Sat, 23 May 2026 09:26:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm136093835e9.2.2026.05.23.09.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:26:44 -0700 (PDT)
Date: Sat, 23 May 2026 17:26:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Ahmet Sezgin Duran <ahmet@sezginduran.net>, gregkh@linuxfoundation.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: sm750fb: use ARRAY_SIZE macro in
 fb_find_mode loop
Message-ID: <20260523172643.1dbcafb2@pumpkin>
In-Reply-To: <ahF8dacOkX0tdxGf@stanley.mountain>
References: <20260523051509.166152-1-ahmet@sezginduran.net>
	<20260523051509.166152-5-ahmet@sezginduran.net>
	<ahF8dacOkX0tdxGf@stanley.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 13:07:49 +0300
Dan Carpenter <error27@gmail.com> wrote:

> On Sat, May 23, 2026 at 05:15:08AM +0000, Ahmet Sezgin Duran wrote:
> > The loop in lynxfb_set_fbinfo() iterates over pdb[] and cdb[] using
> > a hardcoded bound of 3.
> > 
> > Replace it with ARRAY_SIZE(pdb) so the bound tracks the array.  
> 
> I don't love this.  As you mentioned, there are two arrays and they
> both have 3 elements.  Why prefer one over the other?  This patch
> makes the code look simpler than it really is.  I would just leave
> it as 3.

Or change the code to have one array of a struct that contains the ptr:count
pair and iterate over that.
Both pdb[] and cdb[] (or what replaces them) should (probably) be static.

This interface is strange, the NULL:0 requests the modes from xfree86
(which aren't visible) whereas the vesa modes that are defined just
after them have to be requested by ptr:count,

-- David


> 
> regards,
> dan carpenter
> 
> 

