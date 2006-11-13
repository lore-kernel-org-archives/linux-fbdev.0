From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Mon, 13 Nov 2006 15:06:26 +0100
Message-ID: <200611131506.27698.rjw@sisk.pl>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754732AbWKMOJM@vger.kernel.org>
In-Reply-To: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>
Cc: Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Monday, 13 November 2006 11:51, Christian Hoffmann wrote:
> 
> > -----Original Message-----
> > From: Pavel Machek [mailto:pavel@ucw.cz] 
> > Sent: Sunday, November 12, 2006 1:14 PM
> > To: Benjamin Herrenschmidt
> > Cc: Christian Hoffmann; Andrew Morton; Solomon Peachy; Rafael 
> > J. Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML; 
> > Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
> > Subject: Re: Fwd: [Suspend-devel] resume not working on acer 
> > ferrari 4005 with radeonfb enabled
> > 
> > Hi!
> > 
> > > > Then the radeonfb doesn't kick in at all (guess some pci ids are 
> > > > added in that patch).
> > > > 
> > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > 
> > > In that case (vesafb), when does the screen come back 
> > precisely ? Do 
> > > you get console mode back and then X ? Or it only comes back when 
> > > going back to X ? Do you have some userland-type vbetool 
> > thingy that 
> > > bring it back ?
> > 
> > He's using s3_bios+s3_mode, so kernel does some BIOS calls to 
> > reinit the video. It should come out in text mode, too.
> > 
> > Christian, can you unload radeonfb before suspend/reload it 
> > after resume?
> 
> Will it work if radeonfb is compiled as module? I think I had problems
> with that, but I'll try again.
> 
> > 
> > Next possibility is setting up serial console and adding some 
> > printks to radeon...
> 
> Unfortunatly, the laptop doesn't have serial port. I tried to get a USB
> device (pocketpc) read the USB serial, but I only partially succeeded. I
> can pass console=ttyUSB0 to the kernel and load the ipaq serial console
> driver as it oopses. I am able to echo strings to /dev/ttyUSB0  and read
> them on the ipaq, but I am not able to "deviate" the kernel messages to
> that port. Any hints on how to do that would be very appreciated, I
> didn't find anything usefull on the web. (I tried with setconsole
> /dev/ttyUSB0 but it gives error msg about device busy or something) 

Would it be practicable to use netconsole on your box?  If so, it should work.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
