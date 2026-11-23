Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419232;
	b=YiRgcHCyqWOjByI/VW2WXLoDmpZ7MuDGBAb+fJo+Ps1LE9ta/BYRTyr3HgVUNv32L5W0
	 Y9KZIaeUNLYJOZ2K5aQ/c4fBySUsLA9S6DG4TaBlKYd9eS1iwH4uPiECufoH7DRg+MJa7
	 MrmUxIv5JSXdwzbskKxoDZmVbnoilc5Bzg6CTRRMDsCCeQyVmBDEcNsY52TprKbmy7E+O
	 CNBiYSBfWrIc5+NoLiHU18bjgJrOQrvgHfVapLZeUkxhX6ZYSFlwuTbjKNIM1umlmHa2Z
	 +u3F8iiv7WIQFU8EGva2e/V+Zloep1xDyxDpMQAWKigE9RqCPSh+wY3Cmd4KLtAmy+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vCLV3XBRX2wh16raJXcCmA/lhiX2jHGFoT2tZZcD4OY=;
	b=Q3gRRwfRhbY5fMbb0VBcl3k/vMNkIZ2vz1oDqO37nTp0t8loHlY84/LfKz1EaIS0I/WX
	 IAkQtevD0TaLwfvNiEV2vBbbuAD7l1f8avtRe79QOZLRFDsgvxUWytTN0zKdb94yUQNnX
	 fmGOHrLwrptRE14q6owRTJ1shJV1IioUBvbgkroIy+M62Dib+3H9sxXeM0dYER0Xw+vfI
	 wgmfoW9FcQkafWX4mcELrUi0QV29+sbCMPaYLQHvHx6fV5W9ZU73LAk41fCk2TQ5TyI3f
	 x4ebRA5f1VZMeJXnEgi12p8/RzQ1/04d45rb/nbYAYMuK+oYsYImr7mZAjycWrEs4FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCXfCOp8;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA8606A327
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Nov 2026 07:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6FA8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCXfCOp8
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-497614c95f0so1595180f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Nov 2026 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795419230; x=1796024030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCLV3XBRX2wh16raJXcCmA/lhiX2jHGFoT2tZZcD4OY=;
        b=VCXfCOp8x1ww4uHujrC7pVcFsWm9ll5+3jP0cPhMcx6ttmvaIKksQfsbujU7V5fNfm
         ctHYjnBcBBTT4iIkk6KdbHo5/r+xK4lb54V8TIjrNLqzU9wbBIOxfykFhyr/S20GxGm3
         vw6ND98u4X/U5HRukUPAhHEJhhk9aFDp9aR1TPXRPj/dyuRCe+epO1zbsxgxD23UmWQw
         VXLT/C+Zj5jQtXbZBwee4Rm+x1xJyhFWc3amKhZ7MsIK3o2vwF09ev/Qn41aHXSigxAz
         5swfuCPMclJacJoet/DPjgEimcCUX+Xhri5N3Y49v5FjeDbm0UnBYUI8f+6xV33PhQRt
         SMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795419230; x=1796024030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCLV3XBRX2wh16raJXcCmA/lhiX2jHGFoT2tZZcD4OY=;
        b=D01uDgVRs/aGP5tm1KqyblBKkQq+Z2h633RYy36dub/mBHX1+WWSP06EKJGE5mJsUg
         fgxQGSoT/7Ew3e7jIN1tJxmBKU7PMgK7ZzKaMxcS+SLRleEgPhnKEzmF5NPXO6EylCHC
         XAItyGlcMe+HBtftoWQJL+y7BvYZAPIQQTYWceSHzSsR5g3tKraasBQGMU81QbkGRDjn
         Gm1GuSukDt1lEn4RU8UxROwWsrXhOBEEBVVp5TbZM6ayHWBmVHWHClU7HLDZHxmNX0ZK
         m7EBpqHzGUSj59DNoneaMDd4MAZrFLddltZ5BLLv6og4fxoKOG84Xuhhp2ncsBBJtB7y
         OiWA==
X-Forwarded-Encrypted: i=1; AL+hErE4zeHu5joIvgEDfL4p4DFuLrcYLsCkWbg/hQLIvjPHg2yuyXlKjCgEFCPNcKdFYgpSgOWWlE9FR1z5Ag==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zvlbWtVd04lswtNxW/IfMGSI9y2zEQtdBxFjJXNFHx9T1aIj0
	4i9v/s8RmfpmvvgvPqC8hEmErlR3N2YQOsRgB87Nu0RgkanFOdae2+yL
X-Gm-Gg: AZFdTZcyFtjSfIou/x9g7fS2rHm/rGiE7v+ctbK07KCFB0HLq+JiJg3cThVTVJdUMZF
	OOXFiKCWg7ziF7fWUF7IWm2Pq/M/VT4pNjG5Zqm8ca/XgbfAAOuxwBJaR1m1vOkc5zFSaMiSOVH
	Q57IrkMt5PHeH1hilnAqNhJui66SsjnePqzNBZA5RxsQztUqaVrkIpby2Z3ZLY++OJaq7gQUTjF
	gfuaNDjxNp6DL3gKz6Rjl5OYVnWHe9tb/n12Qgv8hOAJhKThYGo/FEtixiu4uA88cJ/cQRW8ZxP
	G1LkCjyzP1BW5D1Cuu6lgR30nNkFZHCdGQyi0LTBUKOsSEQUVXuZcOqawFnTxMpfpnsv+Hjhg+i
	6C44RlMc56FUtGx1jjCj4RsiOrNUOHAvWepFulQxK7DkawT1Qfqt+XjSmovNKi8C31EMnzK41iL
	7jsupo07IUyvzMaQ/qk8lpzXuj1/8WGIs32Jz0QDHBUPF82Zk6ussgf6F7C8l0GV0uhxyBzE+vz
	nq6HQEMQ80KEpip+Q/SSLM65/QJCZgGgddVKawt43XQFjXoDqbBbkCeKADe36Weug+NRMZEWhCA
	0k2P1IUg+V3dVh9srcbv414DQ1uHTKSVM1SuQ9Jg5HWZ0CWuCT90nPVWUjUfuXGYfEMcsyJ9UEd
	djQ/ve8c0ZzoCisXhm4bv9Av4nfuKYzZhxaobsS9mvD4I/i4jKIzoCiEx2kkhEBFr5qc=
X-Received: by 2002:a05:600c:3b91:b0:4bb:7e4e:de53 with SMTP id 5b1f17b1804b1-4bb8881059bmr259331755e9.12.1795419229774;
        Sun, 22 Nov 2026 23:33:49 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm311285775e9.10.2026.11.22.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:33:48 -0800 (PST)
Date: Mon, 23 Nov 2026 10:33:45 +0300
From: Dan Carpenter <error27@gmail.com>
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Use str_has_prefix instead of strncmp()
Message-ID: <awPsWXOo2MxJcX-g@stanley.mountain>
References: <20261121133843.127718-1-vaibhav.chahar26@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121133843.127718-1-vaibhav.chahar26@gmail.com>

On Sat, Nov 21, 2026 at 07:08:43PM +0530, Vaibhav Chahar wrote:
> Using str_has_prefix() is cleaner and more readable than using
> strncmp() with strlen(). Also avoiding the possibility of errors due to
> mismatched string lengths.
> 
> Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
> ---

Ah.  The str_has_prefix() has been there for 8 years and I'm only
learning about it now.  I like it!  Much more intentional than
strncmp().

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


