From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 19 Jul 2013 05:43:11 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <20130719054311.GA14638@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374129984-765-1-git-send-email-kishon@ti.com>
 <1374129984-765-2-git-send-email-kishon@ti.com>
 <20130718072004.GA16720@kroah.com> <51E7AE88.3050007@ti.com>
 <20130718154954.GA31961@kroah.com> <51E8D086.809@ti.com>
In-Reply-To: <51E8D086.809@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 19, 2013 at 11:07:10AM +0530, Kishon Vijay Abraham I wrote:
> >>>> +	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
> >>>
> >>> Your naming is odd, no "phy" anywhere in it?  You rely on the sender to
> >>> never send a duplicate name.id pair?  Why not create your own ids based
> >>> on the number of phys in the system, like almost all other classes and
> >>> subsystems do?
> >>
> >> hmm.. some PHY drivers use the id they provide to perform some of their
> >> internal operation as in [1] (This is used only if a single PHY provider
> >> implements multiple PHYS). Probably I'll add an option like PLATFORM_DEVID_AUTO
> >> to give the PHY drivers an option to use auto id.
> >>
> >> [1] ->
> >> http://archive.arm.linux.org.uk/lurker/message/20130628.134308.4a8f7668.ca.html
> > 
> > No, who cares about the id?  No one outside of the phy core ever should,
> > because you pass back the only pointer that they really do care about,
> > if they need to do anything with the device.  Use that, and then you can
> 
> hmm.. ok.
> 
> > rip out all of the "search for a phy by a string" logic, as that's not
> 
> Actually this is needed for non-dt boot case. In the case of dt boot, we use a
> phandle by which the controller can get a reference to the phy. But in the case
> of non-dt boot, the controller can get a reference to the phy only by label.

I don't understand.  They registered the phy, and got back a pointer to
it.  Why can't they save it in their local structure to use it again
later if needed?  They should never have to "ask" for the device, as the
device id might be unknown if there are multiple devices in the system.

Or am I missing something?

thanks,

greg k-h
