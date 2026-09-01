Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67832470EA8;
	Tue,  1 Sep 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255402; cv=none; b=KbSdm0ZpZYww1nKPLYwTiti+RT+WHZ4wds6MPEZCGusRXOuFa1WpEOitcJdsolz6jPgb0voS9oOGg2guVujhdA4SYE3fq7hhgNEQIMX6jJaNnMcLVFZbKzedfTSAmKrTHVdSr9XevLp60L1G10FbKI+diyJwfnBuuw/cRmvRmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255402; c=relaxed/simple;
	bh=BNIk1/0Nivps9zqYv38le8dQlnbkCDCzNAd1E5wM1h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imh7oP3a0a3leZg5XtUy/nrAWrlPG0sea77Jc2l5/3AghgoBW7InlzvEO28e1TiZR7VXwg5BfPn5xjf0g6Fa5cJ8Si4KA5uaS5mxJ5GJ8Fg68paMGASukNfOeyEBpnf4cClV2w0cBH3QO6GptlWGp7vqQD8xgXAwhPYlU1/rp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HMeV6XQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HMeV6XQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B591F000E9;
	Tue,  1 Sep 2026 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788255377;
	bh=5jgcT3Yq7lUVoqN4EhxE1/y2qTwdMpwg9lXcUmwROaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HMeV6XQkiXsF6YNxyQukaRj9MhfTg5Z0gvrVUAK6TIKpwvT3MpCd3vyE7ZcpyiG79
	 tyDokR7KUTEb2HuEn1UNeSG31rxqmxcFzdPfqsIyznaNw9mKMyG8R/px7MHNkHGGdD
	 ySSDJiDgJXb2RGAriZb9MZebKW3sCn7drPWexqN8=
Date: Tue, 1 Sep 2026 11:36:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jaiden.linux@gmail.com
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: sm750fb: rename CamelCase variable pvReg to vreg
Message-ID: <2026090141-wooing-outward-ef9b@gregkh>
References: <20260821151525.54751-1-jaiden.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821151525.54751-1-jaiden.linux@gmail.com>

On Fri, Aug 21, 2026 at 11:15:25AM -0400, jaiden.linux@gmail.com wrote:
> From: Jaiden Magnan <jaiden.linux@gmail.com>
> 
> Rename CamelCase variable pvReg to vreg. This is to fix the following:

Why "vreg"?  Shouldn't it just be "reg"?  The "v" means "void" which is
what you are not needing anymore, as that's known by the compiler.

thanks,

greg k-h
