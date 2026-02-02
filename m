Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B70366047;
	Mon,  2 Feb 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034367; cv=none; b=NFVulen9xAJqtvqMp8ixMzbqNnkmj21LLq9lfnSKpl+kfH1Y7r23I5NVAOCqWttNzINpdpawaw8azwFDTo8n9gLOfPOoclDx9gnZ/1gSBsPKehXyZHVqUxujguHnLNWmVBp9K+gyBDK7imyntM6xFtrGKliVS/JyHu6ye3jo2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034367; c=relaxed/simple;
	bh=+swo8L49vMCFm7y4qN1qF+xN2SEcN7x2gwL/nxu2exE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n1Xl4fsT6aP47PTDTlBY4+YL+q8HyMRH2asTFRPfLZKr6i3uoFXWmHGesaIvyqw2yshowkEGXhOmuKDxfRA6qI9vVWE4oXMpg7XyszmGuGAjjQS/Fh8i+XXxUz6PU2XeRgqO9v0F/t0A2yrWKssf1uM9nCGZ9s78MZcoxW0IJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K/PSO4CT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKUCsFHX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K/PSO4CT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKUCsFHX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AAAE7A0043;
	Mon,  2 Feb 2026 07:12:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 07:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770034365;
	 x=1770120765; bh=Fw7i9nIfM6eJs8qgMKg6v2kwvooQl/40xF7sINOX4tI=; b=
	K/PSO4CT+GJTMuqx5uJhxpfY0mZi0QO13rG/GzVzVAtUevsHD3wKCIFG94TX/vcb
	zQ1m03zqEmORPAHQb7zvhuVYb85ndppfOp2tDa1dhZ9GcLEveA7JOiH44RQxFwQW
	pcowxzY3gYkArC7arrc7U3IvBDRm2tKemT3Qnl+j6cKzdXM2PYDWlU2l9ozk0a1K
	okZSeTnxX0Z0Yh6Zjwc0ucQjzgpTupX9V8/SEK3y22OdLaBom52++t80ut2C1Jk3
	W2FG7BNjttoHZWbzobEKyfUWJvw59gPMKukMrawE06aHMr4NH/IkobWUxCGdH23d
	uECfDIOX6msXVAABZx6/4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770034365; x=
	1770120765; bh=Fw7i9nIfM6eJs8qgMKg6v2kwvooQl/40xF7sINOX4tI=; b=K
	KUCsFHXFgvfXkYjGDqOitDIewxSw2lWRQgggAGx1zmXz5SssT/BLArYHx2h0T3nF
	NVOS37dqtVhvG3XUsfSjIDfIINPIlLHLLu4C9M2/iOfuL3bkAgZ6Nd4XPekiZzm5
	Kxza2O4GuPL6q3Zn2gYthPhMcp8KjkfVvPY7qvsLNauOPVLtITzZ0sq/FnhhzsM2
	P7c7Y4rWj0RNC574YxEe9csvyGi230PcKV1R7RKNW30008RL8rcGsroLOtnlSXGm
	t0SFwn6QcQFPwyf8M68YrNcOYHils8Q0q5z3gT+xVJRi0xU7qp6zBCDtWjy6m4CV
	CCVcdyr0c2/7ihJ4q/B9Q==
X-ME-Sender: <xms:vJSAaQZSVl4q46qfGcBfjGSmN-czz-tsDy-WL2EVKt5IYEMRwlqTQg>
    <xme:vJSAaWMkiWUOSwqCQZF6kBhMG_PiP2azBDRqoCuqCacrKrFGfQl8ZT-W1qYadWU5w
    2337lwYlzzobDdxDTMaq6Fh6Xdk-fYtybhJpmB8K_mFLczmigLwCl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepveeikeduheeftdegfffffeettedtkeffhfetgeeuvdeivdeujeeuueevveeuueei
    necuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdp
    nhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnih
    gvjhhirghnghhlvghivddtvdduseduieefrdgtohhmpdhrtghpthhtohepthhhohhmrghs
    rdhpvghtrgiiiihonhhisehfrhgvvgdqvghlvggtthhrohhnshdrtghomhdprhgtphhtth
    hopegrsgguuhhnrdhnihhhrggrlhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhi
    nhhtrghnlhhikhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmh
    igrdguvgdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtoheprghnugihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhho
    rdhorhhg
X-ME-Proxy: <xmx:vJSAaUHtF1kSHpgqhojLNaGEk-k1RufeZLxS813s5Bk99vWsWmgc4Q>
    <xmx:vJSAaYioQ1SVS9VNrXUY9IiHYSmfxYxHPLBKp8lyOq60tHuC3145Vw>
    <xmx:vJSAaR9w0TNUdIWvXuU4Qhx74IxHm6lXsc8R8zJEc5OhbuAHVebp9w>
    <xmx:vJSAaQadKVjYUQcbz29cvkNtu6ALuQY6hsCzwMl64Gq0BSCQq49Ogw>
    <xmx:vZSAaeiu2Po9DpkatnPZyObY65tRIQxGi8_xb4KSiEaFmQ_H5wzgadPs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 09383700065; Mon,  2 Feb 2026 07:12:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-U3gBgaItWR
Date: Mon, 02 Feb 2026 13:12:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Arnd Bergmann" <arnd@kernel.org>, "Andy Shevchenko" <andy@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>,
 "Noralf Tronnes" <notro@tronnes.org>, "Helge Deller" <deller@gmx.de>,
 "Chintan Patel" <chintanlike@gmail.com>
Cc: "Abdun Nihaal" <abdun.nihaal@gmail.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Jianglei Nie" <niejianglei2021@163.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <3384db41-0ddb-4c00-9af1-f194ec5dccc4@app.fastmail.com>
In-Reply-To: <6580aa60-5f9d-49c7-8482-83bed12dfb0c@suse.de>
References: <20260202095743.1309162-1-arnd@kernel.org>
 <6580aa60-5f9d-49c7-8482-83bed12dfb0c@suse.de>
Subject: Re: [PATCH] staging: fbtft: fix dev_info() device arguments
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 2, 2026, at 12:32, Thomas Zimmermann wrote:
> Hi,
>
> there's already
>
> https://patchwork.freedesktop.org/series/160468/
>
> which no one picked up yet. This needs to go into the fbdev tree, but I 
> can also take into drm-misc-fixes.

Ok, that looks fine as well. The output is of course
different, but I don't think that matters either way.

> Am 02.02.26 um 10:57 schrieb Arnd Bergmann:
>> From: Arnd Bergmann <arnd@arndb.de>

>>
>> Fixes: c296d5f9957c ("staging: fbtft: core support")
>> Fixes: bc9f9cb85a7d ("staging: fbtft: Make FB_DEVICE dependency optional")
>
> These commit hashes differ from the other fix?

No idea. The bc9f9cb85a7d commit is currently in linux-next,
the a06d03f9f238 is not.

     Arnd
