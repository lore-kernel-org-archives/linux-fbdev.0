Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403122;
	b=xAWcW11HNxstyeYxM1V00oqjIgETSXeXZjFVjKv+3LKS6vLQV58HwMIJkHu5aELieF89
	 4NE3Fb0cZHoRtk0JGEy/4OZsUaXKK1+BArOOPdA686K4qG2uHc6/XoWMfKRimYwuqsfwk
	 Yq5vIW1nT/8QWQYmBQIAMPTKRw/CxDgiveebpkFs8crRrIGijo7rIC177LpzH+R0ZBEKa
	 dTh0oLWaglosbYVWIACodi/UO3CZu01C5ZNPiKcW3yFdPZxX6aSXRiaMCFI2bsd84MKKF
	 IjPW63HzkapJhe7nRqTK41e3EltYShz8TvvTzhcSzlrCxq0dnOGJpzF21EP8tcKV9wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403122;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=esQaj4i0rxBBJRvkYI6ptnCogyr3YrhY79nTBzkIGog=;
	b=OAu8QZF+X/vlgmG5ifbMA1bguMnvRUgmcdwqptef39ylT4LDi7/064c1BNvGuLWf0BcG
	 H+u9hyPEuC8o+O7Vij/UzHowsORHtluqu10+rgCx99UsmtP+X3+eXSbvJgXxSHGkYN7/Z
	 qZVrSaZeUravZQ0uNn9H14TyhZ5FdT090gvTl7+5v6hzLyrBv9gtWd9cF2TpGMWrNQ9Dh
	 FWwKCyr0aekzRjVvjvfwxxLWW+TnxyO4JEQlNZTk9S+79b/oPJOHWw25/VYKneOhFHGTm
	 sEJbynBMqu9QXxqqdAPEYQGl/Sl3sAtZlQZ4BeidhDulix0zb+h/tXZ4FAYclvvAkEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQq7dU9q;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RqC7PlOQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD3606A324
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 13:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30BD3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQq7dU9q;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RqC7PlOQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794403121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esQaj4i0rxBBJRvkYI6ptnCogyr3YrhY79nTBzkIGog=;
	b=iQq7dU9qLnoGNYDWDjGkq2hu0UGzL8U0mU2PJsT4ClAuEQwYNhuhD6lbU/L5j70yCdSj3/
	/GrODQvBHppOxWr5r6zzBgSrz38hu3YXFAWjAaXPwSspLjuvjMHkYMML/7f3qhxJCiKfAN
	dqxY4Cs0j+KVTOfLKNu99AiyUax7GtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-8pZUjjOSOUWgmxyJP-OonA-1; Wed, 11 Nov 2026 08:18:39 -0500
X-MC-Unique: 8pZUjjOSOUWgmxyJP-OonA-1
X-Mimecast-MFC-AGG-ID: 8pZUjjOSOUWgmxyJP-OonA_1794403118
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso26641985e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 05:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794403118; x=1795007918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esQaj4i0rxBBJRvkYI6ptnCogyr3YrhY79nTBzkIGog=;
        b=RqC7PlOQLpcRLVRN7+MIGQGYiMWNxZug8Tju31tvogWMzrAd4tQOCCnLYEDdGQmB1a
         yIU6J7qsALFakOeCg3rFjyozZXyY1ZY94vDoAH3zrYpWMWqsW3rzMAnOcfjV/MD/Ce5a
         3f99wOl4BA2vgj6J0+xX6JkVMkaI8VW2NQwwEtIGyuKrux76g4GlnDaBC8w6s7sAkLTX
         CbyPtn1OpCdhcy/up/0BM2RXl6gZXXBTuguwH77sMuZ1vEM2VZaG1zS2XaIhSTZfFi4g
         T87PD7H2j7sgEXpZpzr/Wf2M8EuE3/qGvVuSuZ5CP4DWg3BOX2f1Bcv2x7cLi70juUtk
         CoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403118; x=1795007918;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=esQaj4i0rxBBJRvkYI6ptnCogyr3YrhY79nTBzkIGog=;
        b=wKmzgA3EeXgAq3je3Kafd58JoCqgDnESRFw13tgZBHmxZrUs5+LvWgckXd3iIR2rzo
         5+1jDxERq4DyAF/DUgxH/GsYRYpn8RycQC4Bz2N+8bdBY6osIMKKsXzb3Xf/1boXPE4I
         51wS1bz5kVF0/2uama8M+ONbFYO+Zs+OEYkdRzJaTztrEsdAAFGxwN+25hSkvnCTKUmT
         jSyLX0Koh+b/wAv6ARyMt7wNyOnFlghoBMYrQJwPcXv8f4WH8OjpJ5Qb+joHcpDQdSNy
         DxiCfakMIbOSdFGnEAwjOdM3POFDklqGKI6FXPLZYQ1VRRi21wx1urjwWsUFK2EFC4sC
         F6VA==
