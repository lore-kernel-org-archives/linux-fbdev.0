From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Best way to support mulitple planes?
Date: Sun, 16 Sep 2007 10:45:09 +0800
Message-ID: <1189910709.5344.23.camel@daplas>
References: <46E9949E.30908@freescale.com> <1189909973.5344.12.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWk8I-0007z3-Hv for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 19:45:14 -0700
Received: from rv-out-0910.google.com ([209.85.198.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWk8I-0007rg-AC
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 19:45:14 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3991604rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Sep 2007 19:45:13 -0700 (PDT)
In-Reply-To: <1189909973.5344.12.camel@daplas>
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

On Sun, 2007-09-16 at 10:32 +0800, Antonino A. Daplas wrote:
> On Thu, 2007-09-13 at 14:50 -0500, Timur Tabi wrote:
> > 
> > The reason I ask is that our hardware can only handle three planes if the 
> > resolution is 1024x768 or below.  I can't figure out any way of telling the 
> > framebuffer subsystem that if it switches to 1280x1024 in plane 0, that plane 
> > 1 and 2 no longer exist.  Any suggestions on how to handle that?
> 
> You can change the type from FB_TYPE_PLANES to FB_TYPE_PACKED_PIXELS in
> fb_fix_screeninfo.  That implies that for each SET_VAR ioctl, you do a
> GET_FIX ioctl.
> 

If you want separate /dev/fb's for each plane, then setup your own
notifier system so each of the /dev/fb's  can communicate with each
other.

See drivers/video/fb_notify.c, and look at
drivers/video/backlight/backlight.c, drivers/video/fbmem.c and
drivers/video/console/fbcon.c on how this communication is done.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
