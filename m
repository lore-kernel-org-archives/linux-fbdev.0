From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 18 Aug 2012 13:48:28 +0000
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Message-Id: <20120818154828.0e992bfe@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120818144039.0356cc7c@neptune.home>
	<Pine.LNX.4.44L0.1208180913440.17394-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208180913440.17394-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sat, 18 August 2012 Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sat, 18 Aug 2012, Bruno Prémont wrote:
> > On Thu, 16 August 2012 Jiri Kosina <jkosina@suse.cz> wrote:
> > > On Thu, 16 Aug 2012, Bruno Prémont wrote:
> > > 
> > > > > I don't really understand this explanation. Once usb_kill_urb() returns, 
> > > > > the URB should be available for future use (and therefore all queues 
> > > > > completely drained).
> > > > 
> > > > I won't have time today to check, though my guess is that on each
> > > > echo $usb-id > bind; echo $usb-id > unbind
> > > > under /sys/bus/hid/drivers/hid-picolcd/ the USB urb queue fills a bit does
> > > > not get cleared.
> > > > 
> > > > Is usb_kill_urb() called when unbinding just the specific hid driver? 
> > > 
> > > Yup, through hid_hw_stop() -> usbhid_stop().
> > > 
> > > > If so my short timing between bind/unbind must be triggering something 
> > > > else...
> > > > 
> > > > Otherwise I'm missing something as at first time I got no "output queue full"
> > > > messages, but as I repeated the bind/unbind sequences the prints per bind/unbind
> > > > iteration increased in number.
> > > > 
> > > > Anyhow, on Friday evening/week-end I will continue digging and report back with my
> > > > findings.
> > 
> > Huh, after changing some of the hid-picolcd data in order to have less racy
> > coupling between hid and framebuffer I'm now dying way too often in _mmx_memcpy
> > and most of the time I don't get a (complete) trace...
> 
> There was a similar problem reported recently.  It turned out to be 
> caused by a __devinitconst annotation attached to a usb_device_id 
> table.
> 
> If there are any __devinit* annotations in the hid-picolcd driver, you 
> should see if removing them helps.

There is no such annotation around in hid-picolcd.


One thing I just though about, how does usbhid handle the calls to
usbhid_submit_report() when hid_hw_stop()/hid_hw_close() have already
been called?
I will attempt to see if it makes a difference to shortcut my
usbhid_submit_report() calls from the point on I have called hid_hw_close()...

Bruno
