From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Best way to support mulitple planes?
Date: Sun, 16 Sep 2007 10:32:53 +0800
Message-ID: <1189909973.5344.12.camel@daplas>
References: <46E9949E.30908@freescale.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWjwW-0006qt-Sw for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 19:33:05 -0700
Received: from wa-out-1112.google.com ([209.85.146.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWjwU-0007OL-0N
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 19:33:04 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1650845waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Sep 2007 19:33:01 -0700 (PDT)
In-Reply-To: <46E9949E.30908@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Thu, 2007-09-13 at 14:50 -0500, Timur Tabi wrote:
> Hi, I'm new to the framebuffer subsystem, so forgive me if this is a FAQ. 
> I've spent the past couple hours scouring web sites and sample code, but I 
> don't have a definitive answer to my question.
> 
> I have a device that supports three planes - memory areas that the hardware 
> reads from to generate the physical image.  Each plane supports an alpha 
> channel for each pixel, and the hardware just blends all three planes together 
> when it draws the image.
> 
> Currently, our driver create three framebuffer devices, /dev/fb0, /dev/fb1, 
> and /dev/fb2, which means three calls to register_framebuffer().  Is this the 
> correct way to do it?

One method is to create device, /dev/fb0, then create a custom fb_mmap()
that, depending on the parameters, will return a different address for
each of the 3 planes. (We already mmap the framebuffer and the MMIO
separately by this method). Then it is up to the user application to
call mmap() 3x for each plane and what to write to those planes.

Or, assuming each plane is located in single framebuffer region with
just different offsets, then instead of creating a custom fb_mmap(),
create a custom ioctl that will return the offsets relative to the start
of the framebuffer of each plane.

> 
> The reason I ask is that our hardware can only handle three planes if the 
> resolution is 1024x768 or below.  I can't figure out any way of telling the 
> framebuffer subsystem that if it switches to 1280x1024 in plane 0, that plane 
> 1 and 2 no longer exist.  Any suggestions on how to handle that?

You can change the type from FB_TYPE_PLANES to FB_TYPE_PACKED_PIXELS in
fb_fix_screeninfo.  That implies that for each SET_VAR ioctl, you do a
GET_FIX ioctl.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
