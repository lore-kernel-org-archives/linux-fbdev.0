From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Re: Questions about fbdriver integration
Date: Sun, 25 Nov 2007 11:51:53 +0100
Message-ID: <20071125105153.GH3183@pruts.nl>
References: <20071124214325.GD3183@pruts.nl>
	<Pine.LNX.4.64.0711250947380.21779@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwF5q-0005SM-Nq for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 02:52:06 -0800
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwF5q-0000zI-6d
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 02:52:06 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pruts.nl (Postfix) with ESMTP id 0528412E42C
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 11:52:04 +0100 (CET)
Received: from iron.pruts.nl ([127.0.0.1])
	by localhost (iron.pruts.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9IyIGOuKWMCl
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 11:51:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711250947380.21779@anakin>
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



* On 2007-11-25 Geert Uytterhoeven <geert@linux-m68k.org> wrote  :

> On Sat, 24 Nov 2007, Ico Doornekamp wrote:
> > I have just finished writing a framebuffer driver for a LCD display
> > connected to our embedded system (monochrome, 128x64, GPIO driven).
> > It's very similar to the hecubafb driver, and uses deferred IO. I've
> > included some of the drivers properties at the end of this mail.  Things
> > works fine when displaying images by doing write()s to /dev/fb0, so this
> > part seems to be ok.
> > 
> > I hope some of the regulars on this list can clear up some issues
> > I've run into when using this driver:
> > 
> > - My next step as to redirect the linux console to this framebuffer
> >   device. I've configured the kernel for framebuffer console, and when
> >   loading the fbcon module, the message 
> >     
> >      Console: switching to mono frame buffer device 16x4" 
> >      
> >   appears, and
> > 
> >      cat /sys/class/vtconsole/vtcon1/name -> (M) frame buffer device
> >      cat /sys/class/vtconsole/vtcon1/bind -> 1
> >   
> >   This seems just fine to me, but however, no output appears on the
> >   display: just a blank screen. 
> > 
> >   It seems that the console is doing *something*, since my driver gets
> >   triggered by the deferred IO every 200msec (blinking cursor?), problem
> >   is that the data arriving in my driver is all zeroes!
> 
> Fbcon writes to the memory at fb_info.screen_base.

That is what I expected. I'll have to do a bit more debugging here then.

> > - The other question is more a userspace issue: I was hoping to use the
> >   xorg fbdev server on my dislay, but unfortunately this does not seem
> >   to support 1 bit depth displays :
> > 
> >     (EE) FBDEV(0): unsupported number of bits per pixel: 1
> > 
> >   Is there a way to make X work on 1-bit fb devices, or am I out of luck
> >   here ?
> 
> The old XF86_FBDev (from XFree86 3.x) definitely works with monochrome.
> I expect (but never tried) KDrive also to support it.
> 
> It's a pity many frame buffer organizations were dropped in Xorg.

It is, yes. I'll give Kdrive a try, or as an alternative I can make my
framebuffer 8-bit greycale instead of monochrome, with a simple
threshold. I'll be using simple monochrome apps with some text only, so
that will probably be sufficient.

Thanks,

Ico

-- 
:wq
^X^Cy^K^X^C^C^C^C

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
