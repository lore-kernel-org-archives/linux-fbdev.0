From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 00:36:10 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408F34BA.2090105@undead.cc>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>        <408EF0D9.6000403@undead.cc>        <1083109849.20091.1.camel@gaston>        <408EFD18.7070702@undead.cc>        <1083112862.20474.14.camel@gaston>        <408F0B61.5090806@undead.cc> <52520.64.139.3.221.1083122220.squirrel@www.foogod.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIgo0-0001Jf-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 21:36:20 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BIgny-0004S8-G0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 21:36:18 -0700
In-Reply-To: <52520.64.139.3.221.1083122220.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: benh@kernel.crashing.org, jsimmons@infradead.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

Alex Stewart wrote:

>I like the idea of having graphical apps automatically open on the same
>framebuffer device as the console they were started from, but I agree with
>Ben, I think this approach is way more complicated than it needs to be.
>
>  
>
I don't believe it will be complicated but I'll find out after I try to 
implement it.  I just like the fact the the kernel would be able to keep 
applications from doing silly things.  Hey, if it turns out to be an 
ugly patch I'll be the first to delete it.  Who knows, parts of it might 
be useful.  And it's a great way for me to learn more of the innards of 
the vt/fb systems.

>Firstly, all of the graphical apps you're describing should be VT-aware. 
>If they aren't, you shouldn't be using them on anything other than
>dedicated framebuffers anyway, really.  It's not hard to make an app work
>with VTs and it really is the correct way to do things for anything that
>is likely to be run in a VT-console environment.
>  
>
Hmm, I'll have to do some hunting.  What is the easy way to find out if 
you're on a physical console and what vc num it is in user space?  I can 
do it easily in kernel space...

>With this issue solved, all that needs to be done is to make it so that
>apps which open up a new VT, automatically get it on the same framebuffer
>as the currently active console (or better yet, the console associated
>with the app) is on (which is really the most intuitive thing anyway, and
>should probably be done on general principle).  Problem solved.
>
>  
>
That might be tricky as you'd probably have to change the con2fb map to 
remap the unused console to the right fb.

>You really don't need all the complex machinations of a magic /dev/fb
>device to achieve this.  If the rest of the system is designed well the
>right behavior should be automatic without this extra effort.
>
>  
>
Unfortunately it's not automatic.  The programmer has to jump through a 
few hoops that it would take a couple of dozen lines of code in kernel 
space to do.   This is just off the top of my head so it's probably not 
entirely correct:

if( fbidx == 255 ) {
    if( current->tty->driver != console_driver )    
       return -ENODEV;
    fbidx  = con2fb_map[ current->tty->index ];
}

Add another dozen lines to do the the KD_TEXT/KD_GRAPHICS and that's 90% 
of the functionality of the /dev/fb device.

Like I said, it's just a small experiment on my part.  Maybe someone 
will find it useful or maybe they'll get some other ideas from it.  The 
only reason I haven't tried it yet is I have to hunt down where my PCI 
video card disappeared to so I can try it on a dual fb setup.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
