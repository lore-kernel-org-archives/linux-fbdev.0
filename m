Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE272C0F7A;
	Tue, 27 Jan 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506535; cv=none; b=Q4JRFdMvh9hskjQUKhSfVGDneINSGF8oXLK+T83xdmTeTub7ZFUtBoBAn/YqThWKKshRUuud08XMJuXO2XdyJomp+wLikU7Fz08OCJYsdE+o/+NqLxkiNFHZRZLr1lVUUoy9xbdwbMdbmoXQQsZxz1zkzoGYw+TvMza9/ODOEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506535; c=relaxed/simple;
	bh=GJEGWRBJrTMt43UDuvg3iY/vbh+kLH5sEKoX9eSVoJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3AnOcZifM/ykBargMXm3TbF4Qp2sebhc6Qsy0WEGNf8K+mcJIe5G2CInFmH75ma6q13NINQFdCGFRi9/JpE2nykR2Y0e1iXt5s535ZO0M9gANtk/hDh+vJzNzStDf5F2WvWqikZxqZcN39R0VEj4J23OHG75GWN98i4DCw/qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZLlfMAZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZLlfMAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7037AC116C6;
	Tue, 27 Jan 2026 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769506535;
	bh=GJEGWRBJrTMt43UDuvg3iY/vbh+kLH5sEKoX9eSVoJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZLlfMAZ/iBXiXwVTR5CxoUqs1ypJ7GVadvLAq0gV8XD+9eij3onyX5fZNwsz2/1T
	 h7BrBp0aXl03GqpV/e3moZZ+R9qBnLzhU+h4qS9H0g7NS3BsslWUdGKoMbeIWcrLIA
	 JunXloca3zl/JIZP9yetkhXMb6Ax2V7AC2SoJnwA=
Date: Tue, 27 Jan 2026 10:35:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: pengfuyuan <pengfuyuan@kylinos.cn>
Cc: Helge Deller <deller@gmx.de>, Alexandre Courbot <acourbot@nvidia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Zsolt Kajtar <soci@c64.rulez.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
Message-ID: <2026012738-unfrosted-underpass-22c6@gregkh>
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
 <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de>
 <DFYG7MT5JINY.1T8ZZ4ASIWXU@nvidia.com>
 <20260127080419.GA965382@peng>
 <578209b5-6d22-4255-a2e6-256d3f5afa72@gmx.de>
 <20260127085826.GA970322@peng>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127085826.GA970322@peng>

On Tue, Jan 27, 2026 at 04:58:26PM +0800, pengfuyuan wrote:
> I would like to ask about the current status and plans for Rust DRM KMS
> support:
> 
> - Is there any active work or a design for KMS abstractions in Rust?

Very much so, look at the patches on the rust mailing list for them!

> - Is there a WIP tree or an RFC that I could look at?

Again, look at the list, there are loads of patches there.

> - Are there specific areas where I could help (e.g. prototyping KMS bindings,
>   writing tests, or working on smaller pieces under guidance)?

Build on the patches that have been submitted and work from there?

thanks,

greg k-h
