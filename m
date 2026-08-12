Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05AB339853;
	Wed, 12 Aug 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540018; cv=none; b=Bq0US0Yjnwo9hHzXY3ItCIFVZAVV4SIRgsN/FFJT6WZHrLFUmeXkGDstGRzD5CXBqXoQFNeCbr4EzOc/11Cb5a4s5P7EBPYUOydfp9gOskbKlflFpcjxfYltryh7LjIFYTBuR0w9sCyLmdHdbEezH3mGR11nS8UOrZldBh13GgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540018; c=relaxed/simple;
	bh=vdBJr5gxn7O42VC+P6uYqBDu1zrYqCmZOIl4oNMT8pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BAG7J2HMr9w0a69MRYnmwtCTOV1HlHdwMn690XH8ZZgCSNmDHoXMzTcgfiJdu/4bfW6AH8pxcsMHXZfoHLvlyf7Gs2HWHFTtFVVhsSlGJnDJWNas+AstLXwO8QBMT+KBxgna4i4qEVfWIv6JhcMPAD1093h/n2cYTM4J8Hfe8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZFTGg3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZFTGg3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195E61F000E9;
	Wed, 12 Aug 2026 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786540016;
	bh=MyS7PpaRGETcm8MpjUovEWvngHvq+Nobqa8lnVwmUPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oZFTGg3YMVCuZfkath0YRWZOpWweDiNeyQt3/w/ORte0cHZyXdgjwuIG3e4OEnPxL
	 Yqp6uupuCFAI1snXkA0hJiQfWS8rHuU4T/7eWXQXBgivqKDMxFhorLikDvuirBr8zq
	 G4/936rx/B1bsznpMQieN0Hzg9lO96d1RlQKnAKqtUxYOkO60/na6RQZzIgcouQE9w
	 MiKN6+QcFods927UMYN8RAPSIGpwTgumezJKboy+DiT2Nc2nXbmtQymhLWwxNGMDKO
	 +/XushZ57XX0ZObmaXTklklyD6Z+y8etl1wY53F4h8joYXquTeEE3SALwUYnY9TuHS
	 GqB4cwHaXB1GQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, danielt@kernel.org, 
 Levente Szajko <raedrimhun@proton.me>
Cc: jingoohan1@gmail.com, deller@gmx.de, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260805135027.43890-1-raedrimhun@proton.me>
References: <20260805135027.43890-1-raedrimhun@proton.me>
Subject: Re: (subset) [PATCH] video: backlight: Use sysfs_emit() instead of
 sprintf()
Message-Id: <178654001483.1417099.6589190686367824325.b4-ty@b4>
Date: Wed, 12 Aug 2026 14:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 05 Aug 2026 13:51:39 +0000, Levente Szajko wrote:
> Replace sprintf() with sysfs_emit() in the sysfs show callbacks of
> backlight.c and lcd.c, as recommended by Documentation/filesystems/sysfs.rst.
> 
> No functional change intended.

Applied, thanks!

[1/1] video: backlight: Use sysfs_emit() instead of sprintf()
      commit: cf1a12e0804515e0ed8b3f50c1c32f7f425bd660

--
Lee Jones [李琼斯]

