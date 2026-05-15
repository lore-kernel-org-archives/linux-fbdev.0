Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4130C368;
	Fri, 15 May 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850797; cv=none; b=JLAU/jmtayWkms5nZzZRdzA/3RYCIWuF1b9PTZFS6WtBDLoHqvLCxmUWmUtTT9X48IsD5jKdwY9gFznAwFIzTWFnML3m5tMb3gAqOdx1XVI0AQl+uXSdkR0v/ogmSVRzcFy4vP+IHg580UDHQ9kOnIvfbKodqOrm8jIxT3rVTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850797; c=relaxed/simple;
	bh=xWRkjACXBG1Nhb+LKZ4O5ZTV2Fz4GwRvKGrQv2zDb/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4UR5RgYawR1PNonvkQ1ah/onsK12VPcXtG2rYj1trtlYvlp3Y9Um85wfN2jj8hqPPYBgq/pcre4mr0rKTjgDQ7esVKVNwSZx9Etmw+Fwz2kwczzIl+Vwm0n/PH7RyqauwmXUlUd9BkZbic9UN3+cZJ7EW3/VOzd7B0bMwErrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8bx+o93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8bx+o93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A7C2BCB0;
	Fri, 15 May 2026 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850797;
	bh=xWRkjACXBG1Nhb+LKZ4O5ZTV2Fz4GwRvKGrQv2zDb/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8bx+o93NNbWo+ZbR7JVbAoGfd9GjVeOQcRlkLAaFIeB3gzGTGm1pw7fSi2zV6ja4
	 0tRowl8+WgoYEqD17b06r9lYvoyuAyFfJXz8Xb1/+23y7fsE3owPtI6UOQcvLhQ5Zf
	 B/F5JoViUNFh2oiuCzPIyBN53aIZpKVa+Qn2zmQE=
Date: Fri, 15 May 2026 15:13:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "M.samet Duman" <dumanmehmetsamet@icloud.com>
Cc: Ahmet Sezgin Duran <ahmet@sezginduran.net>,
	Rupesh Majhi <zoone.rupert@gmail.com>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750: rename CamelCase variable in sm750.c
Message-ID: <2026051510-marbles-last-b661@gregkh>
References: <03e9e75a-c63c-4a63-88b8-2287daf6c4ad@sezginduran.net>
 <5A8D2A45-3C03-4D41-96BB-4F2ECC499813@icloud.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8D2A45-3C03-4D41-96BB-4F2ECC499813@icloud.com>

On Fri, May 15, 2026 at 03:59:18PM +0300, M.samet Duman wrote:
> 
> Not a change that will set the world on fire.

Please only provide useful review comments.

thanks,

greg k-h
