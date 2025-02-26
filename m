Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF44215F65;
	Wed, 26 Feb 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570451; cv=none; b=dWTWzAnXtv2aIIxmzW3+V5ZwIBCchUBkmMxkhS+5w12i8gn7nIKWEVLDgz1ylL5Gr6+YFuHl1tczPI4otTXxwYHfnLwe2L2lNeGx1R/w4dvM3GjDvwKacV+1fWAGyHqBdPUx0eVjysqDmPFBOo1o+8MnZFDRlE0qYNlwFhaBhkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570451; c=relaxed/simple;
	bh=GNROyfSwLsU0OnrSPd4OOnWuNRATtj48jePoEv0RPik=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TwAvh70Aav/6fJ8jtRqZvkLqotm1I016gMBNENFsMYSeLkVsoep40rMJxHok9aGH9PYdegqBBvC0erO4A1/xjkpYnuWNZKDaVGFnTDT0+4Y3QnTOspkOThvbNoW98gX3yb/O4XeDFqeIdyJnI+hXDCQYPYjArJ+CGJTFVa36bls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K5dLnZ+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3rFsbLM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K5dLnZ+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3rFsbLM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C3C225401B8;
	Wed, 26 Feb 2025 06:47:27 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 06:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740570447;
	 x=1740656847; bh=srA0vSiRaX96bO7gWAZFdEu/4TLsEeD2V/wdQUaSQxQ=; b=
	K5dLnZ+IEvOA4/EeEZFacetVjPs/sdbfQ9nMyi6y+2jlG8gB0UCZBNudMqiOwk21
	VLkFin5zplcLTwOCwv3zMK7AYAdl0FTWjWl7WjxoJFDBnPVMOYsSvUJqSaEpHMSI
	TdMNp2iMDeSttMrUVbgj8cBRLXuSmuCwtTAIn1Lqvd94R6k8o0KYTrGohXUldphT
	+pY6CL/v1klhU96/KIUrl6YntD9u/FeyBp2PbC0iDoU+adrI1lzGm4ldfVFgdf8V
	wv65M8dUEFxifrAxNJ77b0yxHnxTSuFNql9/5rCmiU/BZqdBeU3JQfSjCx4V5e0G
	ftBQ5d/HzyZgkE48TtUxuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740570447; x=
	1740656847; bh=srA0vSiRaX96bO7gWAZFdEu/4TLsEeD2V/wdQUaSQxQ=; b=b
	3rFsbLMobRqNDSJF8SjvoG8Kucn6IjqOjT4yCQfpZkMBcnMCSRFYfuHfFEVQQtAg
	WdZv4dNfurKnlqastIL8h7s2j1lO+PNQzoCdSbuOZ/IwKa9ad/d9I3NVnkoYHFJT
	bFCH4SArUOM9F/c9fyndinVws5+Z4ct0p6oIzmlB9hWsvDidM33eaVERL91jhVjp
	qADplyULD1YP9TEUFEPxVv/JPPtPX6C/0Hsk9KHo31HKjTe5WtmuHsL21t2hVqHu
	+ECbqPy6mi+lMqswcoHujtVizKnLQWZBQnMSDJZHLoxD5E2NtUPlQSJFWGungpEF
	9XGV910f2sueMNM0LfpgQ==
X-ME-Sender: <xms:Tv--Z_diHp5ZDRErRnqmS8ZPTTCezM_3rgE7AVddKtn-DuaNDBkDCw>
    <xme:Tv--Z1MphFXytyiu7QgFfDu2nEn88_gsIz_sjHvdAPGZjY0HNcLObb1hRQsEwbmpw
    u-3NTzdUuLsebhpXOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghllhgvrhesghhmgidruggvpd
    hrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhk
    hheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurhhiqdguvg
    hvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepthii
    ihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhfsgguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Tv--Z4iCSjAUyvHYNJf_AG3sE_ua61qG6NfnGFOiyktvBK3_IRMNxQ>
    <xmx:Tv--Zw8wQwtaohN4eqXaSl-7aGOjmxGKmCkBjCDSzCiQbM1hU71dEg>
    <xmx:Tv--Z7u04LRvb5kBTsNhcfklAEHiAI9rK6b3N5rrYCGjNnwe_hmluQ>
    <xmx:Tv--Z_GRVy1a40pOCrtq_ao7UwyvfCgGSK5AqqZ27__1LsxM_r9ugA>
    <xmx:T_--Z_hz1oXOkYT7AeuVlKWwR_HmHayHpHeWbHHKwfw0qUc_tH4kb6ns>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA9B42220072; Wed, 26 Feb 2025 06:47:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 12:46:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Helge Deller" <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <79d35e3b-9a0d-41a5-ab07-797bfa1e19cb@app.fastmail.com>
In-Reply-To: <29ecc7c4-2887-4989-a1d3-aa76b44c0387@suse.de>
References: <20250225164436.56654-1-arnd@kernel.org>
 <4d047af3-fd30-4fa4-aa3d-c0359856d750@suse.de>
 <a2c0e681-2cdf-4dc9-82fc-be35f54ff795@app.fastmail.com>
 <29ecc7c4-2887-4989-a1d3-aa76b44c0387@suse.de>
Subject: Re: [PATCH 1/3] dummycon: only build module if there are users
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 26, 2025, at 09:16, Thomas Zimmermann wrote:
> Am 26.02.25 um 08:55 schrieb Arnd Bergmann:
> Here's another general question. vgacon and fbcon only seem usable with 
> CONFIG_VT=y. Wouldn't it make sense to have them depend on CONFIG_VT=y? 
> dummycon could then be implemented as part of the vt code, maybe even 
> become a vt-internal thing. The console code is complex, so I'm probably 
> missing something here?

I think in theory one may have a system use fbcon purely to get the
boot logo, but not actually support VT.  I had also assumed there might
be a way to use fbcon as the console (i.e. printk) but not register
the tty, but it looks like the console code still requires vt.

After I looked at the vt and conswitchp code some more, I wonder
if we could go the other way and instead of integrating it more
make the conswitchp logic optional: most of the complexity here
deals with switching between text console and fbcon dynamically,
but having any text console support is getting very rare (vga
on alpha/mips/x86-32, newport on mips-ip22, sti on parisc).

If we do this, the conswitchp code could be merged with dummycon
in drivers/video/console, with the simpler alternative just
calling into fbcon functions. I'm not sure if we can already drop
vgacon from normal x86-64 distro configs, i.e. if there are cases
that are not already covered by any of efi-earlycon, efifb,
vga16fb, vesafb/uvesafb or a PCI DRM driver.

    Arnd
