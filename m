From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Double buffering amba-clcd fb driver
Date: Wed, 18 Oct 2006 14:24:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0610181421460.29508@pademelon.sonytel.be>
References: <55a8df6f0610180327o2fe790actcfca77c94b067919@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GaATS-0005Uq-TD for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 05:24:42 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GaATR-0006mh-87
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 05:24:42 -0700
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k9ICO7sn015423
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Oct 2006 14:24:07 +0200 (MEST)
In-Reply-To: <55a8df6f0610180327o2fe790actcfca77c94b067919@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 18 Oct 2006, Ramya Segar wrote:
> I m a realtive newcomer to linux and device drivers in particular.
> I have doubts regrading how to enable double buffering in the fb driver for
> amba-clcd.
> I m interested in knowing how to enable double bufefring, where two buffers
> are allocated and swapped during vertical blanking period (this is how i
> understood it).
> As I understand it, the dbe extension of XFree86 X server provides software
> double buffering, where each window has two buffers, a front and back..
> If you can point me to any documentation on this, it would be a great help..

If your graphics engine supports virtual screens and panning, one simple way is
this:
  - Make the virtual vertical resolution (fb_var_screeninfo.yres_virtual) 2
    times the real vertical resolution (fb_var_screeninfo.yres)
  - Use panning to switch from the top (fb_var_screeninfo.yoffset = 0) to the
    bottom (fb_var_screeninfo.yoffset = fb_var_screeninfo.yres) and vice versa

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
