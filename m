From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] broken cfb* support in the 2.5.31-bk
Date: Thu, 22 Aug 2002 10:06:24 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208220950170.8777-100000@maxwell.earthlink.net>
References: <15708.14066.32752.365661@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hvm5-0005nv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 10:29:37 -0700
In-Reply-To: <15708.14066.32752.365661@argo.ozlabs.ibm.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > That was done to push people to port there drivers to the new api.
>
> Well, what _is_ the new API?

From the details in skeletonfb.c.

 *  I have started rewriting this driver as a example of the upcoming new API
 *  The primary goal is to remove the console code from fbdev and place it
 *  into fbcon.c. This reduces the code and makes writing a new fbdev driver
 *  easy since the author doesn't need to worry about console internals. It
 *  also allows the ability to run fbdev without a console/tty system on top
 *  of it.
 *
 *  First the roles of struct fb_info and struct display have changed. Struct
 *  display will go away. The way the the new framebuffer console code will
 *  work is that it will act to translate data about the tty/console in
 *  struct vc_data to data in a device independent way in struct fb_info. Then
 *  various functions in struct fb_ops will be called to store the device
 *  dependent state in the par field in struct fb_info and to change the
 *  hardware to that state. This allows a very clean seperation of the fbdev
 *  layer from the console layer. It also allows one to use fbdev on its own
 *  which is a bounus for embedded devices. The reason this approach works is
 *  for each framebuffer device when used as a tty/console device is allocated
 *  a set of virtual terminals to it. Only one virtual terminal can be active
 *  per framebuffer device. We already have all the data we need in struct
 *  vc_data so why store a bunch of colormaps and other fbdev specific data
 *  per virtual terminal.

 *  As you can see doing this makes the con parameter pretty much useless
 *  for struct fb_ops functions, as it should be. Also having struct
 *  fb_var_screeninfo and other data in fb_info pretty much eliminates the
 *  need for get_fix and get_var. Once all drivers use the fix, var, and cmap
 *  fbcon can be written around these fields. This will also eliminate the
 *  need to regenerate struct fb_var_screeninfo, struct fb_fix_screeninfo
 *  struct fb_cmap every time get_var, get_fix, get_cmap functions are called
 *  as many drivers do now.

See skeletonfb.c for further details.

> Anyway, you could apply this patch, for a start.  I wish you would be
> a bit more careful about details.

Done. Well the good news is I have aquired more hardware for different
platforms to test my work on :-)

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
