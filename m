Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793006909;
	b=hGeu2adWRnqW/NeI8UGIUzDQxpZT61XMgIRNxJDT9DML0lsUzGPbhX4rpb1VNHVkeHGo
	 VbTS/h1xQevHt5OAiG2mcwU5E9bEVAT0kL2xnLEYpp3wsRmlh9rg7uuMcoL7kMLvK6ul0
	 u3OCUAIBd6GPt1/snRODKd5d7zRpSYG2SRQ5Un1N1kdGF77+SleTiLbZSSy/8kuMER1OQ
	 +zPyaKddd4MTwDvQrJ/R9lk9Q3Dm6ui7DjI8NYkWhvo3KBfsPz7/PvJ4I36YuAmrcs23i
	 0U6DnX8SJU469VdACrQkC6ar2iWJrPRLaT7Y4IDuV6JibkhyeE/TSxFmjuJqrzOhuKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F1xftn2ZvPwDxNIeM5ddTo25mlnOFwkbcYBiWLFaU5c=;
	b=4wjvmQEN/liOrBc1D6fq9s1+uA8ARF2ergKNLfBiEfSxS7+TiRxa2tVA8krg/cOJviL0
	 lwLk3c+5APfRyx/aZAn3mpB5gX/uZ5gUa6n9uc5QoLn5selhDBXJwL3v+xNNFsvHgfEQ/
	 vLcGzFHH2nexMoICIKRwagb3EseBFX8OzD4DmUOB25Tde5Y6kBcwpDjRwFVC419KSHsQi
	 zL9rNPQk7illjlfj3iL5O/g/xlKtd0w/bixFeWboB6iBOpjA90tyQ9BzGTJum/apPW5Tr
	 EJPcy07i8v36hLtMwI+bTOnPRCn+1Fq8riXr/oMypDK05UIomuSLWDSyG5Tb69LFGzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hgCkt4L+;
	arc=fail smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347C606A32D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 09:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0347C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hgCkt4L+
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso1886735eaf.1
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 02:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793006908; cv=none;
        d=google.com; s=arc-20260327;
        b=QN2SkXW0gF8Yq2m7jrvWi20L5zkB4scM6DHX152O0H0GUXTzsP7SCzV9m0UBnTT6JW
         G0KLEsONhGkcINUz9HuQ9++wlCGCKTNVrsUdQHGr0rhCg7lSDUafw+JEgdJPGL9fiI/v
         nzPMq4h8jqcxBKtU9kGcwdzzuLo/1wueULeM3+OYhO17vBv4ibJiqKSCTbW9ZubfsV5U
         KjXerFK95QHzF1mQ3OSsxHzaMKXm1bu+kkcTkhr+BW1kAwfi+HccmjUOHhRMMDWF0ON0
         CjdeD7gDXgemZ6EssX+MkG6DTTKnKoX/DkI6KOnUurc+oX4IMkNiLY2zX/k0Sjk5AIm+
         pCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F1xftn2ZvPwDxNIeM5ddTo25mlnOFwkbcYBiWLFaU5c=;
        fh=nFdLXAM/9BiurDLVxB95Rk830sALmAeU7H+4TB0Qw9g=;
        b=BgQ6SThGaMUJxluq7mz9KQ46ztR8vP1CGTxk1XW0trDBjwPJBrjx1EeEZeOEGF+M/z
         nxLmSumRC8SQBaQGyD6w3Pfua97/nXbsjDJJYGpS8gQjskGyHDwykTLEBxA2hKbLA4pZ
         YVSFTTgOWm11Td1ZIPI0/tYlr7oy4GYxJvjxws9KQ+lwpATIQ+QVdTn/ftmaX+zBySVf
         /IUke1yzsLMldlYU3NKvECLHebApJ16sEbra40bf8CNDJlW9XxHcXDZqqZgTwLXUDEp3
         SOa6OUCwcJXMy9sBpHnqx5jwfMBgx+tE4laFcekWVEoDKauvOXTKvAQKBQWGeOMAmH85
         uOSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793006908; x=1793611708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F1xftn2ZvPwDxNIeM5ddTo25mlnOFwkbcYBiWLFaU5c=;
        b=hgCkt4L+YfAYccom4a6uIl/crkODZNgm/zQC2ZdxHmYRrxbpnx3jLnjPKRliRmG00T
         iRIekG1wAK5gjf99qCOUMM3/yhR3aASm0IcaSHVB2zB94Usr/DJIHWsbKzXTscdCDOR8
         2kUjvAX6tujWR7tAopC6/hZ1xB5lw/RBgqfF6DD+9nm/E4pGNAh0FIXJpfD8YlD7Auxk
         twhWoBynWg0YEimUa5CnveVoba7ibXt5KlyWT75PN/cvNj7ZFyEerlE7Tfgx7lCfYzgw
         Ynoqt3iVURjbA3LmhJR4i3iRsuQyIuWElmRxvKjQhIKVYkhtjR7GJMsppTSeZwE2Rgok
         Ha2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006908; x=1793611708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1xftn2ZvPwDxNIeM5ddTo25mlnOFwkbcYBiWLFaU5c=;
        b=KLrZjzzyd3GB/AMa9lY6cxG0skUc9Jp9ByTkt7eMBfqSCElvi3hZVBC547SF4NPtFo
         jnQuL49XZLkKdcogTi52gS6qPl5KQnMbFdoqKHkz+X9z0c109+Tq1DDM6S82zeRZn7h/
         UPjSliTDosTxar7cYoTHL7YNRo1kLJbINFXFM74NUdD3YeTAu5s0Lis3B1KpiBi244Cr
         n5Dsg6IrLZTzlGjllm08QuZpRSJKGvISpHlMTcRanNl9JmveQwumEz/PTOXv4ioBv6B8
         P7Wgc0y5YeZ7aM6+Y42qtql7WUVt9DKvQ/pB/9StNpKpq4jiycOHRdsYUkX8Hd7gLTrg
         kAEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkrf9QkiMWsHZj+ABycvdY5t5jHFTOcOzDS8hOdYxebrWSpt8JmbVZSecdsEyAqCq1Td9Huls0t4FQpw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI6UnYjDe7CWAW8rnfMp0m+GVEMvzMbCbaaGezhHiRtcf5/ADLr
	WN6b/hvxNKs6LRJ6ZxMhqlc5iHFxSydy/2WE3ikkK2i5izcR4u6QW6VKXHt+cOZwFsCQXr56tHq
	73rKtRtwjtDIAfyk1uWkbBwlT92XbqAs=
