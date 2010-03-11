From: Bernie Thompson <bernie@plugable.com>
Date: Thu, 11 Mar 2010 14:57:10 +0000
Subject: Re: My goal
Message-Id: <480988181003110657m5d33fd1dwc674e0b370551498@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1003110341550.21470@casper.infradead.org>
	<1268289985.4b9891c1d28e3@online.sigmanet.lv>
In-Reply-To: <1268289985.4b9891c1d28e3@online.sigmanet.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aivils@latnet.lv, James Simmons <jsimmons@infradead.org>, DRI development list <dri-devel@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>Linux

2010/3/10  <aivils@latnet.lv>:
> Over the world are around 10 versions of multiseat:

There's also the USB multiseat case, which avoids shared resources
(VGA arbiter) and so can cleanly launch independent X instances for
each USB graphics device even now. Better yet, the USB topology can be
used (via udev scripts) to know exactly which keyboard, mouse,
keyboard, etc. go together so adding seats is completely plug and
play.

BUT it's a bit hackish on Linux today, because of the some assumptions
that need cleaned up (e.g. that all graphics are on PCIe).  Some of
that cleanup is happening (e.g. hal->libudev), but it could use a lot
more attention and experienced help on the USB case. Also on
whether/how to move USB graphics driver from fbdev->dri with matching
xorg driver, on better newgdm/consolekit integration, and then on
getting this into distros.

http://plugable.com/2009/11/16/setting-up-usb-multiseat-with-displaylink-on-linux-gdm-up-to-2-20/
to see stuff to get it running in the hal/gdmdynamic world.

A lot of discussion and work is on the libdlo list, but needs more
contact with experts on those lists with deeper expertise (dri, fbdev,
console, etc.)

Best wishes,
Bernie
http://plugable.com/
