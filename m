From: James Simmons <jsimmons@infradead.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
 2.5.5[45]
Date: Fri, 24 Jan 2003 22:53:35 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301242252410.2597-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301211126490.24563-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cCiE-0003Vd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 14:54:14 -0800
In-Reply-To: <Pine.GSO.4.21.0301211126490.24563-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Jak <rfjak@eircom.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > The only problem right now is how do you pass the monitor info to the
> > driver?  The best way is to parse the EDID block and use I2C/DDC. 
> > Personally, I think passing the monitor info as a boot/module option is
> > the simplest and safest method.
> 
> Through sysfs? echo MY_MONITOR_LIMITS > /proc/...?
> 
> Since ioctls are considered evil these days, changing the resolution etc. could
> work in a similar way as well.

Can you do this with sysfs? This is what I have been waiting for!!! The 
proc thing is don't care for tho.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
