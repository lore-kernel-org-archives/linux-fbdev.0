Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF777315D53
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Sep 2025 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098809; cv=none; b=HuwSFYOr8BPos0JjkO8bRIfGC2tS56brGI/PJw9wSAvnI+rK1oo/SVhDQQ1a7r8bU3gRXnoH9cVXyujBqRv4Q3vwVFUdGhxji0hLclkw0HFvHJCh1WXj7qMD/tRJ09c37XJD3MYRU0pxaboL2JPWHo+Km2z/Fv3IYuO6alCdkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098809; c=relaxed/simple;
	bh=thEZdFeLXJip3yqpjsVA3CWQcbprbvYjUzKiDdInuzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fktiTK7NunfbnsqSuc+eY3XEcFFxkc4p4WzYNQy5Gv2oBfr2j01fHzeNPyeSvioRsolH9Xy132MUuiatmLlo0Bp7LQeuaA1nIObe59YnROpA8MJuknl+TsMarFb3jzgl8EUtOtKTF7BYQebRWu8RNLmmR6dIe4qqfEtQIm8rS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=I3evI5I1; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=eqfvFgdk; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="I3evI5I1";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="eqfvFgdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757098806; x=1757703606;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=3RnS1e54ivd9kB/TFDUWHec2itsLvhcO1ZPy7N/F1sI=;
	b=I3evI5I1eSIAGHE07seSuya5Ufy7lXw4rQvwN4YEAy01A5T6uCJRulLvE4ZIs88MfAbteiZDKa2r7
	 PouRyN9RLlbHjEGvCF4CtxmhD0hQS6/ZaqKaWzZGo+Sd5JcaO/NeUVeyRjl6Flk0jTP3uLS4NQal98
	 kuCi9patGqEwvweGHjbJtoWLE5XKys2ERzcl9PWtxYGuvtuQ8e6H2xsI9mluc2dqGMYzyJ5/47JJ+I
	 2NXoj1Cp10NobVSdqMHJPXZGZc0swZcLdpEsPVipQLuEHPqdflKBYNDC2PWKrytxP55/xVIdPX6LmX
	 OGMcrJr+5SESGGEqk7/TsZYYIXPw3qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757098806; x=1757703606;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=3RnS1e54ivd9kB/TFDUWHec2itsLvhcO1ZPy7N/F1sI=;
	b=eqfvFgdkcvzKsdYst/gdx2uq3hs6GexJDcHVSjhP0oxUYOzfLgjIw3BktuM0e3WE9RB00rHfQzlkD
	 9CYgf7fDw==
X-HalOne-ID: 876781b8-8a8a-11f0-8467-e90f2b8e16ca
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 876781b8-8a8a-11f0-8467-e90f2b8e16ca;
	Fri, 05 Sep 2025 19:00:05 +0000 (UTC)
Date: Fri, 5 Sep 2025 21:00:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fbcon: Pass struct fbcon to callbacks in struct
 fbcon_bitops
Message-ID: <20250905190004.GB361827@ravnborg.org>
References: <20250818104655.235001-1-tzimmermann@suse.de>
 <20250818104655.235001-7-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818104655.235001-7-tzimmermann@suse.de>

On Mon, Aug 18, 2025 at 12:36:41PM +0200, Thomas Zimmermann wrote:
> The callbacks in struct fbcon_bitops are for struct fbcon. Pass an
> instance to the callbacks; instead of the respective struct fb_info.

This looks looks like a pointless change.
All the operations requires fb_info and needs to pcik it anyway.

	Sam
