Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8038B9AF
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375122; cv=none; b=uRmP2dG7Pr3Zf3p60wk6ShfnqNS6T8fn5Pa/vwuhGotA9IrAF5B6q7oYvuLZr4bKF9eV6/eK04kWx32/qpD07uCG/0IvnUG5FebHfWyuxy5zs8iLrFfl5YNj2dxvW9iBW0ncd4GlRTiA+TrenJpOx6vsu7+Y7aR6PBN2i7NaQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375122; c=relaxed/simple;
	bh=bA2jDBMBJNWRCojORjUifOX6+Gj8jMwDTcaPo1p6gdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3+OiStlvEjF0o5P36OJN/z5Ifh/vHFoomYSu53CR3h7YGMdmrlrqIBtaTlF9VwrNh7eBxH8tjcuBo4Isx4CWUfgCvJa1p0RCjKXWRAFJGUtzjzcPPGpCwO5rPqnKfnLNn6PbQs8CojEwaW5WhluU7FG3o8YCAC9hDHBVVqlq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4r8xJd4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3v0g1l0a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4r8xJd4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3v0g1l0a"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770375119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA2jDBMBJNWRCojORjUifOX6+Gj8jMwDTcaPo1p6gdA=;
	b=E4r8xJd4am3nlGbe9r4CDQD2YUK+g1GAyld8z3KaxY3niBmpNykDD+k/x+KXrJzq/n6qQD
	Hb5UTPVzrughCkHcB9Cm871kLQIPyGd6S5OKFtqpNWJZCzXaLlMLokliR+16/fU4NyGyFR
	WLX2x+4iXzW0PtjihcoQ2qZfXT+zvtn4Vo9OltAEDEl/xXTGBBlViO9G08kHmsU6uKwXeg
	uFYH0e9MWuqaaOT3lLJXR+VAXT/5xVyu2RN68g6NocgxceQ+X0GihfrAPkIaaz6CnGw7K6
	lV6/5vXy15bIv2yrjvOsJg3KKBhPgOEQhwd6mMe/ii23KpLgC3lgoWLC7TnK1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770375119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA2jDBMBJNWRCojORjUifOX6+Gj8jMwDTcaPo1p6gdA=;
	b=3v0g1l0aiObSG/tRdfqHZr1qbUvJ5SjLDpCbtm5pYdBaEgFGlYZnJZbHvY6A8Ko/+sGyZC
	a1Sv3fFb6AFFsjCg==
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ChanSoo Shin <csshin9928@gmail.com>, andy@kernel.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] fbtft: limit dirty rows based on damage range
In-Reply-To: <aYXEHajVeKvIMmL7@smile.fi.intel.com>
References: <20260128203938.962414-1-csshin9928@gmail.com>
 <87y0l668ki.fsf@yellow.woof> <aYXEHajVeKvIMmL7@smile.fi.intel.com>
Date: Fri, 06 Feb 2026 17:51:45 +0700
Message-ID: <87ms1mb0vy.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> Do you have an actual HW to test? If not, won't be applied either.

Yes, a pair with SPI interface.

Nam
