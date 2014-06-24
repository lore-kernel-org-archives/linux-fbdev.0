From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Tue, 24 Jun 2014 06:59:42 +0000
Subject: Re: [PATCH] video: OF display-timings support for ocfb
Message-Id: <20140624065941.GA896@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1402517871-27503-1-git-send-email-franck.jullien@gmail.com>
 <53A81720.2050507@ti.com>
In-Reply-To: <53A81720.2050507@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Franck Jullien <franck.jullien@gmail.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com

On Mon, Jun 23, 2014 at 03:01:36PM +0300, Tomi Valkeinen wrote:
> On 11/06/14 23:17, Franck Jullien wrote:
> > Signed-off-by: Franck Jullien <franck.jullien@gmail.com>
> > ---
> >  drivers/video/fbdev/Kconfig |    2 ++
> >  drivers/video/fbdev/ocfb.c  |   31 ++++++++++++++++++++++++++-----
> >  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> You need to add binding documentation if you add new things to the
> driver's DT support. Actually, we seem to be missing the the binding
> documentation totally, even if the driver has 'of_device_id' table...
> 

Right, I'll take the blame for the missing driver binding documentation,
I'll write something up and post a patch for that.
But, where should it go?
Documentation/devicetree/bindings/video/
or
Documentation/devicetree/bindings/fb/

Stefan
