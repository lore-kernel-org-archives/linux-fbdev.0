From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 23 Nov 2016 08:52:34 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161123085234.GB3122@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Wed, Nov 23, 2016 at 10:03:10AM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> Since the fbdev framework is in maintenance mode and all new display drivers
> should be made with the DRM framework, remove the fbdev drivers from staging.
> 
> Note: the patches are created with git format-patch -D, so they can't be
> applied. Only for review.

I only want to remove these drivers if we have the same functionality in
mainline for their hardware.  If not, that's a bit rude to those who
actually use them today, don't you think?

thanks,

greg k-h
