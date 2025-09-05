Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EF315D58
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Sep 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098846; cv=none; b=ZnU0lTfYXZttKSrRHoBCihysMTlY2QYUvMSIyKHzn0QpExLfqwTMJY2uNQslsCTiUPqLZL/wRq7Q31SRdQna8mftvgGHfg/4bxdvnsDqK/F5Hla/yhiDG9psI9GopPD4x2zukFqIRp8mTpxGkYmn6OmWpGsMqxPkXkgJb4UkLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098846; c=relaxed/simple;
	bh=1f4mnsOXQ7KgmwvAXYkamCwcJCovinKQ41PJZyU9ggQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy+O0b3p18ojeDJyc+Jk+rZXePgWciYW52qcYReJq+WVcrkJVcES0c+u5b2xMtQSRDrExB5aS6n5y1q5KpbPVlvfm8oCEcU9Z6zCB8m3g2J3M6zGKzzKqWDWjNHqidMexi2irOz0QuZVQWEH0AFknZDD6XKi5AOLcfE393ye+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=aXe8Ba8+; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=aFTjsHbH; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="aXe8Ba8+";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="aFTjsHbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757098820; x=1757703620;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8+x8qYlJ6YOCtCU6AlXwjgVvVUNmKVQbFdRWmtxYFtM=;
	b=aXe8Ba8+EXOmlohbKSn3PdbgJRATq5rBi0F+b4UiMRrEh/erW9Ec0K0rsIVwcYXpHdN8rbC3rqYNj
	 ih2ofQzs5z+va4A3I/VIu8zjRCoqC6s0mkd6FMStP08WXJRSC9Ltv5VFG1AylPRmGkS3SX5y+iIWze
	 wyiKetO2T2tnSMCS+GNhJvYz1Oy57UBfUZPqTFcUlEL4asMJKcl40aoW1sh3WZkKznSVAjvMMoftVH
	 lACH58bMEgkhd/niu8SqlW/D1BawEsZM8EkbqI9Y3mMDtlJuDMza63EMALJe1to5Yy0QqvGtMKOgHZ
	 lAG96mEbVcmUj9qJ61k8b+RqPA0DuUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757098820; x=1757703620;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8+x8qYlJ6YOCtCU6AlXwjgVvVUNmKVQbFdRWmtxYFtM=;
	b=aFTjsHbHxPEJAbfIEIABcbNISgWWSks4nYGCibeYM2hciTddfN7Yt++HrcCtk8QnDuWSQLOmznphN
	 qEyPwaTDg==
X-HalOne-ID: 90ef236e-8a8a-11f0-90a9-f78b1f841584
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 90ef236e-8a8a-11f0-90a9-f78b1f841584;
	Fri, 05 Sep 2025 19:00:20 +0000 (UTC)
Date: Fri, 5 Sep 2025 21:00:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fbcon: Fix empty lines in fbcon.h
Message-ID: <20250905190018.GC361827@ravnborg.org>
References: <20250818104655.235001-1-tzimmermann@suse.de>
 <20250818104655.235001-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818104655.235001-2-tzimmermann@suse.de>

On Mon, Aug 18, 2025 at 12:36:36PM +0200, Thomas Zimmermann wrote:
> Add and remove empty lines as necessary to fix coding style. No
> functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
