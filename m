Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB663264FB;
	Mon, 31 Aug 2026 05:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155327; cv=none; b=pYVAl9YCJvhImdr2l0NUwe4hMWFtoZk9u2uZ8HlmWjFKct9IORNPv6kfbMbnFzpTtk07Bl0W3Cu/H2I6GwcWuT6vIEJ3Ext/V02YbhmN4+EtVhP4jUzF/bEiYK1G8Zmpi7+yzwXsPgrFvegXWJV3B5n5ILqqNGRFKkkEBMAjlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155327; c=relaxed/simple;
	bh=kQtWvzDxvct6d43ExnmK/y3+kXxwPc5INILG8n+/TEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHbROwt8h84Gi3tVuBvNHbRtjaDJncS5F4I8kADzfE3cr7wJGFyJGzVKLO14OXuKrfe0hZW5v9spf8LJamNEF3vkCjYiNn7AX0E0D8RCzArfNtlxMj9vHvEYQ3i446L5a5cNgJttbmAjKSB8ul228AJGdBMFfSC5lB+FKL1sI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lr+BFI9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lr+BFI9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254AC1F000E9;
	Mon, 31 Aug 2026 05:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788155325;
	bh=2IzguYBaGHJrEbcQ6FGsHCrrRCuT3Z1+IowBs9KVDCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lr+BFI9P67qwYhc3fFJ+jIztr9OijPdIY52YidjuKz0yARTC20RhwsgLG0sZllZsi
	 lGaG4lZZLGNMZcM+FtRZIStBqDGoyNMFDHyo8weEhZme2JGMrLgWtyKbHlGCpCrkW9
	 3ZCN/kyCyEwiMQ5rCqIFbLnPKmjpvNPB+Cg5RRxA=
Date: Mon, 31 Aug 2026 07:47:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: anshika <anshikajain196872@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Dan Carpenter <error27@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: name the no-op endian modifier in
 define_fbtft_write_reg()
Message-ID: <2026083121-suspend-constable-9e1a@gregkh>
References: <20260830161529.14500-1-anshikajain196872@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830161529.14500-1-anshikajain196872@gmail.com>

On Sun, Aug 30, 2026 at 09:45:29PM +0530, anshika wrote:
> Two of the three define_fbtft_write_reg() instantiations pass an empty
> modifier argument, which checkpatch flags as a fragile empty macro
> argument. Give the no-op case an explicit name instead of leaving it
> blank.

Checkpatch is wrong.

> No functional change.
> 
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2602.0/01917.html
> 
> Signed-off-by: anshika <anshikajain196872@gmail.com>

We would need a full name anyway.

Just leave this as-is please, it's fine.

thanks,

greg k-h
