From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
Date: Tue, 7 Jan 2003 21:43:06 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072139130.17129-100000@phoenix.infradead.org>
References: <1041717978.1052.23.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W1Vd-0002Dn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 13:43:41 -0800
In-Reply-To: <1041717978.1052.23.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> Personally, that's fine by me since I have no need for those 2
> extensions.  But please apply the accel_putcs() buffer overrun patch.

Applied. 

> BTW, attached is another patch that will change the resolution of the
> console via tty ioctl TIOCSWINSZ.  I'm not sure if this is the correct
> solution, but it's the only one I can think of without really adding a
> lot of extra code.  This is implemented by adding a con_resize() hook to
> fbcon, so the window size can be changed such as by using:
>
> stty cols 128 rows 48 (1024x768 with font 8x16)

Yes this is the correct approach.
 
> The new window size should also be preserved per console.  Still, there
> are other fb parameters that can screw up the console (such as changing
> yres_virtual and bits_per_pixel) but the window size is the most
> important.

Updatevar in fbcon.c should handle yres_virtual properly. The scrolling 
code needs alot of work. It is a mess. Bits_per_pixel will be trickier to 
handle. 



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
