Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152226ED2A;
	Thu, 29 Jan 2026 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769661486; cv=none; b=fa2ablRcrT1Mr33woaBx+fgqrcmnOCJ4pbg5fWA59p7opHSEIS115X7b+78b18Ag5c2hIsBA0NbYhIDbVWgcGNuv9azdsM+pb4q7gheRtLCtzeX/K3h+dPkKTfk7eEV2PruNlfHefUYEm+w8/qBm0awEfa/m7i2JYZlPOO7LMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769661486; c=relaxed/simple;
	bh=CiScCEL9euuEpGOeeAwg/0fqDkxe93uyrdAFznE9Rm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBp7DxPJerXtHmzsK31jZW7JcAZuAMVOjHuHJX8wLvIS8KEVJDiwVPAHV4MJfIaPd19A2oCko7RSRRnMeZ5R4ZO2YPBw6VqG/TxNnKm9d4FiaHXXyKtvFll/ZtHv7VuRGrJxODWX/Zpz5fJYJPlcerfHAulQevzE0FTYyklwBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kp7r4jH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kp7r4jH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8D8C116D0;
	Thu, 29 Jan 2026 04:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769661485;
	bh=CiScCEL9euuEpGOeeAwg/0fqDkxe93uyrdAFznE9Rm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kp7r4jH06sLzIwyC+03sdtahoiz/d5jSzPQCa1IKysFCOqfN6DvAt3q/beJ8/5LXt
	 8jhOrmcx+6nXOtBP2h74rUvSCae85+1cLVjOLR9er500Z9tz6IrSFMC1ItG8mjboaX
	 IBpZfV+bd6ZzVCpert3y+q5P+H3umdnBV8yENbrc=
Date: Thu, 29 Jan 2026 05:38:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul =?iso-8859-1?Q?Retourn=E9?= <paul.retourne@orange.fr>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use guard() to simplify code
Message-ID: <2026012929-disprove-certified-4057@gregkh>
References: <20260128212644.1170970-1-paul.retourne@orange.fr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128212644.1170970-1-paul.retourne@orange.fr>

On Wed, Jan 28, 2026 at 10:26:42PM +0100, Paul Retourné wrote:
> Use guard() to simplify mutex locking. No functional change.

It's best to use guard() for new code, not touching existing code as:

>  3 files changed, 8 insertions(+), 8 deletions(-)

This made no change overall at all :(

thanks,

greg k-h
