Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151114137B2;
	Mon, 14 Sep 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378427; cv=none; b=dYdeizOdxnPHSYA96kBXufd2nBBPKWF457D4P8tVwGyYXo+4bVxFtsuYfpAY3b+lUJQG1I8x1plm1DFAOXzyq97v24XJ/8x0HhKmb2BvzaDNYHQZQx4PxppalmKJl/g5wkqzdbW18Z3sWAaq9Coi9c9T4xSXGvLu26FiC6xSaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378427; c=relaxed/simple;
	bh=XRluEFwTPcYoLep+o9aKGbp8Aas7pyXwRt4+3D5oNXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvbgejTa7S7IpDF+n35vJ6SYTeyZf3xs7MvnYo+Uh6Ccf3flah/QpZbabQ8xjECtogzRQgyaXjEE1bJVh4ki3Co4kFNDIU+X8Xy3yD5L2r7rTqA1XxiCCd2AXMcYF2IoVV35dipcbnqB6d+F4SmSw4K/9ryxehsmKQfAfzgMayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fOsNHGwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOsNHGwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188F21F000FF;
	Mon, 14 Sep 2026 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789378425;
	bh=QHBv43bKUeXfOEgkXZvi20WRU/bSrjEFSZCrzLi8H7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fOsNHGwg2HUqkjWekRiEq+9vvDRPXg3aRTW2MVsTfyfE8tR6C26RTcAVoVfKSvXJc
	 PO3Q6GZTn2Fjq8H/aJqICaPwJ3RXyJkoBy8+ohDbvgsJNEiI2Y5SMt76Yq2iwHF2jN
	 z0SOxACOZJ54i+yXA++te80BbqSGXOXf25dvnlS4=
Date: Mon, 14 Sep 2026 11:33:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: sort includes
Message-ID: <2026091405-headfirst-disarray-5893@gregkh>
References: <20260914090732.9712-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914090732.9712-2-manuelebnerli@mailbox.org>

On Mon, Sep 14, 2026 at 11:07:32AM +0200, Manuel Ebner wrote:
> Sort header files alphabetically.

Why?  You need to describe why something is needed or being done, not
just what you are doing.  Please go re-read the kernel documentation for
how to write a good changelog entry to get more examples.

thanks,

greg k-h
