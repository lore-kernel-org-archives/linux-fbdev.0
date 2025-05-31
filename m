Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9321ACE0C
	for <linux-fbdev@vger.kernel.org>; Sat, 31 May 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748727981; cv=none; b=MdOoqUPfHv8ovq1UltjCetg9nHwmfeQ9ZT5VBjlNzuT0/C9PhO/4LI1bkUijGivIL/W0Jr42f1OfS7H26YAmoLF2RuQXJ5fO14ml5kQ02eiYWWcy/HnQyVg03l8OCa4PEdN50S2WK2xLZBpgdfLv2jjFggdr17pTRiQw0z4aVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748727981; c=relaxed/simple;
	bh=GEXUM8bFiY2XVaUGrrwbZv1dyw6k5nc9Z0n6pZQoa8w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ic7OsKHKz16Cnl2MASolO/0TlFqgQ8cIMfisUz3DWggmrOzRDDwERxUjiqZp8BQJWA+rrtIod8kOLSPoD+QFsKjMZu6LCcz2YyH1yC4puRP+y8GncsTJgSpjRypDj0IIvTn8l8G0N+oMY+GDZlBYcDM0p3DXdEWnGEv+XawwLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRGc75wD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRGc75wD"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6facba680a1so31029036d6.3
        for <linux-fbdev@vger.kernel.org>; Sat, 31 May 2025 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748727979; x=1749332779; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2xDO5CRbQ5TrevmjaImNogri6wZK1hThE5EiKgWG/Q=;
        b=NRGc75wDLqTQTdIMLWCOl+XexQFdo9nEr5Tm0FL0lbMV67+npTp2Zi9k0VA8BMcXZ/
         IQO4KqNEqg5SCeNAx854+P0gHgjGWfa3YdB6lmgZ8+YGqcs/gUe54U58dtQ3rR8n0+g/
         RNk0xTm1tu2/e2KlcvSF0YJ8ijB//+Vz43pmxSqaMGC1Avz0xXAiXJvtUrJAgAqEcnxn
         4wZYzXb683kXSIdWtRCsCA2XIayxQJMh8zmpd4arCDYoE1hCN6gPmMES9FSwKXyv1k1A
         8KJ5h4VLbwi92u4u6mfciBQXLbtaChAhvMhiIkDHla11t3mKaRM9jAAHG09AgOpWRBOz
         O+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748727979; x=1749332779;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2xDO5CRbQ5TrevmjaImNogri6wZK1hThE5EiKgWG/Q=;
        b=lBI1Ki2EMm0Ebwm82cgPl9ayvzXC5hGWtSnxDfrXNbzjHkzTY10+FeIeIfClBMDHmV
         xRHPnU/SzovWc/phGfNxGGS8lflg38FC/9hRlx9Z+U7Wo/HqeHNEIhZHGRcWMfJf+hvH
         Z37ZVcIqBOdEvM+YFc8lHTJEjFW5G8WkDUzLmeAhzNGuLlrWyLRVi6BqXQZHobB32176
         l5+OzWGEOWD1qaPYchze7rfEIKe0CZ1ZyzzeRwFFeInscmDIeqjghirUh12wnwpZk3Km
         sOeH2fPMwF9zzrhhHv0dQBeiP7Ts1uzUSDVSwJTr3I66B3glQedwyxs8d5ObA7MDmkhK
         5iLg==
X-Gm-Message-State: AOJu0Yw5gc8M4noGdM/H+eogbLbBTHF+CKa4semui/AOH9ovf9+/FWr7
	vNcsZifKyoBm/xDthD/iB+CW+SAMhP8Q1fe+RH2BheVPyunTj12JwCsuU/njVg==
X-Gm-Gg: ASbGncuidW+J4ED5zUNdKcCQKHjFpFGn3lKuDh1PfTNa1ECsHtILLiaEs6BlxZ/I6us
	xpfiGs1B3dg1a7gJ4iqtpWtwLHEdJhCSGi3GDhXrOQ6QOpz8Oo+5kHkaE8a5Mcf/K/TEjFvUXvt
	+Pezlxy0KGH01Nat9M7E+hX4K0oqJOViqYQMsjjUxSFbd9jf9CovK4tUnMKLJjfRavyhk0ka8r/
	wMyXyG8T4zfXEHs0ekW5fLT1yr7dJK42dltOk0xNt7+FLCbIKXY/5e4p2qyCHClZtJ1KoN61GbO
	DKFqiBf+Tlv4GT9gyq+iyVb7siNkWMBLbZodU2WCm78OeQQda2DkjBYdexofAUwoW3bK0o6g/Tj
	lhNHRq2IVF+V542lU5T1Q+VVU
X-Google-Smtp-Source: AGHT+IFFDlylPTScOqrSgzj5Jkpt4E6q0iEH7rxtHJAwtH2kZ50snZ01kyVJlqgM5rVJw0LCi7jyHg==
X-Received: by 2002:a05:6214:4114:b0:6fa:cb58:10b7 with SMTP id 6a1803df08f44-6fad913c2d1mr49829716d6.26.1748727978826;
        Sat, 31 May 2025 14:46:18 -0700 (PDT)
Received: from thinkpad (ip-74-215-254-164.dynamic.fuse.net. [74.215.254.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d33ad8sm41014356d6.9.2025.05.31.14.46.18
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 14:46:18 -0700 (PDT)
Date: Sat, 31 May 2025 17:46:17 -0400
From: Adam Stylinski <kungfujesus06@gmail.com>
To: linux-fbdev@vger.kernel.org
Subject: Issues with vgacon with kernels >= 6.13
Message-ID: <aDt4pp9NE85BuAec@thinkpad>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

I apologize in advance if this is the wrong tree to be barking up but I'm hitting a wall on this and I'm hoping someone on this ML can point me in the right direction.  Ever since kernel 6.13 (I've not yet bisected but that may be my next step) I've been unable to get my potato system booting up via the any of the simple framebuffer consoles.  The kernel simply hangs right after loading the disk IO schedulers (which, looking at my dmesg logs from 6.12 is _just_ before the vga framebuffer is supposed to take over).  The system is definitely in the realm of antique, with a Core 2 Quad Q9650 and a pre EFI boot stage. I've tried simplefb set as the default console, I've tried vesafb, and I've tried vga=normal, all of these seem to fail just before the GPU handoff.

The major change I do see around 6.13 was a change to support the DRM friendly panic message and I'm tempted to maybe think that's where the regression lives. I also realize I may be one of maybe 6 people affected by this by keeping this system limping along, but I do use it regularly to test SIMD related performance, as it's the last CPU family in Intel's line that actually has the unaligned load penalty.

This is the last kernel message I see prior to boot (hopefully LKML doesn't flag me for adding a URL, but I figured attaching an image would be worse):
https://imgur.com/a/3QkVs2O

Does anyone know of any major changes that might have caused this and anything I should try? My previous configuration is actually to use uvesafb, of which has been failing due to v86d being missing from my distribution for some time now, but it would gracefully fallback. I have an nvidia GPU in this system so the nicer fb options aren't really a thing.  The builtin nvidia modeset is a thing and it does work but that doesn't happen until much later in the boot process. For all intents and purposes, I'm relying on VBE right until that module is loaded, but it hangs much much earlier than that.
