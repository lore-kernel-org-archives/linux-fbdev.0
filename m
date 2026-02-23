Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA78281358;
	Mon, 23 Feb 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856084; cv=none; b=hBrxYRfOeyLWMoUstBHbFaGbHI/fpnKLCmJDEVi7onABZSFigU8/oP7EJNsac5ydoQQ0gCQ6LCw3zP4nvkO+3NDeShmv1Iqeezfhc0g6FhEIq2uQmATDghKr15KaecEEf1Nae0kP4Gnxt0XiSl/pj7LkXOr7GtNghV9hUWUoFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856084; c=relaxed/simple;
	bh=3v/77CpdrBjE+r4wzjNYsTklTWpMCUbqXxRGW69H+eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNvn2blkie0vHwn0rBq7Ec6uHUamwjKGNJ0nu9aBCwesSCk+P+tLmmHt7hChG2YL7OhE2x6UijctMfmLSWrhs2/3CLMxxUE1T2Qj0TS0jPioKlifGGHDycq6pBFUC4GYyYpVfHoLriEnQ8upkkf6GAc4DSUcnfrL4VyGeilG3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rzf4+wxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rzf4+wxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3110DC116C6;
	Mon, 23 Feb 2026 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771856084;
	bh=3v/77CpdrBjE+r4wzjNYsTklTWpMCUbqXxRGW69H+eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzf4+wxjrdHNNO3QYS8OX1ZhRjwvghK6OTOk2wIgBhXZg7sGEeZWkqHE+DP1ocCJy
	 mUhZX5ezqojFpXk+FqQNE5Kyi4k2ET8T4JdfV9mCUNLZ8k9a8KpOYpDnUC5UTRQcJY
	 Ga3nFbArJTh1SJ2Oc0NYG6kZQEG4zJlH7NB/q66k=
Date: Mon, 23 Feb 2026 15:12:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shreyas Ravi <shreyasravi320@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] staging: sm750fb: Fix CamelCase variable names
Message-ID: <2026022324-bounce-foe-83f5@gregkh>
References: <2026020842-litigator-flatworm-65d0@gregkh>
 <20260208184344.657617-1-shreyasravi320@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208184344.657617-1-shreyasravi320@gmail.com>

On Sun, Feb 08, 2026 at 10:43:43AM -0800, Shreyas Ravi wrote:
> Rename CamelCase variable names to snake_case to comply
> with kernel coding style.

You are changing different structures at the same time.  Do it one
structure at a time please.

thanks,

greg k-h
