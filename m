From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 07 Mar 2012 20:01:46 +0000
Subject: Re: [PATCH 7/7] OMAPDSS: HDMI: hot plug detect fix
Message-Id: <20120307200146.GA26451@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
 <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: stable@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>

On Thu, Mar 01, 2012 at 02:26:35PM +0200, Tomi Valkeinen wrote:
> From: Rob Clark <rob@ti.com>
> 
> The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
> over to using a GPIO for plug detect.  Unfortunately the ->detect()
> method was not also updated, causing HDMI to no longer work for the
> omapdrm driver (because it would actually check if a connection was
> detected before attempting to enable display).
> 
> Signed-off-by: Rob Clark <rob@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

You forgot to tell me what the git commit id is for this patch (it's
ca888a7958b3d808e4efd08ceff88913f4212c69, right?)

And why isn't this needed for the 3.0 kernel as well?

thanks,

greg k-h
