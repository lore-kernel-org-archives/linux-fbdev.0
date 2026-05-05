Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10C1EB5CE
	for <linux-fbdev@vger.kernel.org>; Tue,  5 May 2026 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944948; cv=pass; b=TDBqacYVoeZNOF98crva6y16SWbt5W/+pW3AZPkob0zCANv9so1Z6PaCosyuH4crIHXdxRfY7TtUSLmHdFkpz7Jg8phztToXEW5772vrsG6/Csj2pMReuQU+R3MYOoR8iL+/CNlHcCdvNM9zjby87QPCiXCG+5B3iYtaiOvXBGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944948; c=relaxed/simple;
	bh=lTz2WcNHl3Rtf8x+dHAU63Kq/74gORQVJ1llz5TyeHg=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkZwzbMt8bArQ0JFvqvdQ+hWxTLFDxSrUEKu4AcCj2DLbBTU4NNEiTIgDT+cd1ZLRkKeFFKZ+ReA9hV69ewJqvjzVuF81vjyWEWYhAn5JZYQgEwBAFlczfVZG8Shodeu+6ygJVM0N3cwmWiii+e9Q5hGQyQb7og7pcFI+Z/8HAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3kxCG37; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3kxCG37"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bc2a455fd55so204760966b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 May 2026 18:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777944945; cv=none;
        d=google.com; s=arc-20240605;
        b=GWcmafd62WrWMmmVu+jQWT25sgbYk165iZkfg56UAfZFao69uaYTrsNIr2oepu9uFc
         r1AYnaudZMExnMC2o5ePOKRqaFOMFmSCF+ew4qW5PVTAQkh5pBR+M4ILVuIfRZzRd+7D
         0fUI2oq9xm68Rk0yAHgyx/PoFtqYvDn3U5STrJ5a8aHiy8AkiIA10N9Vighc+GPhkDvZ
         6JmRbqiD0MlM+shj1vLO3uPAuLILt63oGpFf6pQ0fVYVTMgPvLf7h6jYYDXpik1RW9DO
         1hOylICzvx/JgAP6pr6XvxQ7ZIkoV92eWWxfRcj+qg23Kx3uKIWdKpmCDCrQRfycWvF7
         essA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=lTz2WcNHl3Rtf8x+dHAU63Kq/74gORQVJ1llz5TyeHg=;
        fh=onmEHynlqCyrh47ePnnRQHjuzbwsYMmVifSe2E1PFMc=;
        b=jB+4VEb4Czum8R4ocK1HvStSPfbqjBd8m6rMjpXO7//2Yx5ojD9mV4ulrKlud0Wt00
         Pm475XqaLLWw7OS6dtowSePLwQCO9QzgS34Q/zv7EifcSFGJsR5J5WiGOQ/wikIyiUF6
         Ybrz8Qx++C1LjZSqSwIOFZMWGUt8G+qFf/V/UbS9ZHieQBA0YS6eIpL51EiexkQFXsNN
         TU8miCqWz37ZZpwCKx3d0jSCwuo4lPM+h4eR1qDOO6Hc7GDdl7HwxM0GRSQCrv8G8aYh
         FZUDVo3un2EGd/o8F6EZDJ85JIPPqnk7rYuU6l7WzNpr5KnIENTEK7ADjt6v8mqJHfgB
         /+Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777944945; x=1778549745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lTz2WcNHl3Rtf8x+dHAU63Kq/74gORQVJ1llz5TyeHg=;
        b=Z3kxCG37cBzS0DLOne3IK6L0t2kmGufjHJdlwcdtrYaQxavbjHxUHW7q1MzyYnMgw6
         8jcV6UJAR6TiEZhXeEUzvVuqBWc99NolxbftiwYf7UfrIrhyid2AE1Sdj5zM4/W6kYOJ
         2nwiBs2hDlBblLwkDmjnf/Qb94EmdTBI8kC8UM5PVT9xLD9dOroeo4m9pm+A8Va+BB+H
         ApTVknLp2QFfI5/4vHV8wRz+8byFWD5QkoupBkz/kSbSHKRW1StSi7zzhgPSbr6zm3ya
         RlojKQHg+sumNuyVVTrD/e5g/AngAKR6iJd+g4H4xizLmM/Okcs9SzWxxGkQYDurMEyk
         RrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777944945; x=1778549745;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTz2WcNHl3Rtf8x+dHAU63Kq/74gORQVJ1llz5TyeHg=;
        b=sYONCzz9k3vjJKMw/8YkLDtV6DFgZqK2mz5i8aU2MdsOprjBM4aNMHGYZ72o/98eJJ
         PX2TebbK/0/K8PrcRhhCZE0+ogPavKoj2aoAUu+Llf+b0nKiEYOcNAswDzNFBLE33BFH
         Vwr4tfKeQHO1ZBP5G0HJNJ64h3LK/CVgpr6RSNOiy6Vnibc6sMCWydIWbmc8Hm5d18zS
         TvSJgRoj/8FqF7ojnUyKR/URdoXg9FpOs688Mcq4T/3bzQARYqeAwBzEzDL1nqbNGJIs
         ri//mXaXOoptg9HcJ8hMqcJfN6v2x/T5lteW2CFAbS0CG5vIpzVIT18Sy2tXbynnaqRI
         euew==
