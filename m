Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C330DED5;
	Mon, 26 Jan 2026 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423563; cv=none; b=Ug9CEOZJSoX90xTpZCEga/We6ZivCwaTaTiCmbmSgP3EWakXE/qJKzpwFKyiYR120NzPiA8jF1jEDAE2D5WeCvlrtnpPJXYGMmYFRNbPpSheSVAns5OvUIt+PJKzxVDEqIWLFGyIzB71OvtfbTpfnwwIAJn2Ai/fVbHZB10wJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423563; c=relaxed/simple;
	bh=q3eFrdTHRAZUDsD1pmQSSgbtZhJ5tZlUAY2ThF5SSgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYnuFE1EYk04J/2Iim/F8c+yiY8EEx7Gz7cZBW+BNJ+YIWQuE53TxAAROmELLsr8FS9JN9P5jsUZjkA3G/omsY94k39S6ecARf3VPRwys0gmGOmHGaTLU12eAKys+gXQfguVy1H8BThEKF23bpQrYGweIh6jKY6EVXark+Hdmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFQUz3AN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFQUz3AN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C355C116C6;
	Mon, 26 Jan 2026 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769423563;
	bh=q3eFrdTHRAZUDsD1pmQSSgbtZhJ5tZlUAY2ThF5SSgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFQUz3AND1wnojc7Zyao0oIDpQ1W97D/N5g92EEJMSMCZF+B61q7D714UnUp63lG5
	 0YB94xOkQ/Ii1i/XfgpI0nWOXp7nL8sSvsZCqgz9+4d97PFbvwv+7y6LNkhegQheBJ
	 uw9SQCDTTQKTRX15diztjuAFXnFGa+xBs95+mhug=
Date: Mon, 26 Jan 2026 11:32:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: pengfuyuan <pengfuyuan@kylinos.cn>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Zsolt Kajtar <soci@c64.rulez.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
Message-ID: <2026012627-uncut-plaything-759e@gregkh>
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126081744.781392-1-pengfuyuan@kylinos.cn>

On Mon, Jan 26, 2026 at 04:17:40PM +0800, pengfuyuan wrote:
> This series has been tested on:
> - ARM64 platforms with various display configurations
> - AMD RX550 graphics card
> - Moore Threads S30 graphics card
> - Multiple other graphics cards

How?  If there is no rust framebuffer drivers for those hardware
platforms, how exactly were these new codepaths tested?

> All tested configurations show normal display functionality with proper
> framebuffer initialization, rendering operations (including I/O, color register
> management, and blitting), memory mapping, and resource cleanup. The simplefb
> test driver successfully demonstrates the usage of all framebuffer framework
> APIs and validates the abstraction's correctness.

Really?  Where are the drivers for this?  Or did simplefb really work
for all of them?

confused,

greg k-h
