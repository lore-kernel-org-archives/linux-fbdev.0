Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921533B71DA
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Sep 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472837; cv=none; b=tqG9YTs+q9/o9n6vMaKufv3jWtR7b8oOtfJ9kvMebrNJU6XSPq3RIbVh1cioBoaCsR2vtZiVOjEVtCQjJcbv/KTZLJPXEPoOiLtRGsk0fqWE8W2BXKwwJ586notY+ELrtDqbZcxpe8pYW0BvPTRRfLGb/yj514Hj0E7zav7xYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472837; c=relaxed/simple;
	bh=KiATVgLzbQNds8JboKcKKKgdRjQ5Vi0AHorJwJ8qTuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ub+LQNXGbkKgkv28NB7cr024AFwLs+Tc3HGAW8SSoWPFvFhdumXhDqpn8Lhfba+uTs1fzfUJ6aJtdk2LhdxRPf+gWKkscfmKT23WOi7rJtcbSELA/wgv1alCdoEZLx3mCsoV9/mjnnC3yKH7XcURLExlg3tm8CsGoGE+IetAB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NY8XlfRr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYkoomiF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NY8XlfRr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYkoomiF"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789472832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiATVgLzbQNds8JboKcKKKgdRjQ5Vi0AHorJwJ8qTuc=;
	b=NY8XlfRrYtA0mfLZYHp6UiqgeeJu5AT7gcCZKoqd1COjvQ4sSn9/uC1ygWMXXBp0mwqDfB
	IkTBB6wQdccI26oLX3MXHuyxnZgFaHUd25u5OLwEU/i3vS1mNrqODnDo7rsPctLJ9wLwTR
	5+K0Hqx/F6X5/Oz0WUbk2inaiY5Y5ccFcyf4AbGmS+ZvEk5tkJ4eR4fS+kAjPv3K5uZEYu
	dsNVfOfticjCxpZXRc7QnsqTf8YQo9DgvqhVm7yoSuT69VrwvkSoxzbLC48+yhmfdT4kfo
	qmNQGJr+y9YRPeJIXY/gjQHOygYuTNai+ubwH0M7qx42PbfigJYINTZzliBISA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789472832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiATVgLzbQNds8JboKcKKKgdRjQ5Vi0AHorJwJ8qTuc=;
	b=cYkoomiF8mg84hei5SUNQ4qQ3Zsy7hKcMJuD6pyuJIRAinly65XLkIMzYOnrMGsCqixBbe
	Gx2WmXxWh4c67BCg==
To: Manish Shah <mshah3409@gmail.com>, linux-fbdev@vger.kernel.org
Cc: linux-staging@lists.linux.dev, Manish Shah <mshah3409@gmail.com>
Subject: Re: [PATCH] staging: fbtft: remove prohibited spaces before closing
 parentheses
In-Reply-To: <20260915101056.66210-1-mshah3409@gmail.com>
References: <20260915101056.66210-1-mshah3409@gmail.com>
Date: Tue, 15 Sep 2026 13:47:11 +0200
Message-ID: <87fqzarb28.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manish Shah <mshah3409@gmail.com> writes:
> Remove space before closing parentheses in define_fbtft_write_reg
> macro invocations to fix checkpatch errors.
>
> Signed-off-by: Manish Shah <mshah3409@gmail.com>

This has been rejected multiple times in the past:
https://lore.kernel.org/linux-staging/?q=define_fbtft_write_reg

Nam
