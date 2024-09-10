Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CCF16A94F
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Sep 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955986; cv=none; b=gQlI/erd0sg/6VsxnIbZO2Dn8vDFWQInodkvGe7PWIXzSAKvY0EkzRcp5gO9umCoECj3i7UkALTJUB7TK8KcvSQzoVpOSgw94Gjl09Men2pZlg07gpbv/x4TXveuUjl8JPh8uhZJcq9tzZk4odMahmmi4GS13g1NDcuLvYwbHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955986; c=relaxed/simple;
	bh=ApYz6Ufh7wiXgEhi9x8riKL8Lf0uI77QJCC4Ud/fcLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSPb0oP3lthsOpxWkHFHlqFKsIuYCYX5Hn/fz1UgnMAiFev2r/OSCkTgiisQTHf+kGAht1B+GFLBFpnLPoVB8AlYBrlArH+AbwkQlKdjwIXY4VbtiVwwq30Snzu8o2C0NmRkFzvH2x2iFpTtnZBpaX7LxVmMqR8hGWEAh5XUY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=POd1+WIB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="POd1+WIB"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so5603972a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Sep 2024 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1725955983; x=1726560783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZrAkDLaXld3+MjEVbLTf0QH6amL7yZTph2uE3DVa+eA=;
        b=POd1+WIBRCAlTgtx+gMwrut22EwNO8TJVe/qpNU1h8FONE+AIljlCcMz+T8g+2UsNr
         /VE3ffvRV4RWUjhX1eljynqJ3dKuh6VjKYMEjCx5bSEp9CqnOvmFkrrpoxnHjd2iYSlx
         nrsDEfls2qwJEcgU+YVmwoi0n7FEy76kfdYqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955983; x=1726560783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrAkDLaXld3+MjEVbLTf0QH6amL7yZTph2uE3DVa+eA=;
        b=affERReb8AxH6KFzO9jk3hysF7cPcRWuDkHBVWv8DiBhomnOPonF3WjeKX1Six4IR3
         xRcwBCGumOoS5BDGMMEdeRsuLtqhrsFjjGUQlKHRsASC/T7aiZJww/S0G4F6rgmIVNKU
         xeEYh2TVU7STqPzKgkYtbdzblDhQ+WYRUtwwO7hn7rRC841eAtqvQvdl/8zWVlKHTlCJ
         71r4JyfbxO8lMbyYRTKwDPg4IXX7tToFavzE2uPfpQE8kAVX0HY17B/cxxEdmM4B4mbI
         lC6eIlVqupK3+yPwgmOWJ+mx4UfTM9PN7PdtOv4CkgbIBIc1SbiK+II0RQMT5VKvLk+a
         oK+g==
X-Forwarded-Encrypted: i=1; AJvYcCXvI7hZmTsZWhhDI8qhL3NfYDD5hP2gvh2y9luE97lNv33XRpXJj9MmXWxoOmoh1e9MV86bWKmFByrjeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIR21wiO97E9aMJI9Xz7XpqaQK8jX79/AcJ0mdciJXuwYY0dRT
	nxp5EjwvALxOHLXpFtboJEyZYm8VyJSSYYOypLmPoPfaG9c7cfLbMjXgVmZhmgE=
X-Google-Smtp-Source: AGHT+IHiB9BjTCtXbGr3lRX9SELZFUb5HLAig7DxMwgiilncoD8W9NU5mPh05hS+XdfHoA6qWwrRQQ==
X-Received: by 2002:a17:907:1c23:b0:a8d:4d76:a75e with SMTP id a640c23a62f3a-a8d4d76a983mr600932766b.30.1725955982405;
        Tue, 10 Sep 2024 01:13:02 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d258354f7sm445482166b.2.2024.09.10.01.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:13:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:13:01 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jason Andryuk <jandryuk@gmail.com>, Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
	xen-devel@lists.xenproject.org,
	Jason Andryuk <jason.andryuk@amd.com>,
	Arthur Borsboom <arthurborsboom@gmail.com>, stable@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
Message-ID: <Zt__jTESjI7P7Vkj@macbook.local>
References: <20240910020919.5757-1-jandryuk@gmail.com>
 <Zt_zvt3VXwim_DwS@macbook.local>
 <ad9e19af-fabd-4ce0-a9ac-741149f9aab3@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9e19af-fabd-4ce0-a9ac-741149f9aab3@suse.de>

On Tue, Sep 10, 2024 at 09:29:30AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.09.24 um 09:22 schrieb Roger Pau Monné:
> > On Mon, Sep 09, 2024 at 10:09:16PM -0400, Jason Andryuk wrote:
> > > From: Jason Andryuk <jason.andryuk@amd.com>
> > > 
> > > Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> > > struct device is NULL since xen-fbfront doesn't assign it and the
> > > memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
> > > 
> > > This was exposed by the conversion of fb_is_primary_device() to
> > > video_is_primary_device() which dropped a NULL check for struct device.
> > > 
> > > Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> > > Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> > > Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> > Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> > 
> > > ---
> > > The other option would be to re-instate the NULL check in
> > > video_is_primary_device()
> > I do think this is needed, or at least an explanation.  The commit
> > message in f178e96de7f0 doesn't mention anything about
> > video_is_primary_device() not allowing being passed a NULL device
> > (like it was possible with fb_is_primary_device()).
> > 
> > Otherwise callers of video_is_primary_device() would need to be
> > adjusted to check for device != NULL.
> 
> The helper expects a non-NULL pointer. We might want to document this.

A BUG_ON(!dev); might be enough documentation that the function
expected a non-NULL dev IMO.

Thanks, Roger.
