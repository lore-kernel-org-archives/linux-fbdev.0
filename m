From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 31 Jan 2003 07:00:25 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043967276.1002.21.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301250955070.27544-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eNsq-0006LX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 15:14:13 -0800
In-Reply-To: <Pine.GSO.4.21.0301250955070.27544-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Jak <rfjak@eircom.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-25 at 17:00, Geert Uytterhoeven wrote:
> On Fri, 24 Jan 2003, James Simmons wrote:
> > > > The only problem right now is how do you pass the monitor info to the
> > > > driver?  The best way is to parse the EDID block and use I2C/DDC. 
> > > > Personally, I think passing the monitor info as a boot/module option is
> > > > the simplest and safest method.
> > > 
> > > Through sysfs? echo MY_MONITOR_LIMITS > /proc/...?
> > > 
> > > Since ioctls are considered evil these days, changing the resolution etc. could
> > > work in a similar way as well.
> > 
> > Can you do this with sysfs? This is what I have been waiting for!!! The 
> > proc thing is don't care for tho.
> 
> Yes, you can create a fbdev filesystem, which shows frame buffers and
> information about them. By changing the contents of those virtual files (e.g. a
> file that corresponds to struct fb_var_screeninfo), you can change the video
> mode.  This can also solve the burden of maintaining backwards compatibility in
> struct fb_var_screeninfo. You want a new field? Just add a new virtual file to
> the filesystem.
> 
> One thing I'm still wondering about is how to keep things synchronized. You
> don't want to put all fields of struct fb_var_screeninfo in one file, you want
> separate files for resolution, timings, .... But in the end you usually want to
> change a video mode by changing all parameters at once, so you want the changes
> to the different virtual files to be synchronized. Perhaps some lock file?
> 

From what I understand about sysfs, you can only have one type per file,
so each field will have to be in separate files.  To synchronize, we can
perhaps use a file ('sync', 'lock', 'update' or whatever) which is
similar in function to fb_var_screeninfo.activate. Only when the user
writes to this file that the new settings are synchronized and we call
fb_set_var() or whatever.

How do you think sysfs support will be written?  Will this mean that the
framebuffer system has to register its own kobject as the top level
entry in sysfs, no?  This would also mean that we need something similar
for the console subsystem if it has to support additional features, ie
rotation?

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