X-Gm-Gg: AYBFou0/B1kPHD1hPtRF1g5Ycz//cfIaiCYLY0eEHiKEkLN4J2R5aRpEcDz27BFZnkD
	zktrGzI07lHT3yqrwePBo9lcip/RcdLd4tZlxNdsyfF+ApnRDGgcKus13Is4/Y/95gI9JXf+ja7
	ZVfucRT/MIEDhw6JsXrYlIVMczJbkz9+BwTd675q5S2RZ/DIxg6C3SZ8RrQrCc4Z90Ic3fB+OIl
	OkQQBGbpUzsz55BCV7pTGAIpUdTmAVBPJDh6NIQRkMD5l2WaNRQbh8gNxxbyIUhU4GBPfofCbO2
	0gHIykujYrxVSnkmEvRMKO1MkBwnULBM4uImIq6GUt/1yYPSl9CkGXt8c4HG8KmIDSw6XfySeQB
	KHL4EpZzoTWvw4rave3yF4wriAlP7zUSR/EjZzO4/lMug3gM88kaVX4Gyl9TflB1f49Dz2h0=
X-Received: by 2002:a05:6820:a502:10b0:6f5:467a:aedb with SMTP id
 006d021491bc7-70ba0b235acmr2055206eaf.6.1793006908009; Mon, 26 Oct 2026
 02:28:28 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026044523.18516-1-himanshu.bakshi478@gmail.com> <at8bT7NCQb9XvGoS@ashevche-desk.local>
In-Reply-To: <at8bT7NCQb9XvGoS@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 14:58:15 +0530
X-Gm-Features: AclHuK-u4NA6gcabskiGpw2QnFryhGCL2JKlsnkWAJ3_x92psReB-EPZC8UQQiw
Message-ID: <CAGLmz9LqD50zU-BGhaVQagJWTtGiEZ3ucDxbSVSbnd5_=6Y_dw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Where is the changelog?
> Why do you think this patch is anyhow useful (based on the previous discu=
ssion
> and your observations)?

Based on the discussion with Dan Carpenter (error27@gmail.com)
It was decided that since this macro is not being used throughout
the whole kernel, the macro itself be deleted since it has the
replacement being used.
