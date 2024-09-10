Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE936149E00;
	Tue, 10 Sep 2024 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957237; cv=none; b=flBqZ+MBppZLcUhM64yy9aqQTFtHFjRx4dU/W4+nPIs/XHicW+sU0SYdf8vHfpXN9mMmVuINQTJQNBsDf0heiy2TtAyux/aBRXEmPiDP1Hir2SFgG2U4qCXlCTKhsxOf/RQzr4eBsdtafGSt39wJ5EjQBDikZKQpZ+Yayd961Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957237; c=relaxed/simple;
	bh=7fN2QW4VeStjSZ6oT3iXJeTQYiGdecAGUoenFSAEiog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdwSMPOYqZWhPtPB52LH8h0nU1kBD0V2hELfgGDDr6SJLF79KPXBiDExx2lwKnYruAVmmK5sU5MLvAkC4Zoah9b57C12D8uu0R+kMw+rsnaKSzA+rBS32H3syS/BIKUlI81ybutwR3YIQdAaqBMFzgY85xIxqgUt0Xz17K4sK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jcLdne6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jcLdne6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D83C4CEC3;
	Tue, 10 Sep 2024 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725957236;
	bh=7fN2QW4VeStjSZ6oT3iXJeTQYiGdecAGUoenFSAEiog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcLdne6WlOPXpt9HAXecfWUAErV3zON5CbSWgnYkv0R9ahlM1S8YPgF40RkTRzgBk
	 YCBKJP3lIH4IKhla33l+NtemuMfsHVlV90tpIKvZkCCeJTFgHuehMNtnfkytpLds13
	 WIValR9lsOsVpJWxdRTixskS/ArntXyaOwnCJqEg=
Date: Tue, 10 Sep 2024 10:33:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jason Andryuk <jandryuk@gmail.com>, Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
	xen-devel@lists.xenproject.org,
	Jason Andryuk <jason.andryuk@amd.com>,
	Arthur Borsboom <arthurborsboom@gmail.com>, stable@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
Message-ID: <2024091033-copilot-autistic-926a@gregkh>
References: <20240910020919.5757-1-jandryuk@gmail.com>
 <Zt_zvt3VXwim_DwS@macbook.local>
 <ad9e19af-fabd-4ce0-a9ac-741149f9aab3@suse.de>
 <Zt__jTESjI7P7Vkj@macbook.local>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zt__jTESjI7P7Vkj@macbook.local>

On Tue, Sep 10, 2024 at 10:13:01AM +0200, Roger Pau Monné wrote:
> On Tue, Sep 10, 2024 at 09:29:30AM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 10.09.24 um 09:22 schrieb Roger Pau Monné:
> > > On Mon, Sep 09, 2024 at 10:09:16PM -0400, Jason Andryuk wrote:
> > > > From: Jason Andryuk <jason.andryuk@amd.com>
> > > > 
> > > > Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> > > > struct device is NULL since xen-fbfront doesn't assign it and the
> > > > memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
> > > > 
> > > > This was exposed by the conversion of fb_is_primary_device() to
> > > > video_is_primary_device() which dropped a NULL check for struct device.
> > > > 
> > > > Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> > > > Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > > Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> > > > Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > > CC: stable@vger.kernel.org
> > > > Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> > > Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> > > 
> > > > ---
> > > > The other option would be to re-instate the NULL check in
> > > > video_is_primary_device()
> > > I do think this is needed, or at least an explanation.  The commit
> > > message in f178e96de7f0 doesn't mention anything about
> > > video_is_primary_device() not allowing being passed a NULL device
> > > (like it was possible with fb_is_primary_device()).
> > > 
> > > Otherwise callers of video_is_primary_device() would need to be
> > > adjusted to check for device != NULL.
> > 
> > The helper expects a non-NULL pointer. We might want to document this.
> 
> A BUG_ON(!dev); might be enough documentation that the function
> expected a non-NULL dev IMO.

No need for that, don't check for things that will never happen.
