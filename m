From: Gutko <gutko@poczta.onet.pl>
Subject: Re: Console Framebuffer Issues / GeForce4 - Red
 Hat stock kernel 2.4.20-13.9
Date: Sat, 24 May 2003 19:58:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3ECFB2B5.60004@poczta.onet.pl>
References: <200305241339.23874.rkvaughan@carolina.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp3.poczta.onet.pl ([213.180.130.29])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19JdHq-0007zD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 24 May 2003 10:58:30 -0700
In-Reply-To: <200305241339.23874.rkvaughan@carolina.rr.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Robert Keith Vaughan wrote:
> Hello:
> 
> I apologize if this is the wrong list to post to, but it was suggested in a 
> post I dug up through a google search.  I normally like to figure things out 
> for myself, but this one is really starting to tick me off.
> 
> I am using Red Hat 9.0 with the stock 2.4.20-13.9 kernel.  I am attempting to 
> get framebuffer support working on the console with little success. The 
> relevant PC specs are as follows:
> 
> Athlon XP 2000+
> 1 GB RAM
> Geforce4 ti4400
> 
>>From what I have been able to ascertain, vesafb is compiled into this kernel 
> instead of loading as a module.  I looked at the information for the rivafb 
> driver and it doesn't appear to support the GeForce4 cards.  What info I have 
> been able to dig up suggests that you can get non-accelerated framebuffer 
> support for the GeForce4 using vesafb.  I cannot, however, get it to work.
> 
> I have tried to pass the following kernel arguments via grub.  All I get is a 
> blank screen"
> 
> video=vesafb,xres:1024,yres:768,bpp:16 vga=791
> 
> 	AND (just in case I COULD get the rivafb module to support it)
> 
> video=rivafb,xres:1024,yres:768,bpp:16 vga=791 
> 
> I have played around with the bpp and vga= settings (trying 8, 16 and 24 
> respectively) .  No luck.  Get a blank console up until kdm loads. And I 
> don't see anthing in the dmesg logs either.  Sigh.
> 
> When I issue fbset I get the following error:
> 
>   open /dev/fb0: No such device
> 
> Which leads me to believe that the stock kernel isn't seeing a framebuffer 
> device despite the fact that vesafb is compiled in.  
> 
> I have not yet tried to compile a custom kernel precisely because of 1.) 
> vesafb is complied into this kernel, AND 2.) Nothing I have read seems to 
> indicate that compiling rivafb into the kernel will help with my issue ( and 
> I have not been able to get rivafb to load as a module in any event...)
> 
> So, I am stumped.  I'm sure its something stupid on my part....but could 
> anyone tell me A.) what I am doing wrong here, and/or B.) if anyone has 
> gotten console framebuffer support running on a stock Red Hat kernel...
> 
> Thanks for putting up with the long winded (and I sure stupid) questions..
> 
> Keith Vaughan
> 
  try passing "mem=512M" to kernel in lilo. It worked for me...I also 
have 1GB of ram




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
