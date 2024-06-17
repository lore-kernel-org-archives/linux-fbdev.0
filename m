Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F4FC18;
	Mon, 17 Jun 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638048; cv=none; b=gT2JxYuLfJF2e/qK0aMtWSNNvEkbrDHPZgofZTNxP2FwY/wJpxm3nomXR3Upw9dQexBDJVnoXCOFd63L8AJg4Ta22hBZQjqQESe7ox3VmYiOuDkeIGCjsB2lv0KI73IGFldHmj7SxxVXzbvmvSr8p3jjoiI/kf77FRvLKFAlcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638048; c=relaxed/simple;
	bh=JqQieqOI7uaMFyxd7GU6ZdU463tO4X0tPf2fLy0tgxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K98CmeMUw3zzHTT5xkYKiJmL5ypCYy8IpYfT2ngWQUdomfVGfsuziWVP0zBab+gMHXLvUQvAACdZsviOKSMsMS14ZfHUvINzkiq9ekOrk+3hSKSSFCinq+OXotZXl+u4ohdjHZ8hMEB/yUSiFYNPWFJgUy5BAc7HOou6T46teI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kp9v/qMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kp9v/qMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18A8C4AF1C;
	Mon, 17 Jun 2024 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718638047;
	bh=JqQieqOI7uaMFyxd7GU6ZdU463tO4X0tPf2fLy0tgxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kp9v/qMeE///xRyWXaDyuuwUtJYSiliwMIDIoQTzGa1dKJ9eXZjFd2xZHl57uwt81
	 G1KoA67VdxH7Oek6QhLYDnFrgF3ArqWjpIsFijgj+WgbBVnPjEaouzhzCJZdN0jd+1
	 9uoEJrgsG7INGo92rGtK0aJlCKQzJKK5WL3puKfo=
Date: Mon, 17 Jun 2024 17:27:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shiva Kiran K <shiva_kr@riseup.net>
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Remove unnecessary parentheses
Message-ID: <2024061759-hemlock-humped-ac2f@gregkh>
References: <20240617142746.51885-2-shiva_kr@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617142746.51885-2-shiva_kr@riseup.net>

On Mon, Jun 17, 2024 at 07:57:47PM +0530, Shiva Kiran K wrote:
> Remove unnecessary parentheses in `if` statements.
> Reported by checkpatch.pl

As per the many times this came up in the past (see the mailing list
archives), checkpatch is wrong here.

sorry,

greg k-h
