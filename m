From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 21 Jan 2003 19:31:24 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043148630.1199.30.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301211126490.24563-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18awmP-0002BJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Jan 2003 03:41:21 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jak <rfjak@eircom.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-01-21 at 18:29, Geert Uytterhoeven wrote:
> On 21 Jan 2003, Antonino Daplas wrote:
> > The only problem right now is how do you pass the monitor info to the
> > driver?  The best way is to parse the EDID block and use I2C/DDC. 
> > Personally, I think passing the monitor info as a boot/module option is
> > the simplest and safest method.
> 
> Through sysfs? echo MY_MONITOR_LIMITS > /proc/...?
> 
> Since ioctls are considered evil these days, changing the resolution etc. could
> work in a similar way as well.
> 

True, but I prefer having the monitor limits at driver load time so I
can immediately go into a high resolution.

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
