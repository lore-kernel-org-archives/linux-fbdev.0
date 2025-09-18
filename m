Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41D23C507;
	Thu, 18 Sep 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213457; cv=none; b=f5GHPNNLLUlZnZ0EonDC0sQ4ywxk+JSH13Fu3Zfvn7h40SsELYpJZog8iOYnWyheU9S4JqRW7DgCOiASJLdhjvgBkPvFONwIP9MWKH1IS/MWTMmFPK8CerxKoCKYUX+dw4+3D0TP4Z14l+zCTGZGx2ULgy1gK0wLT12EPD3ELvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213457; c=relaxed/simple;
	bh=IrcnXMaTqy1N+7c8LcrUly8rrgilMMAu8XxmYF2RPGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Thz2oko7s/ZwHWZ2942vF4F1FPv/v0IVHsg5TmBv1A+vsux+gR1igpb1QslpVwGR+dSZvdSu9hS6vJLRWTgfmN4jsQIWx4l5CQTigoKxXR3rUd/qdTKEMF+qcJtyvF0hBdckaXBqSIuy1FfAMkRJ6yxnVQHg8hYQccnG1NTagy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UZe0w0rR; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UZe0w0rR"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9B9A7406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758213452; bh=L9szdGSNdMCYHon3m7+1Z2PiMa4HJ7fzR+DoUw4hOfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UZe0w0rR//C5WKDhbukAj2qlgSg/rU56cO6rvaiGFwP/uT4FFlW8UIVV/9YBsuYrg
	 5qk5dKpWfcpfSP3CTQ7q7r/mVnt508nGlFlPTnXeeft3vcXX18CRLsofzDHkdyIQ2m
	 OywnBGNUlK776a614F3K35+7kyV2Ly/D69LgMOUMiEzPnUNjgOfCa443W93Tkhv9zf
	 5I5xDIbRmZPhDefm3NJNGyGtOkOJJkG/fN8sdUyj5RzMYWanwS3lh5COBrg+QW0s7D
	 b39J0Bp/AEwKCzKst8Hw1fstBf/fYJ1kanIsvCTr18qmXs3liZPQbDjYns8VrC8vbr
	 Gr24tuugLYGXA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9B9A7406FA;
	Thu, 18 Sep 2025 16:37:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Framebuffer
 <linux-fbdev@vger.kernel.org>, Linux DRI Development
 <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/3] Documentation: fbcon: formatting cleanup and
 improvements
In-Reply-To: <20250909063744.30053-1-bagasdotme@gmail.com>
References: <20250909063744.30053-1-bagasdotme@gmail.com>
Date: Thu, 18 Sep 2025 10:37:31 -0600
Message-ID: <875xdf90ok.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Here are reST formatting cleanup and improvements for fbcon documentation.
> The shortlog below should be self-explanatory.
>
> This series is based on docs-next tree.
>
> Enjoy!
>
> Bagas Sanjaya (3):
>   Documentation: fbcon: Add boot options and attach/detach/unload
>     section headings
>   Documentation: fbcon: Reindent 8th step of attach/detach/unload
>   Documentation: fbcon: Use admonition directives
>
>  Documentation/fb/fbcon.rst | 42 ++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)

It looks like nobody has picked these up yet, so I've applied them.

Thanks,

jon
