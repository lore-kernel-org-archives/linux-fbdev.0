Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA13596F;
	Mon,  9 Dec 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752594; cv=none; b=tVgL0f1W0t67rj6L17OgdP4oxrOrTwNc1HdSJgdC+Zw9SO4abx0Lr6ACX3Y9rQ6HFWCJGzdIJ/+CZI6ZAD/q64MHPbAVOcsI4KdrPcElIibUNiTfeatXsxKAw49BPneeKhhgNV4YKGc4/MOOA3Vf2O2A3wiV6gJHG3HRFa0Es5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752594; c=relaxed/simple;
	bh=20shHAH5rzhM5qlKS1vaW89uLmxf3J6zk8CxqaxVOi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hApQ6h+rsIRexqgLKA+7N3OSGZ9ktTU2HA4Ly0a0o9NRBUOKEkDa/0V6tfWS/OKUedV6Q/t1GMK1PWGlUBBOugVZa2UL5D0sCg01QcRb2O9msevyo3WENxJ0yBet+DcpMR/Yn/i57GR500/tsrpljBgX3EFp7LiBM6uDHb8HuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwYL6poq; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwYL6poq"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a81324bbdcso23225975ab.1;
        Mon, 09 Dec 2024 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752591; x=1734357391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20shHAH5rzhM5qlKS1vaW89uLmxf3J6zk8CxqaxVOi4=;
        b=mwYL6poq3T/vgTEFF1bSlR8SsRwfroc3Q+ejRgmiz/9nQ4iy06MMVPDovXM7hLzQeS
         uI1KMbVtLd9X/u8F224hlCKHhSVa5sc4bCnUn5Xy2pjtdtpsAMEUPxSPkEHIOdw0fjyz
         W+7xkcp9wUoqfUUzTDrD4BrtCxSW5t9WXr5ANjhIqGBtSC8rDR7IZ1T2GSVHjXqjUsj2
         P2hrsvEalfGu+ISZgZh/sXvRFzfGHOLW36C87JdQdYyMeVK/cwOqJ2ZoBdXJOf9RFOPM
         cwQOEQMyBmTrBE0kx6uizq5+ji2lKNZZqXKIFQPJ9JP/AZky/KEFeXhNpcOA7CAG8zJ+
         s+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752591; x=1734357391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20shHAH5rzhM5qlKS1vaW89uLmxf3J6zk8CxqaxVOi4=;
        b=H0UAZy+Nl9AMTBfVLxy8xSid20Q8xMT/JD4FTr7c+sy0gAUg39GkMkv3MgcQ81LQ28
         f89rVFGZYY/NkjXiFkT66r2o1fOMYBOpW/fubFf21msZ//JMi5+XfJpu1OBH7ohZ920W
         C8yNtJuZG7n6fFRoONFkboWy0u/IiL+Lvojns6ruvy9AgBFQtEAVv9LJk5pnlzXq8dNG
         /IiTMyBIOhMqtolHgWcGFH3MqE+OQO7vYCNUFp8iklfa76Q8eoAAQGmU4fsUItPSPClL
         GMp4DZTLaij4gmXu1oAqrxjNf48qDpK/xcQAG9WRQhJNeKW3OZFsw0VBG8YBS5PVq+H2
         elsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDHvc8GZsN8zZpjkuws3Czz0GtcvsxH57YNe/GjRAgKG7jfGbNBYZkQlJtwf7sjd7LavwgW/ymyyRFVA==@vger.kernel.org, AJvYcCXRa/BkHsruz1oRW/zdD32gZtljs4flI5tZUBe4PB8JO9nTtyiElhiRnBLotQ7TSjFQRhQKN38kSDtt2fR+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxyeh7w1UOn6Wdnc1M/GChedp5DSkCVhLpgMVUd6Sb/pHJKw5C
	b/oFIEm3w/ttGQfEk8JnRYTUUTIQ9xVHuNgUcKGriUB8ezIyS52VTweNUbHsSR8k5Yv7A//07S1
	moJxKv8jpoxTg4DDQRp4YY5TzgOU=
X-Gm-Gg: ASbGncsxDoQpPuGJ9Dj2rWbqbFRneb6PShAN+w2e8irIpgoKZ9CnhkeIBdj4/hl3RR1
	3qMcp+OOpcqCaNQc/svAD0aE9n28=
X-Google-Smtp-Source: AGHT+IECMwsss2FoZy9xBlkgCdMD3K+aFiFas1JeSPI3N6gfmsMB28SKRbBS6Drtula3ua1ptWvs5YbSz0qOTacUlW8=
X-Received: by 2002:a05:6e02:1746:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a9dbac0662mr3847895ab.10.1733752590855; Mon, 09 Dec 2024
 05:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220621104617.8817-1-tzimmermann@suse.de> <CAEXMXLR55DziAMbv_+2hmLeH-jP96pmit6nhs6siB22cpQFr9w@mail.gmail.com>
 <d2562174-eebe-4462-9a9a-03936b3bcf89@leemhuis.info> <b4d28b98-a85c-4095-9c1b-8ebdfa13861c@suse.de>
 <CAEXMXLQEJPVPyqLpH6C7R6iqhhKBpdNS9QeESbEdcmxB70goSA@mail.gmail.com>
 <da4288a6-96cc-4095-bd73-d66b68e9ed01@suse.de> <CAEXMXLQw1yqUGbWcrKZdOuGvA4eZMG0utiyQ2PVRvTeuFedGbA@mail.gmail.com>
 <9c902ac0-a94d-4465-98ff-840132e482b1@suse.de> <CAEXMXLSLau0sEy8WSZ3=ofK97xP8aPcDQEnT=JFkkt7K=Rzivw@mail.gmail.com>
 <900b873f-6eba-4dba-b155-dc5f7594becf@suse.de>
In-Reply-To: <900b873f-6eba-4dba-b155-dc5f7594becf@suse.de>
From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date: Mon, 9 Dec 2024 13:56:19 +0000
Message-ID: <CAEXMXLTT5m0Po_wz0ywRHFetV6e080AJwy8f99Zb9R_afzafRw@mail.gmail.com>
Subject: Re: drm/fbdev-dma: regression
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, dri-devel@lists.freedesktop.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Framebuffer <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:43=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
> Thanks you so much for testing. I'll prepare a real patch. Can I add
> your Reported-by and Tested-by tags?

Reported-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>
Tested-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>

Thanks,
Nuno
