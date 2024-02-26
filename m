Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC677E59E;
	Mon, 26 Feb 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950800; cv=none; b=qrC2CoDMvE+JlRfjyUllZU2NxgV4CMmehA0h2qXp68MNrv6+FkiuyU2FAul39LyLBh74Frqnr21nIw2xB+x4p2I+CeJd1YfgeDGx5UesgRKLpo1BEM7UyprQHj5RfUce1OAuhw4RaZBixRxljj63AdWlOOAstveo+1xxiL5zf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950800; c=relaxed/simple;
	bh=iVpnFC5qoBj5u4xxTGmfXF9T+j7roJU24Cf4R1lc0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxnAg1eKE0V0KGeH8+AaFPiuiFiomy/wX5GVo57OBdvqBTuiaebk+L2n8Es16y4LlA4MrLOPpH2r7knH2VHw+5hgKo3aSK7qD2zCvvvbJHPNJga8haKMRPANFTy/3cNKUxYjylyE+a5rMnjwJyPoDODgHv6FQZOglOmsuwwliZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO+O7iM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO+O7iM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C91FC433F1;
	Mon, 26 Feb 2024 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708950799;
	bh=iVpnFC5qoBj5u4xxTGmfXF9T+j7roJU24Cf4R1lc0S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nO+O7iM0FBLFuDbRoL/eG/hNUW/srk3nonkai6ZtMHseVbweZXjRqYAyEylkPeiPM
	 przp/1/YdZNfX4/+kUfdfday0DmatxiuPoyUXi05LsNmUG9KZu4EGNzJMiap18EvKy
	 bePWhHZ88di0G+NUT8Yj9cXKZUaOuPJH6JLs8JxjDiQ42B6OrFyqbxmHtRiEJI0GkH
	 DPAiCocOoEs0MgdFo/5EQvpiUyPuMWRagFzjBe82i+dbcdG4dJU2asj+GNsHON6M7E
	 WH6CVb5nRZ/dUMT7vrj/dqAAa+AYnBncjkXFFHPcDmeNUM9yqKLA9r1R7SYLj5ByDw
	 /OBc5mxR5tDxg==
Date: Mon, 26 Feb 2024 12:33:13 +0000
From: Lee Jones <lee@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
	kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
	daniel@ffwll.ch, airlied@gmail.com, gregkh@linuxfoundation.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/9] backlight/corgi-lcd: Include <linux/backlight.h>
Message-ID: <20240226123313.GA23065@google.com>
References: <20240219093941.3684-1-tzimmermann@suse.de>
 <20240219093941.3684-2-tzimmermann@suse.de>
 <1e577f18-c6f7-44e7-b50f-720915f257eb@suse.de>
 <20240223105652.GT10170@google.com>
 <874jdvo3ia.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jdvo3ia.fsf@intel.com>

On Mon, 26 Feb 2024, Jani Nikula wrote:

> On Fri, 23 Feb 2024, Lee Jones <lee@kernel.org> wrote:
> > On Wed, 21 Feb 2024, Thomas Zimmermann wrote:
> >
> >> cc'ing backlight maintainers
> >
> > I cannot review/accept patches like this.
> >
> > Please submit a [RESEND].
> 
> I bounced the original [1] to you. Please consider acking to merge the
> one-line #include addition via fbdev so we don't have to respin the
> series for no good reason.

The "good reason" would be that it was not sent properly in the first
place.  My kernel.org mail is filtered by the recipients headers.  If
the original wasn't sent to me, bouncing won't work either.  I've since
reviewed the patch and seen the set on LORE.  This is non-optimal.
Please use get_maintainer.pl next time.

This time only, patch is:

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
