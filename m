Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B864A126C17;
	Tue, 30 Dec 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099089; cv=none; b=WC721+kY0LDmLla/y+HiwadWNRx2q9sbmli73QFQUilr4QWEwh1VhGAJ5kZPvAEAr8g7/h6HVFmuR5eefzZDxggZxLvTIUP6DYyqXYI5dAOL80Pn6jlNpSf2IQy5qbTJQZ7HRuobIWIjqiJeqYoYXfSESa4C0Wy7dA8c8gcmAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099089; c=relaxed/simple;
	bh=pWDH+5NEnkimmrlnsAXZkBHDyve1rIzDnIC5maRNCSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzUxLI2rq4DWjTkdYF7zx6PctLd2CoUyej0bCO4h6fPSIKL/1lonrF4lFcAMj8gXhGJPpj2Ai67FyyVQ7F69hA5050enVnWmSJ3ARdcml0FOMIOEdZ7wEJxrLJKYGzZqPbihE14QMi9D/dEDleE7d6U6vVZuFUeHQxkk6rR2c9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pZJoA+5A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pZJoA+5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C66C4CEFB;
	Tue, 30 Dec 2025 12:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767099089;
	bh=pWDH+5NEnkimmrlnsAXZkBHDyve1rIzDnIC5maRNCSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZJoA+5A2Ec1S5averMi/D9E4+MooOZQbfEgP5cbMPvPUlYoncw9casT3OutaO64r
	 QSouSHdE2ZIYuJvg04lUM0ZSPO/NAcuj4cueTd/+4r6ZNEXSQp3HdlD3JhA19dUVns
	 8drVUyDvD739zpdUwHs3colteHsZmz1wew1AfFIo=
Date: Tue, 30 Dec 2025 13:51:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Motti Kumar Babu <mottikumarbabu@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix const array warning
Message-ID: <2025123057-waving-chasing-50e8@gregkh>
References: <20251226120417.2599020-1-mottikumarbabu@gmail.com>
 <2025123055-procurer-prodigal-27b6@gregkh>
 <CAC9bbDKw-TGY81wecEnmhbMror0R=y8McTJGU5CPRf2N8UM9fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC9bbDKw-TGY81wecEnmhbMror0R=y8McTJGU5CPRf2N8UM9fQ@mail.gmail.com>

On Tue, Dec 30, 2025 at 05:42:43PM +0530, Motti Kumar Babu wrote:
> Hi Greg KH,
> 
> Yes, I have verified this change with a test build.
> 
> I ran make defconfig followed by make M=drivers/staging/sm750fb/ on the
> staging-testing branch, and the driver compiled successfully without any
> errors or new warnings.

defconfig will not enable this driver, are you sure you actually built
it?

And please do not top-post, or use html email.

thanks,

greg k-h
