From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 09:08:58 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D2E96A.9000605@undead.cc>
References: <40D21E31.5070904@winischhofer.net> <200406180945.06335.adaplas@hotpop.com> <40D29FCD.7020602@winischhofer.net> <Pine.GSO.4.58.0406181013340.11779@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbJ7K-0001RV-SI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:09:14 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BbJ7K-00010N-7a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:09:14 -0700
In-Reply-To: <Pine.GSO.4.58.0406181013340.11779@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>Solution: before initializing and switching to a fbdev, save the contents of
>the VGA text memory to the `shadow screen', so the fbdev can clear the frame
>buffer memory, and fbcon can recover the current VC contents.
>
>However, it makes things more complex and adds a vgacon dependency to some
>code, since you want it to behave differently if people don't compile in
>vgacon.
>  
>
That was the old solution.  I found the root cause of the problem.   
There is no code in the vt subsystem to prevent output going to a 
console driver after it has been deinitialized.  The vga console does 
save the VGA memory to it's shadow screen when it's deinitialized but 
any printk's after that screw things up as it starts to output again to 
the screen.  Now the shadow screen and the real screen doesn't match 
anymore.

If it were possible to take over from fbcon to another console driver 
this would have caused an oops as the fbcon font data would have been 
freed at that point.  The vga console doesn't have any extra data that 
needs to be freed so that's why this bug was never noticed.

I posted a fix on May 6th to the vt take_over_console function which 
puts the console temporarily into KD_GRAPHICS so that all output between 
con_deinit and visual_init (where there is no active console driver) go 
to the shadow screen.  This is not vgacon specific and would also make 
it possible to switch between other console drivers without causing an oops.

>Final solution: VGA is obsolete ;-)
>  
>

I wish.  Hopefully the new EFI firmware on x86 platforms will initialize 
the video card into it's native graphics configuration so we can start 
dropping this excess VGA baggage we've been carrying for the last 
several years.  Of course there's always linuxbios as well.  :)  What's 
the story with VGA on other platforms? 

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
