Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06841A919
	for <linux-fbdev@vger.kernel.org>; Thu,  3 Sep 2026 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423880; cv=none; b=qGdDmxaWVG5a6e2W22mmAB5NOxu2axp6W2mAsFT5RDSt+my/ab02/BuJ0qO3QlpIfX4WoyTWFREpNAz5sh5YVpgTOFE3OwmzwwU+sKkfo3Ym584rfASdIMz3ZXOaWNxzZfZrQR/KA3lppZQPscoBAFlXLGwW/t0twAgLRmewnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423880; c=relaxed/simple;
	bh=Ls4xniOjZvy5k7qWaJ+bT9dRttTYo5UPShghXw3DL8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLczbmDgFdQHnqTZsdadZoRS7cpPOIkwZpohPsE9YHi55IoffZan1ZvSQzP2ctBpamZgZcYAqXhXgn18gfArQ9C+Z2brlxlTBVEmpeHp9gtqWRVpgLLCay2x9h4mpB6iQDBfPuaTVU6t8iMKhc0x1/x1Ky5Fd8nrUWZ03Td0oSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RVpZKePw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EuRwRA+n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVpZKePw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EuRwRA+n"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788423877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls4xniOjZvy5k7qWaJ+bT9dRttTYo5UPShghXw3DL8g=;
	b=RVpZKePwsgjPGHsweB7GsSuZAyk6Vl8bcGSJUN6FBtM9LdDAnHDTYpG6/2temWpyraRJTj
	+1bWgj1+i/XprSF2i6YQOUoR+Vsko6rVtZM1BokT2dHT2OEA23JAM0FRAfS6lphHjOegnh
	vgVH1XfCVMIIPGlyGGrbsi9W3Qtp5Q1qMuM7i+kiPFV7YOuAZypFfOEMnQysoVhQpRwWmH
	sX/XAuMKyvlGlF/h6w7AY6WdhaYlI+Vejb8NEpi4SRSQtqQNXYLVt/aTFvYXKBLA9RVx/h
	65RCKpw9Jo2ouDGLcSUv3e4vZSaTa4K9QQUrFq0ytj3o52TtkPzLhckQFMRb0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788423877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls4xniOjZvy5k7qWaJ+bT9dRttTYo5UPShghXw3DL8g=;
	b=EuRwRA+nb7Nc94Y1bLLMKkBSwoTlXFOzsm6Vl3tC88wEcv4xGKBRogh0aJ7iEG+Sq1mt6V
	eezpmJsJxikFaDDg==
To: Anshika Jain <anshikajain196872@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
In-Reply-To: <CABj3sPEMo3B9B0ynfLGD=NmMu+0zpZ_Ydf2yyT7NDaT3DDNq=A@mail.gmail.com>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
 <87wlt3vnzp.fsf@yellow.woof>
 <CABj3sPEMo3B9B0ynfLGD=NmMu+0zpZ_Ydf2yyT7NDaT3DDNq=A@mail.gmail.com>
Date: Thu, 03 Sep 2026 10:24:36 +0200
Message-ID: <87cxuu68u3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

No html email please, the mailing lists will not get them.

Anshika Jain <anshikajain196872@gmail.com> writes:
> I'd like to keep this as a small safety check for the future, not as a fix
> for a bug happening today. If you think that's not worth adding, I'm fine
> dropping the patch.

As mentioned, such bug would show up immediately in testing. So I vote
dropping it.

Nam