X-Forwarded-Encrypted: i=1; AL+hErF0Dg97tih6lEJ8LTi0YjYe9Ox6Ae7cEWQH/QtMO0zrhcFOPVTP3RGUk121tzezfrEixQZJCFoHipOKQg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZHbErzRwq0fz/I2g1kfSZsfVld1NDGNc3JpmNVy7qJTHjZQI0
	PzCf4AXBX2KBoWjQQpDhaQw5TiZxBMjl+3vDRH49Feu+In6pzi+GMB9TcEzUKrbhXKwFKirpun4
	0MYgTDDIb2qh2Za01xMmO4hsQ9p1229xbIye1Sm8Y1EWaMorlxk8nih0k9sCCUg4H
X-Gm-Gg: AYBFou1vCGlT7VfgrBdv0wiM8pTEHsuhGfjYbzcMqfPq98vC23Emt6rmICHLjJzfCXk
	AkPgjwkEXBvDB1+w56yltOCyPK6Gn24wT9borGsQR2Bb6xZTRDeVCcbhiUluMZIauvJHnKaruez
	vUkcZK6vC3fgDA+Yqjqlrtqb+rjJdp+sigHPvP1RwmRQIRIqF67MvGvFgH+VBb3OQhUthADw+Uh
	CqvW75zjqI9ax2MB5Q1ucS/NjjCafw+fsjpAEPlHKR2rVW0l2vKoS2ZllNAAS6H8E5kMZivqMOv
	puj70iR9dwLrUclPlOYMmjMhnZ/RJZDm3RFw0YYJzE392I8bx3Ev0sd1Fc6zzjHCmHKcobW0dYH
	PFVgKtLv85upnIZuNn7tkOKJ0aCBGdblbDI9r9ZtJ+A4RLNAfP4DEPpKiUhATxO6kkkuYFpQNSN
	XSkaxHuNRTS18vQrtxakX0IVEzd0dBWupQ2Yn1Ong=
X-Received: by 2002:a05:600c:870f:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4ba093817d0mr40825485e9.16.1794403117583;
        Wed, 11 Nov 2026 05:18:37 -0800 (PST)
X-Received: by 2002:a05:600c:870f:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4ba093817d0mr40824875e9.16.1794403117057;
        Wed, 11 Nov 2026 05:18:37 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498811fa70esm9733692f8f.19.2026.11.11.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:18:36 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: =?utf-8?Q?M=C3=A0xim?= Pedraza Padilla <maximpedraza@gmail.com>, Maarten
 Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Helge
 Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>, Jani Nikula
 <jani.nikula@linux.intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Jocelyn Falempe <jfalempe@redhat.com>, Sam
 Ravnborg <sam@ravnborg.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/15] fbdev: efifb: move the BMP headers to
 <video/bmp.h>
In-Reply-To: <20261027135342.2003632-4-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
 <20261027135342.2003632-4-maximpedraza@gmail.com>
Date: Wed, 11 Nov 2026 14:18:35 +0100
Message-ID: <xlv1cxsba4lw.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

M=C3=A0xim Pedraza Padilla <maximpedraza@gmail.com> writes:

Hello M=C3=A0xim,

> The DRM splash client parses the same BMP headers as efifb. Rather than
> keep a second copy of the structures, move them to include/video/bmp.h
> with the magic number.
>
> BMP is little endian whatever the CPU, so the header gives the fields
> as __le16 and __le32, and efifb now reads them with
> get_unaligned_le16() and get_unaligned_le32(). Width and height are
> read signed, as the format has them. No change on the little endian
> systems EFI runs on.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Claude:claude-opus-5-5

Please drop this tag. Has been obsoleted by commit 1e035297ffda ("docs:
remove Assisted-by references").

> Signed-off-by: M=C3=A0xim Pedraza Padilla <maximpedraza@gmail.com>
> ---
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

