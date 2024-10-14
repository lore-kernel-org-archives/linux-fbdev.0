Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928751D0B97;
	Mon, 14 Oct 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937941; cv=none; b=n2YQzPTTTMh8QzL/9TGugSwBisOEyE23LsiZXBWAtoGcggiDvIj9Xjfj0GiK+AnIDk8QavKb76lBMgoCcYB8NgE2kphrT6d/Xqy9ph968IWy82rDsshp8mqZujwZ0ETA3R4Uzut2cUozE3jYLQoBRr2+fwjzI4v4OY5tdIcfuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937941; c=relaxed/simple;
	bh=HKZPSOG9u0sMSXG8JPGo2vbDiuULagl+e1CsFJwrvdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di8MGH5sCBb3y+SmemmNvwL1OZkI0m5xXBeVxfMBEnJt8HvwjTQy+21K3mBFjvWYr6HTdRCloYq95AhyQE7vCXrOTk5Gnb8YkfOtniCLgVLguArl4C/9q6dfaZsBJQDFmjLhce5WbDb3F0CIvTSo3Clvscq8mMEHqwkSIrQURXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KsuihtDY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KsuihtDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728937934; x=1729542734; i=deller@gmx.de;
	bh=ouPa/eowB9jLl4VY4WQM/q/N495B53tdPkxq+TDntcM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KsuihtDYpnYKeckT/S/qF3l8iWAkb8/IdfdYr/RepvKPLxvSUS0KjMleKW5lLreV
	 w2gph4lqRAJ1ZI9mhmYD14t6fqYcYmg69xPu+bL4QwuQYIkyf+Shkvts3KbMbsuHI
	 oPqcNA6pgiKNOAFBwR16476DIhOZ+eD6JciGkdqot7cBOKqGGbGH9kLS61tgJfxYB
	 T1x2GXum70axWwmCakKnxSHr4ozz9vkEwYJf80g7JbrcuZb/mIwoWrjsIqhipz+1c
	 FUCE7DF/2c6L9EsDGLhzH5peMX7Ya3Kvz3iOpySjqeTBG9qdQNXSm2FMFd6Y7Gq2m
	 26PFT+blKMR9HbHo9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1tAHVi05PQ-00Bx96; Mon, 14
 Oct 2024 22:32:14 +0200
Message-ID: <aa4bf800-1bd9-4af4-8403-aa9ff6d30ae1@gmx.de>
Date: Mon, 14 Oct 2024 22:32:13 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Constify struct sbus_mmap_map
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <67883bfad5c2c395438bfcef7a319394caca4155.1728820047.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <67883bfad5c2c395438bfcef7a319394caca4155.1728820047.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QV9ejFkm+fuf9o/1WeaP3AyqUgGmGSyP+CHW6qaUC2nAhVB0Skj
 Gye27Ca9JUvAhLeU+OwapNp4WvKKE7gS5dhhOIHDq564iXDHBoTHX4fkVKSHEzpnplqY6IH
 4eVf1Q1tDLfxRQ6XxZxBn6oWR40Pax4NLcHFZAeLjVTqDcDMJX5IvRrbEclhMK+mNeSBkbD
 XHtm2TfEFQdjnhaob/sVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WKGoH/5C9d4=;BU0ncBC0qWmq8cwbXTWISXnA2nJ
 NRoIMPs8TiVbFyjkDla/s1s7ww2qLARQxD0Thd6d8ibdpH++7LHboLLt+jIKHwkuzS8RXWavn
 5k9CE7tYgKSnE5VrxqEdMfsC6euC5I03xpoBquk7Vox52zAt3CyriM0EMcsBMCxuyZpQFq1VJ
 3u1nk6AC31QTJxhHITb5d+bTTL5xlfvaaDNx2GD0ZFnzdsUwiJA+k9IhxC4sizYYv/ipScd9O
 RPlRrb99lxn/eTPVaNAjWelTA3N2xfo2PviYqRLSjhyJ6yZoI9zOTblmoSa1TqSQIqmpPo3Q3
 CjLi1LyvWsHqjecHPerwOzCmB5lNdfaOUoypaEXUBuLv5+A0+lV0TWDN0jiYUR3EURZsHZ+98
 SV09DgPtN/ORLKzP9EE+8TlA0yDZcdMnAHx78QVek3x217uHJpNLu84CPxzDPzg5TG+DWsLIC
 PqHy1d9YZiDGR2oelDmeRcgska1vFTJUDplBZoAVbXTCK70A0wd1Ic2XBVjWuba5DAxaEupH9
 pbgDkAXFoELwkXWeoaA1UZ+UTJ0csLJzLrlBIXnGM48ktGUQ373YMnB3yH4/YwLVF3W5rw28T
 3bvicGU78LlL7o22+te/niTgCxeNknnCH6pIocMECZ2NhCZowBh8pxXyj+S7C4OUvFnjVfhyp
 mLYSwLUTq7Horbg0IWhnFYC7ycvTL+hpr5j2Ry/byZ/Ko6rEJUuasSJwiTt0GufcitBUQYX1q
 7oZVTeYtM1BnE9KXWx4JIefDHzY46ZG8RNkPaifym+nqjcLMQQxQPPWL6GP/gkCdZ2YoPyVfU
 V9jS6BbWJQCibc/V04RSVtpw==

On 10/13/24 13:48, Christophe JAILLET wrote:
> 'struct sbus_mmap_map' are not modified in these drivers.
>
> Constifying this structure moves some data to a read-only section, so
> increases overall security.
>
> Update sbusfb_mmap_helper() accordingly.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> =3D=3D=3D=3D=3D=3D
>     text	   data	    bss	    dec	    hex	filename
>     2452	    536	     16	   3004	    bbc	drivers/video/fbdev/bw2.o
>
> After:
> =3D=3D=3D=3D=3D
>     text	   data	    bss	    dec	    hex	filename
>     2500	    483	     16	   2999	    bb7	drivers/video/fbdev/bw2.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only with a cross compiler for sparc.
> ---
>   drivers/video/fbdev/bw2.c     | 2 +-
>   drivers/video/fbdev/cg14.c    | 2 +-
>   drivers/video/fbdev/cg3.c     | 2 +-
>   drivers/video/fbdev/cg6.c     | 2 +-
>   drivers/video/fbdev/ffb.c     | 2 +-
>   drivers/video/fbdev/leo.c     | 2 +-
>   drivers/video/fbdev/p9100.c   | 2 +-
>   drivers/video/fbdev/sbuslib.c | 2 +-
>   drivers/video/fbdev/sbuslib.h | 2 +-
>   drivers/video/fbdev/tcx.c     | 2 +-
>   10 files changed, 10 insertions(+), 10 deletions(-)

applied.

Thanks!
Helge

