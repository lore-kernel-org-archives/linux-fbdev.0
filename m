From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 17:41:03 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049188090.1031.41.camel@localhost.localdomain>
References: <20030401040106.65664.qmail@web14906.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190IxT-0005PD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 02:25:35 -0800
In-Reply-To: <20030401040106.65664.qmail@web14906.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, DirectFB-devel <directfb-dev@directfb.org>

On Tue, 2003-04-01 at 12:01, Jon Smirl wrote:
> --- Antonino Daplas <adaplas@pol.net> wrote:
> > A new device seems more powerful and more generic. 
> > Generic in a sense
> > that other subsystems besides fbdev can use it to
> > access the BIOS or
> 
> The new device is going to need to sort out multiple
> adapters. Using /dev/fbX avoids that problem. You'll

No, it won't.  If multiple graphics adapters are to be supported, what's
needed is a hardware unique identifier that is known to both caller and
callee.  /dev/fbX will not tell you anything about the device.  This
unique ID can be the bus, device and function number.  So whether the
request is done through /dev/fbX or /dev/vm86, the ID must still be
specified.

> also be able to get the /dev/fb code into the kernel.
> Getting a driver in that creates /dev/vm86 is going to
> be harder. 

I would rather have the code rejected than back-dooring it behind fbdev.
If it's going to be accepted, it has to be on its own merit.

> 
> I'm not clear on what /dev/vm86 does. Why couldn't the

/dev/vm86 just controls how data gets to and from the daemon.  What kind
of data passes through it does not matter.  Only the daemon and the
caller should know what protocol is used.

> radeon driver exec vm86d with a parameter of /dev/fb0.
> vm86d would then open/IOCTL the radeon driver to
> identify the PCI device and what actions are needed.
> After it resets and gets the EDID data it would IOCTL
> them back into /dev/fb0 and exit. You need to know
> which PCI device so that you can set up the right
> VBIOS ROM. Each adapter would get it's own vm86d, but
> they wouldn't hang around long.
> 

Yes, in a similar manner, fbdev can pass a request through /dev/vm86
that says "run expansion ROM code of device with this unique ID".  The
daemon will then do just that.  It does not matter if the device is a
VGA controller, or some other PCI device.  It also will not matter if
the expansion ROM is in x86 form, OpenFirmware, etc, it's up to the
daemon.

The hardest part that the daemon will do is maintaining separate virtual
mode environments if the device happens to be a VGA controller.  This is
only needed if the VBIOS are to be consistently required. Other types of
PCI devices should not suffer the same limitation.
 

Tony




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
