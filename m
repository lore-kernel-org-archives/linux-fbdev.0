Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC02C187;
	Sun, 21 Sep 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758427740; cv=none; b=nnr1IbtsSSvr6JsEuNzUOKE2g09gEoQPpUrnCwG8+WkOBv/HThG8ogaqe8ucAV5D+j1AjKir/FUKJzwBqdivk5Q2UIrnrySC2effwW3ljMRd8r439yy2gxekckyZHL2JyKSmwEiXrrGyhg6a5PUxAZ8B0H9SkE69PcJPTGy3b58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758427740; c=relaxed/simple;
	bh=pk/MDwtIt50lYbUkZEHIcUUnRHIiLgB+b9uTQ9baskc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVOvcvWEOYPl5vzb+QJjt3n7h3n4iVM9Uyr9LhItQS7nIPqNvVSqNraZICexR4NVmgfk4gcs9+IARbactCe4j5XCamXyHLbwHmO+pxhj3wDypTI7jCirJkSpgdf9WzKUnEBbkPIWGdTu61ezRCsQC3p8mP+2SEYg82oyzj7cEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NVs/xMzu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NVs/xMzu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=uZy4lE0W2i6JOY3YpgM9YvBZoVT5j3/cDuVy9Tqt69U=; b=NVs/xMzuhLqWzvjk9aJtv3osGj
	yW/2U3K29Rwfhb8aqEo0KvQKZIDKljYztHK8shHPy2PFu941/9qT/0/DdKm0rDXrU1iXb3K/D0Inf
	64pzlNcjmbByypkXhSpDfLgqQlzJxCrZd7LAe6/YUQpl+1jdwF8G2yqGQPjdcPOCHZ2Llwd0NPl9f
	P/xeqCsDFUauxx/DEbdKitk3QWv2JGg0be0zHjSH7mgbCXUkF2rMzIUnYDoWgxOTg0QEHTcLwcL8j
	TrPlqqo8KrdGMjgNSuQXHk229el5e8j6kZRmzHUpTAfrguinbU3ShxjioZVgao4h6bioVl4X0O0mG
	0nYvdAeA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0BNe-00000006VSD-0Cck;
	Sun, 21 Sep 2025 04:08:54 +0000
Message-ID: <51ccc0fb-d17f-45c9-984b-65b9e2d0c4ac@infradead.org>
Date: Sat, 20 Sep 2025 21:08:53 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Documentation: fb: Split toctree
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Framebuffer <linux-fbdev@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Bernie Thompson <bernie@plugable.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>
References: <20250919003640.14867-1-bagasdotme@gmail.com>
 <20250919003640.14867-4-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250919003640.14867-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 5:36 PM, Bagas Sanjaya wrote:
> Framebuffer docs toctree consists of driver-independent docs
> (e.g. API docs) and driver-specific docs. The latter has much
> more entries.
> 
> Group the docs into separate toctrees.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/fb/index.rst | 80 +++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/fb/index.rst b/Documentation/fb/index.rst
> index 33e3c49f885695..e2f7488b6e2e42 100644
> --- a/Documentation/fb/index.rst
> +++ b/Documentation/fb/index.rst
> @@ -4,42 +4,52 @@
>  Frame Buffer
>  ============
>  
> -.. toctree::
> -    :maxdepth: 1
> +General information
> +===================
>  
> -    api
> -    arkfb
> -    aty128fb
> -    cirrusfb
> -    cmap_xfbdev
> -    deferred_io
> -    efifb
> -    ep93xx-fb
> -    fbcon
> -    framebuffer
> -    gxfb
> -    intel810
> -    internals
> -    lxfb
> -    matroxfb
> -    metronomefb
> -    modedb
> -    pvr2fb
> -    pxafb
> -    s3fb
> -    sa1100fb
> -    sh7760fb
> -    sisfb
> -    sm501
> -    sm712fb
> -    sstfb
> -    tgafb
> -    tridentfb
> -    udlfb
> -    uvesafb
> -    vesafb
> -    viafb
> -    vt8623fb
> +.. toctree::
> +   :maxdepth: 1
> +
> +   api
> +   cmap_xfbdev
> +   deferred_io
> +   fbcon
> +   framebuffer
> +   internals
> +   modedb
> +
> +Driver documentation
> +====================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   arkfb
> +   aty128fb
> +   cirrusfb
> +   efifb
> +   ep93xx-fb
> +   gxfb
> +   intel810
> +   lxfb
> +   matroxfb
> +   metronomefb
> +   pvr2fb
> +   pxafb
> +   s3fb
> +   sa1100fb
> +   sh7760fb
> +   sisfb
> +   sm501
> +   sm712fb
> +   sstfb
> +   tgafb
> +   tridentfb
> +   udlfb
> +   uvesafb
> +   vesafb
> +   viafb
> +   vt8623fb
>  
>  .. only::  subproject and html
>  

-- 
~Randy
