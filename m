From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Sat, 10 Mar 2012 07:29:24 +0000
Subject: Re: [PATCH 7/7] OMAPDSS: HDMI: hot plug detect fix
Message-Id: <1331364564.1623.3.camel@lappy>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
	 <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
	 <20120307200146.GA26451@kroah.com> <1331192113.2354.2.camel@deskari>
	 <20120308152949.GB5277@kroah.com>
In-Reply-To: <20120308152949.GB5277@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>

On Thu, 2012-03-08 at 07:29 -0800, Greg KH wrote:
> On Thu, Mar 08, 2012 at 09:35:13AM +0200, Tomi Valkeinen wrote:
> > On Wed, 2012-03-07 at 12:01 -0800, Greg KH wrote:
> > > On Thu, Mar 01, 2012 at 02:26:35PM +0200, Tomi Valkeinen wrote:
> > > > From: Rob Clark <rob@ti.com>
> > > > 
> > > > The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
> > > > over to using a GPIO for plug detect.  Unfortunately the ->detect()
> > > > method was not also updated, causing HDMI to no longer work for the
> > > > omapdrm driver (because it would actually check if a connection was
> > > > detected before attempting to enable display).
> > > > 
> > > > Signed-off-by: Rob Clark <rob@ti.com>
> > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > 
> > > You forgot to tell me what the git commit id is for this patch (it's
> > > ca888a7958b3d808e4efd08ceff88913f4212c69, right?)
> > 
> > Yes, that's the one. It wasn't in Linus's tree yet, only in fbdev tree,
> > so I wasn't sure what the commit id is.
> 
> Then you should not have sent it to me, as if I were to take it then, I
> could not have :(

Oh, ok. I thought the "patch-must-be-in-mainline"-rule was not a totally
strict one, so I decided to include it in this case as the patch was a
rather trivial one and already in the fbdev tree (I mentioned it in the
intro mail).

I guess I got lucky and the patch got into mainline before you took the
patches.

> > > And why isn't this needed for the 3.0 kernel as well?
> > 
> > The detect() function is not present in 3.0, so there was nothing to
> > break.
> 
> Ok, so everything I've queued up is all that is needed, right?

Yes, looks correct. Thanks!

 Tomi


