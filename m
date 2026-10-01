Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6C3B3891;
	Thu,  1 Oct 2026 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833710; cv=none; b=UmyDQxu1TcQonzD6l/U94zNaXawmhG2hebW9vN6n861uUqsFjOg1uf1dkFuiSTd2C0Wuf1uHikS/yRBSPP1e06RQkPmAie5BQMA7WdDJBR3xi7Yfpt2jXF+r1qiTGE8GB5brBl6cKn1aZuVKbsxov1gEkdH2x5qb6DWCBaeIvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833710; c=relaxed/simple;
	bh=vbmcZ9og6rzPMrDIVulGlJhfVrNhVTw95/Mg17KiIGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl0RIb+SO9yFIYDzlNRnx0uO6X9gf/UqJxfPRDk9m7PwGB1Vuc9K0bplYA6/r0yLMsq0RRxHtKFtqI7GmLFYw3EZO2nS01grEmMri6UfEHT/WpeDLqjxPGe8AguYqIe7DLlAdIJRy+T4EiPQnwbCoYUeSbiBJVJCIXBdoeUkhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRxVvnWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRxVvnWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7998C1F000FF;
	Thu,  1 Oct 2026 05:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790833709;
	bh=rxaQjdoY+1bi6hqiNi4qwS/wakOGNTdHYMk/okiim6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRxVvnWKI3lksECHL11L5ytgpSKroAEy1D4Yr/QjMZ3AUhZGNuVV4XF3C1kf8Bfo1
	 hCEJuTlyl2hhcXcHdlbS+x6PDzRdM/oKyaxrh0hXrYuyW89OutOQqZ0KdOyTtkVPQd
	 9yE5MqX7rH3MEGvJjOjZXPY6Y5kDArOIqFdQIGw8=
Date: Thu, 1 Oct 2026 07:48:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Omer PALA <palaomer100@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove unnecessary parentheses
Message-ID: <2026100127-fifty-wrought-2d30@gregkh>
References: <20260916090145.34881-1-palaomer100@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916090145.34881-1-palaomer100@gmail.com>

On Wed, Sep 16, 2026 at 12:01:45PM +0300, Omer PALA wrote:
> Remove unnecessary parentheses around equality checks in sm750_accel.c
> 
> and ddk750_swi2c.c to clear checkpatch.pl checks and improve code
> 
> readability.

Why the extra blank lines in the changelog text?

And no, this doesn't increase readability, now you need to go and
remember the operator precidence ordering, right?  checkpatch shouldn't
be warning of this option in these files, are you sure you are using the
latest tree?

thanks,

greg k-h
