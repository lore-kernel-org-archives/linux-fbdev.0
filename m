Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3916BB58
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406645; cv=none; b=UfySueDiVyqVvvQtiUMDn0XDQjHGljEyJ4TJHf+GiayTOruo8NG/ZHly8SX3hUYSYFCETg4Q8TWV4EMcm0ejUOTlCKCJvXdmTavkM1GigBx//lomWY6NJjVfzwhUBHWK/SOh767lIzpe2DDufj8aJXoeLcKto2BSFyZPFxs6Q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406645; c=relaxed/simple;
	bh=6kaBC/L6/i/c9FtxT1pwrVSyAW4gc0ChoE8pXr3thDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7ZEyftHkRZnB7zTx864GKOSsDKi0fLge8j1MY9wPPN3hC2/I7fDN9nx9jbm3HJnadjZXztrBvNeA9eXWHi3iPWZ6Tjn3aaOl2UfSJZ6rNpS22VQoykvYwYfUClMuMrE2QIp7z1jByVG97nBO/VDFXPOv5vILGxOKU/biJPArEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=tMISvzzp; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=F4dgznld; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="tMISvzzp";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="F4dgznld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=gxeb8AAu1YVsY/Xu6cmaPpMTJxALfCwDGY4BFKWNTso=;
	b=tMISvzzpQfd7Nl6C/TYf8qmDPtMdAYFHHyAvDU6DPfHN4J2rE1m11N1WkILSyP2QGa6k4beUmhJcY
	 L6gN0v0NT10Lf3vRkFeDIAdTpfs8w2qxL41IDc8kU4hGXHFLEvHfszfcPzoDG7JMxUKx3RngjNItGA
	 dXyzrGTRrn+xspYYLj5LTZ/IyaaWEGFH+asZ9t+ADP/WIxLZuqDnXOhwz1s4aSZ7wI5dpu6JZInWjs
	 zq8ferYlKEuLCaU6NtUHH5shnWmu9YZm94Y6QJsUvLLz52LYNVVGcd2+ggov4NNm3+Hi1EFfJqlAJF
	 1jIBb56EYEme84yADTgPTZexfUukbMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=gxeb8AAu1YVsY/Xu6cmaPpMTJxALfCwDGY4BFKWNTso=;
	b=F4dgznldQA9WofOy8/5yBC+gXByvmy8MIjbkHVPROzUkOPFffQ0cDMmDL7Zv5zYxQznOD8h3CFZrJ
	 8KNTlCvAw==
X-HalOne-ID: d7a52303-e1e0-11ee-a435-31e85a7fa845
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id d7a52303-e1e0-11ee-a435-31e85a7fa845;
	Thu, 14 Mar 2024 08:57:13 +0000 (UTC)
Date: Thu, 14 Mar 2024 09:57:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/6] backlight/omap1-bl: Replace FB_BLANK_ states with
 simple on/off
Message-ID: <20240314085711.GA126747@ravnborg.org>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-4-tzimmermann@suse.de>
 <20240313180027.GB96726@ravnborg.org>
 <bf7b7e88-a7b4-427d-b38c-d3c9cc568aaf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7b7e88-a7b4-427d-b38c-d3c9cc568aaf@suse.de>

On Thu, Mar 14, 2024 at 09:16:15AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.03.24 um 19:00 schrieb Sam Ravnborg:
> > Hi Thomas,
> > 
> > On Wed, Mar 13, 2024 at 04:45:02PM +0100, Thomas Zimmermann wrote:
> > > The backlight is on for fb_blank eq FB_BLANK_UNBLANK, or off for
> > > any other value in fb_blank. But the field fb_blank in struct
> > > backlight_properties is deprecated and should not be used any
> > > longer.
> > > 
> > > Replace the test for fb_blank in omap's backlight code with a
> > > simple boolean parameter and push the test into the update_status
> > > helper. Instead of reading fb_blank directly, decode the backlight
> > > device's status with backlight_is_blank().
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > My biased opinion is that the approach in this patch is a little bit
> > better:
> > https://lore.kernel.org/lkml/20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org/
> > 
> > I never came around resending this series it seems.
> 
> Oh, that series has been around for over a year. I don't care about which
> patches go in as long as they remove the dependency on <linux/fb.h>. I saw
> that Dan has already r-b'ed the current patchset, but if you prefer I'll
> adopt yours.
Whatever works for you. It is trivial stuff and as long as we get it
cleaned up that is fine. You are pushing for this now - so whatever is
easiest for you.

	Sam
