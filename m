Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08591373
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336300; cv=none; b=tudOGH6tL/aH/nTH9Ph91Euvw7Z9+Z7k756C/pRR4dw4WOVZDGwMZZ0oKue3/R5NMFd6VDjFaN+jRK7wADy0C60dGrR9EUr0dPw77pZr+7hiwLRSKh0sD4TgV54H1RDrEiiLgolZ3kntjPg5ChKTKOD3/T0L1fqs6FbK0XANQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336300; c=relaxed/simple;
	bh=qvbP0GGWheXqryRE1stVEc7b6SUWhDa6wK7t/cEozCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B2zZRat1o4fDlXAqJLf6pvYfxQEO8917IpxDPY0lzALdlGv5VV/MPJ92eiuPUDtizq3qDAOaAuy6oDF2qIUjXtDaPCQKnwFtfhNpeIYyekXCKwq2NESlFrPHd8DxkBMrL5hwB2Lnh5KY8b8A5Mtfy8wW7eegBSgN/d/W/C1rjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
From: Nam Cao <namcaov@gmail.com>
To: ChanSoo Shin <csshin9928@gmail.com>, andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, ChanSoo Shin
 <csshin9928@gmail.com>
Subject: Re: [PATCH v5] fbtft: limit dirty rows based on damage range
In-Reply-To: <20260128203938.962414-1-csshin9928@gmail.com>
References: <20260128203938.962414-1-csshin9928@gmail.com>
Date: Fri, 06 Feb 2026 01:04:45 +0100
Message-ID: <87y0l668ki.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi ChanSoo,

ChanSoo Shin <csshin9928@gmail.com> writes:
> Instead of marking the entire display as dirty, calculate the start
> and end rows based on the damage offset and length and only mark the
> affected rows dirty. This reduces unnecessary full framebuffer updates
> for partial writes.
>
> Signed-off-by: ChanSoo Shin <csshin9928@gmail.com>

This looks useful and I prefer to see it applied. I understand lack of
testing is the main obstacle. Are you still trying to get it merged? If
not, I can take over.

Nam
