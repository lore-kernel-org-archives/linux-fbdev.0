From: Robert Keith Vaughan <rkvaughan@carolina.rr.com>
Subject: Console Framebuffer Issues / GeForce4 - Red Hat stock kernel 2.4.20-13.9
Date: Sat, 24 May 2003 13:39:23 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200305241339.23874.rkvaughan@carolina.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ms-smtp-02.southeast.rr.com ([24.93.67.83])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Jcz5-0006x5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 24 May 2003 10:39:07 -0700
Received: from zeus.rkvhome.net (clt25-80-124.carolina.rr.com [24.25.80.124])
	by ms-smtp-02.southeast.rr.com (8.12.5/8.12.2) with ESMTP id h4OHacYf001376
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 24 May 2003 13:36:38 -0400 (EDT)
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello:

I apologize if this is the wrong list to post to, but it was suggested in a 
post I dug up through a google search.  I normally like to figure things out 
for myself, but this one is really starting to tick me off.

I am using Red Hat 9.0 with the stock 2.4.20-13.9 kernel.  I am attempting to 
get framebuffer support working on the console with little success. The 
relevant PC specs are as follows:

Athlon XP 2000+
1 GB RAM
Geforce4 ti4400

From what I have been able to ascertain, vesafb is compiled into this kernel 
instead of loading as a module.  I looked at the information for the rivafb 
driver and it doesn't appear to support the GeForce4 cards.  What info I have 
been able to dig up suggests that you can get non-accelerated framebuffer 
support for the GeForce4 using vesafb.  I cannot, however, get it to work.

I have tried to pass the following kernel arguments via grub.  All I get is a 
blank screen"

video=vesafb,xres:1024,yres:768,bpp:16 vga=791

	AND (just in case I COULD get the rivafb module to support it)

video=rivafb,xres:1024,yres:768,bpp:16 vga=791 

I have played around with the bpp and vga= settings (trying 8, 16 and 24 
respectively) .  No luck.  Get a blank console up until kdm loads. And I 
don't see anthing in the dmesg logs either.  Sigh.

When I issue fbset I get the following error:

  open /dev/fb0: No such device

Which leads me to believe that the stock kernel isn't seeing a framebuffer 
device despite the fact that vesafb is compiled in.  

I have not yet tried to compile a custom kernel precisely because of 1.) 
vesafb is complied into this kernel, AND 2.) Nothing I have read seems to 
indicate that compiling rivafb into the kernel will help with my issue ( and 
I have not been able to get rivafb to load as a module in any event...)

So, I am stumped.  I'm sure its something stupid on my part....but could 
anyone tell me A.) what I am doing wrong here, and/or B.) if anyone has 
gotten console framebuffer support running on a stock Red Hat kernel...

Thanks for putting up with the long winded (and I sure stupid) questions..

Keith Vaughan

-- 

***************************************
  Robert Keith Vaughan, CISSP
  E-mail:  rkvaughan@carolina.rr.com
**************************************



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
