Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BD1465A1;
	Tue,  1 Jul 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359926; cv=none; b=DlhDJcpnTYzKcySIfgHNYtZSP8NnQwwEJZXDKFAenHe3UAL4TDsKk37eK3uPLruKO17d4CxGG814TUMqSAslW9YpdFIUXCu1HHPptD3SfzFrtssODBe4JirP62+ckslsa/YLRdqeiO2ZTI8jY3RfXMY53TTWDmxHQ7KFDdrLT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359926; c=relaxed/simple;
	bh=NWPSylHlVL5xApfhc5FegYDDQBDT/NsQf3kdjmaUKHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1Ey3hb/TbmgIXiXdFFrkWqY6+csZPumEkcoIik4MJ7iwwLeYgh/HtyUHP182X/sN0mYiW8OuMytFkx+Dfoj6LhPHCx/GG1pdpiNX1qb6T1kgJM+Ts6V67IWJ2h+v4fkiOWVRcikaFZ6MMT/gkC7y189UjvgTl9rul6N3YTQxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmjZb62o; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmjZb62o"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2823719b3a.3;
        Tue, 01 Jul 2025 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751359924; x=1751964724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=88KwzuOUdx+VhG7N8ukidarGnCXzhZ74KKnQWyukHXo=;
        b=PmjZb62o4sc7OCyQtYJ7I3jT8fhtd1vHWjzcWtzndFN09ka/uJfZwUNWhV+fStqFmU
         M4DdWxan2Gs8NAh1NjHR8YRuxWTFbSYaZUjbaAMNEYh3yqlCp9qjTX+aOiXY5JdE/9ag
         /UFmqbTTBQV2rtRW9uvFa1B9MqslOD0QOavIkcj82y1yM/OgjmHMkTbJ/cyuHyo9x8C6
         SwqHa8X6+il6TlHGnyVnTzRIRdi8B3PO9ci3GR7EXQq5Oceye70CUmOh4acL7EKZu4ek
         KTlIfRBJDd8dGifpMWK/aakEVtCvucP0CswEc2MgFZJS9CCTFdKJbFTaL2e01j7yYTs1
         tqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359924; x=1751964724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88KwzuOUdx+VhG7N8ukidarGnCXzhZ74KKnQWyukHXo=;
        b=mmEx6Uc/B3K28lcXXB08rin6xGVBX8qgXMf0f+96bw9QtC2RtXbhMvSby5oUG0nVjr
         /UpqsoD/M+3vlog0aa7AaAK52FphQvDnbqBPkrt/EMsgjdckHSNORMP+7Wfzn7W/lOVP
         0Ib67IRgCMUq3jbolQ2qfLEOsvUC6pKhdtQJdJ5/Ra91FawJjCQ/7HWzsHVWZ+o6GGzp
         cS+fxnGmPBXmBZ/3tBU3lfxXiZNWhES04HfsEJl2OfwT6d+HgYizxPfXL4OXvM1b5Wtd
         98uxL2J5D8xSqKNDkF3ofNvnzyN3j+CM5bb1Gje+0H4/v5g1dqE/GwvNjXGCeCTgw1oT
         QiNg==
X-Forwarded-Encrypted: i=1; AJvYcCUf/mbopiqY+69h4yPyArVup59NT79FVxPxiRyGe5vuFDt/npm/HZXU0Zncn+VpfmNa0ntGNbLWYrUhxA==@vger.kernel.org, AJvYcCVpjnN6JW9ssp9da5mGNLo366cIuUqheqmvSQe0njXk+vb0EM0AtV6T0TLoShyV1EReF8W2fQdioUyw6xAF@vger.kernel.org
X-Gm-Message-State: AOJu0YysSqvmD7CC5wXNlpPpm2MF3LCRJ+TgGpOYzntmwKxIlklIS4RL
	q8mQNAzSm1JYV/SyBgT8jXuFrLg/OD4JMRCnRr2dpvXBBBO4QB0TtPyN
X-Gm-Gg: ASbGnctwBfhKvz6MPnjRXpfxSkuDlCBTwy5ckVJFsiE+kJDFJ5WdpOJEfWPvp37x8T+
	ns+iDJca9EOMebrtGkdAD3g77ta5U0QXy/RksFFrjz9+mq1c3FLosXkPH3W8T6FrA3P3pva295Q
	vQiuE5M1enkBkpKEM9hilYSk1EdNIs5MGYDlc3WRWh3bTlEcu/OnwnqPqs36mmLbafOiffeQyoo
	eNCMMDHP9CHosdVXYgcafcoFlKQ4NAvLBPspr8eFFz5Ez5BRdh3cJ44l0rmQFWAkBjHcPqKn+dN
	NHtp8yLsDdh54RwNQGtBdIkwHYsrdrdNnUIMa5er9wlL6exwKq4gxZY=
X-Google-Smtp-Source: AGHT+IHxISR9hyQ+YgkO2UyVgvCjizdx9FY+4l1HiTDD+Xq2hunYsnuQWOfVSy1cXwISnEW95/tslg==
X-Received: by 2002:a05:6a20:9e47:b0:21f:568c:713a with SMTP id adf61e73a8af0-220a12e597emr22598713637.17.1751359924244;
        Tue, 01 Jul 2025 01:52:04 -0700 (PDT)
Received: from essd ([49.37.221.186])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3200f13sm10050149a12.72.2025.07.01.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:52:03 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:21:55 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, andy@kernel.org, 
	dan.carpenter@linaro.org, lorenzo.stoakes@oracle.com, tzimmermann@suse.de, 
	riyandhiman14@gmail.com, willy@infradead.org, notro@tronnes.org, 
	thomas.petazzoni@free-electrons.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/2] staging: fbtft: cleanup error handling in
 fbtft_framebuffer_alloc()
Message-ID: <cofo3z2thcwxaiec7ko74vqtczzavqtyxv6k67yxngv5647tpg@rsnzb3jhcb6f>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
 <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>
 <2025063022-chump-pointless-6580@gregkh>
 <ezkfonpaubsmw6gr4tutgnjmbhvsuwkhaiya7xozl2szfqi4f3@zmde3sfybyzi>
 <2025070128-amplifier-hyphen-cb09@gregkh>
 <CAHp75Vev8r7KZ79=CoUtt0wbx0x3O0ZckesWtQrxs-MBpiBz_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vev8r7KZ79=CoUtt0wbx0x3O0ZckesWtQrxs-MBpiBz_Q@mail.gmail.com>

On Tue, Jul 01, 2025 at 10:03:50AM +0300, Andy Shevchenko wrote:
> On Tue, Jul 1, 2025 at 8:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > I can't "drop" patches as my tree can not be rebased.  Can you send a
> > fix-up patch instead, OR a revert?
> 
> I think the cleaner solution will be revert and v3 patches together as
> v4. Abdun, can you do that?

Sure, I'll send a revert in v4.

Regards,
Nihaal
