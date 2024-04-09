Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A54C85;
	Tue,  9 Apr 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684181; cv=none; b=B+4jS3AxcE6tiLqRRMaqpd+tdOsN7OnprbZ4VoXb0+dv485db1wRnZCGjJfM3ABWKe3OeU5nXKHdbQ2K+EtYzJ4ZxmJwaQWwXBVPYHO7NvuGPhqP5ZKMe8GgVK6xV3/AEjOx7GxT2ul6XDwDzE8qe2ZzQUMbocsDNMQQEySzyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684181; c=relaxed/simple;
	bh=ctYYelSWdAbGCcmFP8PxFNfYiOWz9BWYAT3DYWAexmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vooty16q4da2Ljpce9UbNbpfSqMTcK9t6InOGvGg73hfpJD1PWMwPDiUS6gD/VHpuiZFErYNsyynjHRjBCao0F3tHPzqQiUhEhIuLy9oCW7BsofUPq7wbcva8eAvJ0qyGtICXu7OUIHuRZougjuPULZigMEesiKyfHr3fNvUMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b/cQhxO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/cQhxO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DA8C433F1;
	Tue,  9 Apr 2024 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712684181;
	bh=ctYYelSWdAbGCcmFP8PxFNfYiOWz9BWYAT3DYWAexmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/cQhxO1WCMqOnY9S4uycJMmiWsSU27lO1Odqne2KmjIxOMH3VRTRQQP7WYFnQd5i
	 gAX43/tQ6c0/tS9IgS3rCZiFzng3rwS5WclyNj6yZtePuM0+powxiYSeyWDcNqZywd
	 MtStHw7nBiBxDCc74LGqve83c+xGGxQ01HlX8fFM=
Date: Tue, 9 Apr 2024 19:36:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuguo Pei <purofle@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fb_st7789v: support setting offset
Message-ID: <2024040938-balcony-catapult-5c10@gregkh>
References: <2024040935-naturist-skimmer-391f@gregkh>
 <20240409172806.8527-1-purofle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409172806.8527-1-purofle@gmail.com>

On Wed, Apr 10, 2024 at 01:28:06AM +0800, Yuguo Pei wrote:
> On Tue, 9 Apr 2024 17:49:25 +0200, Greg KH wrote:
> > So you are now hard-coding the size?
> 
> Yes, the change just helps developers who want to adapt to different screen sizes.

So there is no change?  I don't understand.

> > Is this always going to be 0, if so, why need it at all?
> 
> Not sure. For example, when HEIGHT and WIDTH are 240 and 280, LEFT_OFFSET is 20 and TOP_OFFSET is 0. Different screens may have different offsets.

Then why is this needed?

Don't make changes that are not needed by anyone, especially for code in
drivers/staging/

> 
> In addition, do I need to resend the patch to modify the Signed-off-by?

Of course you do :)

