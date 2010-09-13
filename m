From: Greg KH <gregkh@suse.de>
Date: Mon, 13 Sep 2010 17:13:40 +0000
Subject: Re: locking inconsistency, when calling fb_ops::fb_release()
Message-Id: <20100913171340.GA9374@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1009130854280.24398@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009130854280.24398@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Sep 13, 2010 at 06:06:03PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 13 Sep 2010, Greg KH wrote:
> 
> > On Mon, Sep 13, 2010 at 09:17:04AM +0200, Guennadi Liakhovetski wrote:
> > > Hi
> > > 
> > > I do not know, whether this can be a problem for any existing driver, but 
> > > such an inconsistency seems like a bad idea to me anyway. The struct 
> > > fb_ops::fb_release() method can be called in following ways:
> > > 
> > > fbmem.c::fb_release() under the info->lock mutex (file.close("/dev/fbX") 
> > > 							operation)
> > > fbcon.c::con2fb_release_oldinfo() under console semaphore
> > > fbcon.c::fbcon_exit() from
> > > 	fbcon_deinit() from
> > > 		vt.c::vc_deallocate() under console semaphore (has 
> > > 			WARN_CONSOLE_UNLOCKED())
> > > 		bind_con_driver() under console semaphore
> > > 	fb_console_exit() under console semaphore
> > > 
> > > I.e., it can be either called within an acquire_console_sem() / 
> > > release_console_sem() block, or within a mutex_lock(&info->lock) / 
> > > mutex_unlock(&info->lock) block, which looks inconsistent to me.
> > > 
> > > The problem, this is causing me is, that I'd like to call the framebuffer 
> > > notifier chain from my driver's fb_release() method.
> > 
> > Why would you need/want to do this?  If you don't do that, all should be
> > fine, right?
> 
> I am implementing HDMI hot-plug support. When a new monitor is plugged in, 
> I configure its physical resolution, but keep the framebuffer parameters, 
> as long as there are user-space applications, using it. I have to do this, 
> because currently there is no way to inform users about a changed 
> geometry. Then, when the last non-console user releases the framebuffer, I 
> reconfigure the framebuffer and issue a notification to inform the 
> console, which then redraws the screen.

Hm, sounds valid.  I really don't know the fb layer at all, sorry,
someone else is going to have to help you.

good luck,

greg k-h
