From: Alan Stern <stern@rowland.harvard.edu>
Date: Tue, 26 Jun 2012 15:11:35 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <Pine.LNX.4.44L0.1206261107130.1636-100000@iolanthe.rowland.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340722875.24530.66.camel@deskari>
In-Reply-To: <1340722875.24530.66.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Rajendra Nayak <rnayak@ti.com>, jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On Tue, 26 Jun 2012, Tomi Valkeinen wrote:

> > Failure to suspend a device should not be regarded as particularly bad, 
> > because it doesn't affect the device's functionality.  That's true even 
> > when CONFIG_RUNTIME_PM is enabled.
> 
> This makes sense. So if CONFIG_RUNTIME_PM=n, using pm_runtime_get_sync()
> will return 1, meaning the HW is already enabled, and using
> pm_runtime_put_sync() will return -ENOSYS, meaning the hardware cannot
> be suspended.
> 
> With CONFIG_RUNTIME_PM=y, it's a bit more complex. If I read the code
> correctly, when I call pm_runtime_get_sync(), the usage counter is
> always increased, even if the pm_runtime_resume() fails. So a get()
> needs to be always matched with a put(), even if get() has returned an
> error.

Right.  Of course, it doesn't hurt to match a get() with a put() even 
when CONFIG_RUNTIME_PM=n.

> But if pm_runtime_get_sync() returns an error, it means the HW has not
> been resumed successfully, and is not operational, so the code should
> bail out somehow. So basically I'd use this kind of pattern everywhere I
> use pm_runtime_get_sync():
> 
> ---
> 
> r = pm_runtime_get_sync(dev);
> if (r < 0) {
> 	pm_runtime_put_sync(dev);

Here you could just as well call pm_runtime_put_noidle().  Since the 
device wasn't resumed, the put operation doesn't need to try to suspend 
it.

> 	/* handle error */
> 	return -ESOMETHING;
> }
> 
> /* do the work */
> 
> pm_runtime_put_sync(dev);
> 
> ---
> 
> Is this correct?

Yep, you've got it.

Alan Stern