X-Forwarded-Encrypted: i=1; AFNElJ8A0G3NHG7N/NzMywun6HVjLkDW29J+IkzkBLwoZBMXw/tfHt4Yj9hCYis4OrbgVvz3yxJwsDYogZA99w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+8duRFs+s30hHnWCJKVEp/wishyPmLbgwIevHb64LE+oMIs7
	jt+EguTq/vQr/NCVcqt7tj97wXl40p2z62CpQMtLpyrCb/ptsiJNCi9+T3bdq/SeRjToTJwqXsB
	pVKDwlMbjPmXtlIwNNS1RzWesLDEsg2c=
X-Gm-Gg: AeBDievCQRXH8LMaL5Wk2e74ydj1ONXZJsmFlm+sLyVtBaLC+47picgI+t5aEqWL8zk
	jK0JtytxnXQso8RBuqCOcg8w5S+BlsBZPXhZywOV/oflgIR1hIjEPROuDkh7QZqSqlabf+LReta
	WoP5mnPGpwg5jXTLlueIvcAchvIx0V4ZraqRAI/wMmDy4NwQfFswmLCRrzMbdPXrHCsocwOFu3C
	WrBOa+L8tws3kvAoOSd5ezHtdKUbpZxS2QlMhaNdEMkgTu4mC8d/oOkDNOhsWDqPM4R+8Uitjx5
	dJxI8QG+OolHdWUM
X-Received: by 2002:a17:906:2083:b0:ba9:559:10c8 with SMTP id
 a640c23a62f3a-bbffbf85acdmr444502866b.41.1777944945361; Mon, 04 May 2026
 18:35:45 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:35:44 -0700
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:35:44 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260420051926.28276-1-dbgh9129@gmail.com>
References: <20260420051926.28276-1-dbgh9129@gmail.com>
From: dbgh9129@gmail.com
Date: Mon, 4 May 2026 18:35:44 -0700
X-Gm-Features: AVHnY4JDB9kuFR4i6jpPy5jP1lj-FAqVVNTnvpy9OmPWVwI33zJPMe1vEG0yoX8
Message-ID: <CACrCO_WT9R51pJhddWysJEHEZ8fhaGvZXq2ZB9vfCD2i6So1cg@mail.gmail.com>
Subject: [PATCH v1] fbdev: savage: fix probe-path EDID cleanup leaks
To: adaplas@gmail.com, deller@gmx.de, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mhun512@gmail.com, ae878000@gmail.com, tmk5904@psu.edu, dbgh9129@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Antonino and Helge,

I am sending a gentle ping on this patch. Please let me know if you
have any feedback or if any changes are needed.

Best regards,
Yuho Choi
