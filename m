From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 16 Jun 2020 10:51:13 +0000
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-Id: <20200616105112.GC1718@bug>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <55c57049-1869-7421-aa0f-3ce0b6a133cf@suse.de>
In-Reply-To: <55c57049-1869-7421-aa0f-3ce0b6a133cf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, tvrtko.ursulin@intel.com, gregkh@linuxfoundation.org, haiyangz@microsoft.com, spronovo@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, alexander.deucher@amd.com, kys@microsoft.com, Hawking.Zhang@amd.com

Hi!

> > The driver creates the /dev/dxg device, which can be opened by user mode
> > application and handles their ioctls. The IOCTL interface to the driver
> > is defined in dxgkmthk.h (Dxgkrnl Graphics Port Driver ioctl
> > definitions). The interface matches the D3DKMT interface on Windows.
> > Ioctls are implemented in ioctl.c.
> 
> Echoing what others said, you're not making a DRM driver. The driver should live outside 
> of the DRM code.
> 

Actually, this sounds to me like "this should not be merged into linux kernel". I mean,
we already have DRM API on Linux. We don't want another one, do we?

And at the very least... this misses API docs for /dev/dxg. Code can't really 
be reviewed without that.

Best regards,
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
