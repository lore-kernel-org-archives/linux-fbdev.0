From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
 2.5.5[45]
Date: Sat, 25 Jan 2003 10:00:32 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301250955070.27544-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301242252410.2597-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cMC8-0004qS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 Jan 2003 01:01:45 -0800
In-Reply-To: <Pine.LNX.4.44.0301242252410.2597-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Jak <rfjak@eircom.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 24 Jan 2003, James Simmons wrote:
> > > The only problem right now is how do you pass the monitor info to the
> > > driver?  The best way is to parse the EDID block and use I2C/DDC. 
> > > Personally, I think passing the monitor info as a boot/module option is
> > > the simplest and safest method.
> > 
> > Through sysfs? echo MY_MONITOR_LIMITS > /proc/...?
> > 
> > Since ioctls are considered evil these days, changing the resolution etc. could
> > work in a similar way as well.
> 
> Can you do this with sysfs? This is what I have been waiting for!!! The 
> proc thing is don't care for tho.

Yes, you can create a fbdev filesystem, which shows frame buffers and
information about them. By changing the contents of those virtual files (e.g. a
file that corresponds to struct fb_var_screeninfo), you can change the video
mode.  This can also solve the burden of maintaining backwards compatibility in
struct fb_var_screeninfo. You want a new field? Just add a new virtual file to
the filesystem.

One thing I'm still wondering about is how to keep things synchronized. You
don't want to put all fields of struct fb_var_screeninfo in one file, you want
separate files for resolution, timings, .... But in the end you usually want to
change a video mode by changing all parameters at once, so you want the changes
to the different virtual files to be synchronized. Perhaps some lock file?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
