From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 21 Jan 2003 06:44:11 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043102561.1064.36.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301150042470.23774-100000@phoenix.infradead.org>
	<200301182028.33155.rfjak@eircom.net>
	<1042990390.1058.4.camel@localhost.localdomain> 
	<200301201909.10951.rfjak@eircom.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ako0-0000XR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 14:54:12 -0800
In-Reply-To: <200301201909.10951.rfjak@eircom.net>
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
To: Jak <rfjak@eircom.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-01-21 at 03:09, Jak wrote:
> Tony,
> 	thanks for your patches, they have fixed most of the problems I had.
> >
> > Try running stty to fix your display.
> >
> I can't convince stty to do anything useful for me :
> 	do I need a specific/patched version ?

No.
> 	do I need to specify anything except rows cols values ?

No.
> 	how would I change the colour depth ?

You can still use fbset :-), except that as it currently stands, it
might corrupt the display if panning is enabled.  rivafb does not
support panning at bootup so fbset is safe to use.

> 	I have 7 different lines in /etc/fb.modes related to 1024x768@8bpp,
> how can I tell stty that I want to use the equivalent of the timing values of
> any particular one of these 7 modes ( assuming timings are still relevant ) ?

Bullseye :-) This is one of the reasons I submitted the GTF
implementation patch (It's already in fbmon.c).  The patch will compute
the modelines for you given xres, yres and your monitor's operational
limits.  It has the advantage of computing the maximum refresh rate your
monitor is capable of, and it can theoretically calculate any mode
without the use of additional entries in /etc/fb.modes.  This is ideal
for VESA GTF compliant monitors but I have tested this with old monitors
as well.

Once you have changed to an appropriate window size, you can then use
fbset to fine-tune your display timings.

The only problem right now is how do you pass the monitor info to the
driver?  The best way is to parse the EDID block and use I2C/DDC. 
Personally, I think passing the monitor info as a boot/module option is
the simplest and safest method.

Once the above is done, adding support for GTF to a driver is just a
10-liner code.  I already did this for some of the drivers including
rivafb.

Of course, proprietary displays will need their own modeline formula
which, if this is the case, the driver has to add its own algorithm or
use fbset tricks.  You can do something like this:

fbset 1600x1200-85 && stty cols 200 rows 75
 
> 	what was wrong with fbset which I have to keep for the forseeable
> future anyway until 2.6 approaches 2.4 reliability ?

Nothing's wrong with fbset, because if fbset becomes unusable, then so
will most fbdev-based applications.  We don't want that to happen.

The main difference is instead of fbdev telling the console to change
the window size, it's now the console telling fbdev to change the window
size.  As the console is blind to color depth, pixelformat, accel, etc,
you can still use fbset to change most of the above.

> >
> > So can you and Jak try the attached patch?  It should prevent VGA
> > console corruption on insmod and it should eliminate the kobject trace
> > messages.
> >
> Using your 3 recent patches together clears up the green screen problem
> and text corruption as well as kobject "badness".
> 
> >  int __init rivafb_init(void)
> >  {
> > -	int err;
> > -	err = pci_module_init(&rivafb_driver);
> > -	if (err)
> > -		return err;
> > -	pci_register_driver(&rivafb_driver);
> > -	return 0;
> > +	return pci_module_init(&rivafb_driver);
> >  }
> >
> This will normally return 1, not 0 as before. Is this intended ?

The above should return 0 if successful.


Tony




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
