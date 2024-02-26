Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C75EC7;
	Mon, 26 Feb 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951936; cv=none; b=Uxv4b0txT1EGdLGs1I8Bo7GQ1cI3ZbjLV5A68SW+mqP9qVmu484bL7GrgwxQthNu/fqHv3VWtP3CKqcqqgnP6xygjyV2Z4VLWmWIi0ntn4COORcLrjXhQTBXukq1TlaBpflscclJ+U34NvUba/R3mgHdgdb1P0A9BffocjsVBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951936; c=relaxed/simple;
	bh=fZH+U9WKhQH4ZWiXzAST0yU7viLHXCnk1wkEi0y7miE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJhHgCv4xtR65K/XTls50YSU8v41qagAWpx42OayLmkfJachj3vPADcWMH2GUZ8tXqGH4vvoQCzJTCjKV0rL/O1wLkolflqiZGISL9FxURsGdXvZwZNDdT/p3f3BpMST5JMKEmUO55xWUS/REktqzWI5s6Z8VxwMB4xMi4O/C8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT5LQvi/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT5LQvi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1491CC433C7;
	Mon, 26 Feb 2024 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951936;
	bh=fZH+U9WKhQH4ZWiXzAST0yU7viLHXCnk1wkEi0y7miE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rT5LQvi/Ie8zpJvS9vTRBFbcNvWb2YZ6Litpoc2gmG/iVgPfsgrb5U2NHi/2A9xE4
	 lfYNYvIJYx8n2BPx8hOQWCqp77EqUemTpWwi0bjalxN6PUyRAUd+uTt68QJEAH7bNi
	 TrkonldQtBcKZFnjoMMril65adw08G/kq/EN1kX9J8/opb5lZmsdHa4i++3V4al16h
	 1fAYo1HNPK+qqNolVsVHgVze3jPPPw1A5wCQHPKEIDqkfHzgLE6gTcpDEcJppTFHQV
	 MtvsQqOMspRMmvXXC+M3vCh8aOKQtVvTaisxDc/sv0aWMs2vMcVcbL7ehh0Xq4pcB1
	 Hk62H+O5pyklQ==
Date: Mon, 26 Feb 2024 12:52:09 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, deller@gmx.de,
	kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
	daniel@ffwll.ch, airlied@gmail.com, gregkh@linuxfoundation.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/9] backlight/corgi-lcd: Include <linux/backlight.h>
Message-ID: <20240226125209.GB23065@google.com>
References: <20240219093941.3684-1-tzimmermann@suse.de>
 <20240219093941.3684-2-tzimmermann@suse.de>
 <1e577f18-c6f7-44e7-b50f-720915f257eb@suse.de>
 <20240223105652.GT10170@google.com>
 <874jdvo3ia.fsf@intel.com>
 <20240226123313.GA23065@google.com>
 <62ad32cb-3fd1-4c21-ab2c-a194e559d12a@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62ad32cb-3fd1-4c21-ab2c-a194e559d12a@suse.de>

On Mon, 26 Feb 2024, Thomas Zimmermann wrote:

> Hi
> 
> Am 26.02.24 um 13:33 schrieb Lee Jones:
> > On Mon, 26 Feb 2024, Jani Nikula wrote:
> > 
> > > On Fri, 23 Feb 2024, Lee Jones <lee@kernel.org> wrote:
> > > > On Wed, 21 Feb 2024, Thomas Zimmermann wrote:
> > > > 
> > > > > cc'ing backlight maintainers
> > > > I cannot review/accept patches like this.
> > > > 
> > > > Please submit a [RESEND].
> > > I bounced the original [1] to you. Please consider acking to merge the
> > > one-line #include addition via fbdev so we don't have to respin the
> > > series for no good reason.
> > The "good reason" would be that it was not sent properly in the first
> > place.  My kernel.org mail is filtered by the recipients headers.  If
> > the original wasn't sent to me, bouncing won't work either.  I've since
> > reviewed the patch and seen the set on LORE.  This is non-optimal.
> > Please use get_maintainer.pl next time.
> > 
> > This time only, patch is:
> > 
> > Acked-by: Lee Jones <lee@kernel.org>
> 
> No problem, I'll send out another series. I just didn't get to do it.

No need to do that now on my behalf.  You have my Ack.

-- 
Lee Jones [李琼斯]
