Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925312FF160;
	Tue, 14 Apr 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183855; cv=none; b=CinGQ3BrLGohVtd/z/zgBeqfLCBDAOKqoPqAmOF9qTCvAIPCHNnc6/QhGB0zcy687WKhqTbhTSrWKERhYA9M/NB2uYgAfVUYaUEe+QnYrN0Jb2X43U3Sq51jPnSAduJTNR/LhbkjOUEofwQRIUpbzvbiZcmi1Bc0enXWirzDrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183855; c=relaxed/simple;
	bh=BhJVhuq1ERNvkwltfV/6VfoiFUTjHYKa2RPCsP6TyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFmn+9JNGvg1QEeJ4PQdL4ZFpdnc44jx2Vp28wpV1fnZOxXyJ2oqv4sJc1V4aTpMz4jdKFPtyNL2Chllhaob/V87xa36m2eh9ss7jwN0nHe9K/GwILn9DVlO5ZzjQMDOpXWmhlfZpZZCYme1+bcckgJB6N0qcY1JkQPm++QrSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtwTsJZm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtwTsJZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FA6C19425;
	Tue, 14 Apr 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776183855;
	bh=BhJVhuq1ERNvkwltfV/6VfoiFUTjHYKa2RPCsP6TyKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtwTsJZmECnOMmXzz1pu14fmjGS7jo/i0TcGo7BN1SS+z8O+wmio03nMm6Vfhe5xN
	 hw9wHMkHEL05J/TsCN1M2o0XZ+aQaFLge/BQDIuK9u+/9QChD91xd3mC3q9nnUsZgs
	 PWQtG7S7c5w26Ub+z30E0QFHohH+d/Fcy1GbwYcrAOHBi53SxaFG7wlm9BGvhlqjC8
	 0s5Exvwz38hkvIaaR6MY144CXFfyCX6Jtb2Y9XjOpBLfHO6/iFc5Q+DayfRgqKvGap
	 3etuWiIhhKbff5hdSv6RbwTG3FDlBCN1yWQijJnQ+CYe1ZDnafydhCbXWqPzJBZ0zE
	 6L3YMmCVYqRUQ==
Date: Tue, 14 Apr 2026 17:24:09 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	stable@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
Message-ID: <ad5qKZjhfAnnpmNV@aspen.lan>
References: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>

On Sat, Mar 28, 2026 at 09:42:16PM +0100, Duje Mihanović wrote:
> From: Duje Mihanović <duje@dujemihanovic.xyz>
>
> Boards using this backlight chip do not power the backlight off on
> suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
> the backlight core on suspend.
>
> Tested on samsung,coreprimevelte.
>
> Cc: stable@vger.kernel.org # v6.19
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
