Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7B38F656;
	Mon, 27 Apr 2026 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261838; cv=none; b=JNNyMcuEZGfvYInxA6RKUzxckws+tdq2wtRM0T3X52gwutv00yL/wG/JzRFJP5/aeF3WsTvRF/n5ug7mlIuXGQvRjpkQK4P3PkO5RIyjc6xtbfQgOxBy+4lQccYnYNJTvL3C2Soj5326QT4o768pRxBqKMN9hgQZx6bb+ShCMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261838; c=relaxed/simple;
	bh=Jp4q4Aba5tO0NXoQ27dANrsnFzkNFx35bHs5c8M6S68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5ai9pQ0ORjeAOKNEI4ysEmfeaGqYfSA7k7JkCGHPSzcSLcn5ACDYbI1qHQGZu+kt5ep+LrhYEaswLH+P48p9mWaigdorbni40ZEdOD76fO5SAlUZQPkw7sLTwGvdMmtde9Z8n/ZvHZ8tF67mwh0PIsX9fsTi0blYM0zWnGDDx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nf9wbmjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nf9wbmjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBD5C2BCC7;
	Mon, 27 Apr 2026 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777261837;
	bh=Jp4q4Aba5tO0NXoQ27dANrsnFzkNFx35bHs5c8M6S68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nf9wbmjr8EabGlYyLgUNPDCM9lm0r/8RuAkEu326Cs4tNpYZc0t/8PIEBl0mUVmPi
	 zH5ET+xYFN++2QMUnBGA+u+ay69gMktsERJ//tXFo0/m6JlyozhFiMCSKfrG0zpCM9
	 Jgs+QT8LDtSyNtTZHVn5hLxR3khXWknxKwrIqjyY=
Date: Sun, 26 Apr 2026 21:11:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robert DeRienzo <rlderienzo@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: rename CamelCase variables to
 snake_case
Message-ID: <2026042653-macaw-flatfoot-cd41@gregkh>
References: <20260415030855.433270-1-rlderienzo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415030855.433270-1-rlderienzo@gmail.com>

On Tue, Apr 14, 2026 at 11:08:55PM -0400, Robert DeRienzo wrote:
>  - pvMem -> p_mem
>  - pvReg -> p_reg

Why are you keeping the "p_"?

thanks,

greg k-h
