Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F81D5160;
	Tue,  6 Jan 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737797; cv=none; b=YjLn7mdXAAUvPq/WCfPACtusABbAxZXRkag2oQzT0n3L7xsA3G1C24X7+3IkYJL+isVpjt5YsPMybyqCoNqhAUmj/Nbjd6cGVs5qjwjUsmvsboGk2flHS9Jq17Ct/0TOjVMTPMFMWSZefWvhCGDZfyYSA734EcgydIczjHx8+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737797; c=relaxed/simple;
	bh=y1PBfHHQwgDsCuB/Snw5qx45/pmVXCS4prsOZvmoeoM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r+9ficmQpMu/re/fE52nzPies7rZCUl/t9Tpu/SFpn7cGO/rg7N15I0DXW08+rLRBKXyy8IkpfULffu8AmKtO6VL61QMfFeJTBOfzAgzmNr0xB41UZ1eExUO+TTuiMP7QzAzI/7uuFpu5EEOoJC0EXzXW5lCrHd6hwi+8TjSoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bwMvFZ0H; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bwMvFZ0H"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A85F7A00B6;
	Tue,  6 Jan 2026 17:16:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 06 Jan 2026 17:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767737794; x=1767824194; bh=mEWm+WVkhC7n0p80aiPEAouq9j7WfHhQI7z
	k97WgZbc=; b=bwMvFZ0HgjtwLz59FNEVvzcp7IjHw40oX8W9io8nTRYVFbV+9rY
	yMhFFnXxxCRDHnDBDnt9Om76DBRpB4gNjPPX5l5hQpwom+UhVzokzsqr1YbFryo6
	gmXKAJ2bt0/B3KVromdltBPTTTy8gKPnclMd0n+epZguGfzra++q4hf6KJh2l797
	YScHy/nrpOeHBXYmk96Rwb3x1sS1fjBd5KI8a0iV7qwrLZsrLBDX7HLFPzy3JEA7
	FJMttBOnViQkYnu8XU06mARwrraTsiwBoAhCBaXosBDo2r8z3aj0tWlZUS6Twgmf
	zVwfCmCNJ4Byl4wkAcxE82thYHudnT46eLw==
X-ME-Sender: <xms:wYldaUkyJEKLPiOlQ_pCImcbQBdIP0HOPZS1D2D_0DKdZQTUYT77nQ>
    <xme:wYldaXjyqPWi3MxC6_H2FIQAe7POFz5boE_nNquhW4cw0__ZJuiP3LgiO3Kn_8RpE
    MDTb5xCaS_HQ4YdT9mJLdYD2KDg3PdGZVzXYkENoTqPGs-AsjGRap8>
X-ME-Received: <xmr:wYldabRa3sBXlU6hNQCJc_0dvsa0cxpY_bJ8iOLrU8Tptz4Z-1QXXC5Pw6d-3V8E35fPRTeU33985UWapGja2OEAN0tor02QBUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrihhlhhholheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthht
    ohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehgrhgvghhkhheslhhinhhugi
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeihshgrthhosehushgvrhhsrdhs
    ohhurhgtvghfohhrghgvrdhjphdprhgtphhtthhopegurghlihgrsheslhhisggtrdhorh
    hgpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdr
    uggvpdhrtghpthhtoheplhhinhhugidqfhgsuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhht
    ohhprdhorhhg
X-ME-Proxy: <xmx:wYldaR-emsrm7Fdppl-LLB4KZXDyglfbl8yhtRwyve1xrvE5qgXcbA>
    <xmx:wYldaUO14_MqWJ26DTDcsBC3FGQvQTgewIwTd7sxSWdsEiTNTdQtbg>
    <xmx:wYldaaiesD6tlOnqoGwgUFaUZdu9pbEpwGQdd3WUns9KSFWVF69BfA>
    <xmx:wYldafkQGjXAXlOibwpD6dsRs4106CBvdYwvStf3wB08i-9yf4YLqA>
    <xmx:woldaY6fvP1eHQ8-GqFzoIdgNywDpYHH4YzBggjNmEhg3tNpPaxNyTr7>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 17:16:30 -0500 (EST)
Date: Wed, 7 Jan 2026 09:16:27 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Vincent Mailhol <mailhol@kernel.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, Helge Deller <deller@gmx.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
    linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to
 Kconfig
In-Reply-To: <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org>
Message-ID: <eac23137-f6cd-0789-074c-279de76f72a0@linux-m68k.org>
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org> <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org> <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com> <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 6 Jan 2026, Vincent Mailhol wrote:

> > 
> > MACH_IS_MAC can be a runtime check.
> 
> OK. I missed this.
> 

You can use "qemu-system-m68k -M q800 ..." to run the code you're 
interested in.

$ qemu-system-m68k -M q800 -g 800x600x16
qemu-system-m68k: unknown display mode: width 800, height 600, depth 16
Available modes:
    640x480x1
    640x480x2
    640x480x4
    640x480x8
    640x480x24
    800x600x1
    800x600x2
    800x600x4
    800x600x8
    800x600x24
    1152x870x1
    1152x870x2
    1152x870x4
    1152x870x8

