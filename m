Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D882F25F4
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Apr 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295162; cv=none; b=mkBn90i65gfzYyEePqL3JOn/fcVp06k8fVE9qAlj4DS/toTcSOakhXWpADxuFB2JTSPCk8Zyn8x7qma64pSIJOxDuISExFc1HrzhJThL0OgP/AyDdRubwYyZGUiFBeweYxbfS/DeI6Jt6LHVeX/CD8+YEcCSn+C71Ea7IrDdjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295162; c=relaxed/simple;
	bh=S4pqVnC7SrykP5CG0Cf7mf34BERu4m5QkSgWfBe5Qoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv709ILkK7C8bjmcsF00s5+5XARqxp2mmOrI7XaiXZ0UmcYZH5OmygRlIEaGhr/J3ozMZ1N6VaebGObahOYkrY7U1epCfeqSO8Me3Cm/Qc4WJ8zjagIOhals/KNMftA6Hbs0eMT6IaYi3XinpJWE3CjDy0/3Vgoiydy4ltrTV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/MWFHxm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/MWFHxm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so100229325e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Apr 2026 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777295159; x=1777899959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8iqGCzMLvZ/FUHTnqulEZ9CiBEz3wlFLR64nRtCLLQ=;
        b=S/MWFHxmiycuD3HU0EXzLIkC50oqSfh9RZXXPpjnGWIa5/zFuE5EbIpp3Sj820l6X/
         +cQUkoUYkXn48mw4z2KPJ5VXbjFZgyI2k404SYQRjnvFMp/PnPNbYnLYACmsQv3RMfHb
         l5oMqE7CAsIxfZvahOE/XbWt4pIBPKR1p5orA19BeR1PAhJ1kDbQW4CChsp+KekbCs4W
         1PZCNm6FxpUOivynK2MbzzEabO6KdFjCe4ARpwN/aMcJXddfLMLmK31PBCPe4pySVCgO
         omkEG+Hscn0lisPIQX6MZQng7vBpncOk5oPXG3HG6mhZgAIl8SboqQCwAajXAwv2q6LP
         lK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295159; x=1777899959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F8iqGCzMLvZ/FUHTnqulEZ9CiBEz3wlFLR64nRtCLLQ=;
        b=qGsCotG/tMlKRAc1jKv1PltHz4iCajDWjSop8neF9xlGF/Zmer7JMCyggnyR1wi562
         EqYLGtenEBdEPw5ZynCUWYlfiSzynWzgbg8Z3ld5WWL60EUccOEGeCrCaIU3KhRFplR0
         0BnFBh9OOzIkkNAt2kJdA8i6w8VOHxQ69e6L1tyb2V6eo4JmJ3zLO4opOn9jPMIw7sDj
         +SCQ6xBDC6MWc6nniNmhDiUMorJYjU4vUTfJ956UH7xkwWbu/7yAtSV7Z7AU4p5pi+Ze
         r+6QyLEdx5XBx1IGD2tqC+HpJS2QZtLuDtMMpywiA/tVE9GvEw/doCMC2N0duSzMQMAj
         3pJA==
X-Forwarded-Encrypted: i=1; AFNElJ+ixvvjVBZSIbqNl4uyARUHgyj3qNdJ5oaUNeI1Q5C8QUHCGxMXRvmyDeKNRxFzMbu0tR/1rEijrawLAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+aVdHMoog8gV9BMVo12aLxlmAcd1kpii7wzEluLOhyC9XocH
	q65yBWVxs3VgyOL7vZXQR983HDKzOP3Q90hq5WpYFOkg/E6yLtHCmV0s
X-Gm-Gg: AeBDietXTGl6BL79aM73tBxmHUL1llQG2/AjE62OLTgzgEDgEroKoVAwEi7CVtbVrO7
	SU9XRAZlA/l2W/U8hbLERZDMylZuK5y24vHfoI3lUCLt6piUIyAFFlX5ICtoFpi6XXFzR6AgKtD
	krcN33a4tiKO5hnwNAFWGrgJgYVoCguLlQXspLntUtXuim8dNhdNDenWB43eLPr4Tx2jLnRbXs0
	lWYLtxlVbaUTgYYeBXQdwhkgaMUppaZcGO5wd5A9cXN5tUWAvIXzN5COl4kAhgrYj9RQZhaiAzv
	c3Ve0A1QYET6elJlizpgk5jVbreJM+yAug5u025GAAadFSwPyBUJxPRZsLmvAI0wI1+N26FGuiL
	ROFmiegjcDds7c1DlCjNsXIsza9AReoZrg8rHFQnqglu/EODHpHMbUmFyI/gkhso7BXlIhKKmx2
	A/TBOkvlXoJrjUs2vKCqaEOwXgW80JwisX3SwZlRM6qbdlQdnVaesluAx60tBD5Ph0Gr65HMeVC
	D8=
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-488fb7930famr614025895e9.24.1777295159074;
        Mon, 27 Apr 2026 06:05:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75ab25sm247366475e9.11.2026.04.27.06.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:05:58 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:05:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ai Chao <aichao@kylinos.cn>
Cc: deller@gmx.de, nicolas.ferre@microchip.com,
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
Message-ID: <20260427140555.4d001050@pumpkin>
In-Reply-To: <20260427090910.1940231-1-aichao@kylinos.cn>
References: <20260427090910.1940231-1-aichao@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 17:09:10 +0800
Ai Chao <aichao@kylinos.cn> wrote:

> Hello David and Helge
> ...
> > > > -            strcpy(ivideo->myid, "SiS 730");
> > > > +            strscpy(ivideo->myid, "SiS 730");    
> > > 
> > > The compiler knows at build time the length of myid, and the "SIS 730" string.
> > > Using strscpy() has no benefit here either. Contrary, the code generated
> > > because of using strscpy() is probably even larger.
> > > Don't replace such code with strscpy().  
> 
> > Both should get converted to a memcpy().  
> 
> > If you increase the literal to be too long I'm pretty sure you'll
> > get a compiler warning/error from strcpy().
> > OTOH strscpy() is more likely to truncate the string (I'd need to
> > check).  
> 
> > So leaving it as strcpy() is fine - and possibly even better.
> > The header files might get changed to error strcpy() unless the compiler
> > knows the source string has a constant length and the destination is
> > big enough - but that hasn't been done yet.  
> 
> struct sis_video_info {
>     char    myid[40];
> }
> I have rewritten the code: 
> strcpy(ivideo->myid, "SiS 730-0123456789abcdefghijklmnopqrstuvwxyz0123456789");
> Used gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.3)
> There was no compiler warning or error. 
> The strcpy copies the entire string into myid(causing a buffer overflow),
> whereas strscpy only copies 40 characters into myid according to its size.

It depends on what is in string.h and the enabled warnings.
Testing on 'godbolt' gives an error with both gcc and clang without any
special compilation options.

The linux kernel build errors strcpy() at line 799 of fortify-string.h.
strscpy() doesn't (and really shouldn't) generate an error since it is
expected to truncate overlong strings.

Since you should (at least) test compile any patches before sending them
(even trivial ones) you ought to have things setup to have checked what
happens in a kernel build.
Ideally you should also run the code.

This really means that strcpy() is better than strscpy() for copying fixed
length strings into arrays.

	David

> 
> Thanks,
> Ai Chao
> 

