From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 02:59:03 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408F5637.9050903@undead.cc>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>        <408EF0D9.6000403@undead.cc>        <1083109849.20091.1.camel@gaston>        <408EFD18.7070702@undead.cc>        <1083112862.20474.14.camel@gaston>        <408F0B61.5090806@undead.cc>        <52520.64.139.3.221.1083122220.squirrel@www.foogod.com>        <408F34BA.2090105@undead.cc> <53283.64.139.3.221.1083128178.squirrel@www.foogod.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIj2H-0007LP-WF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 23:59:14 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BIj2H-000536-II
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 23:59:13 -0700
In-Reply-To: <53283.64.139.3.221.1083128178.squirrel@www.foogod.com>
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

>Umm, the point is you don't have to.  Just create a new VT for whatever
>you're doing.  If you have permission to do it, you will get a VT you can
>work with.  If you don't, you'll get an error.  Ultimately, it shouldn't
>matter whether you're being started from a VT to begin with anyway (a user
>_should_ be able to login via ssh or serial console or whatever and start
>up a framebuffer app if they want to and have the permissions to.  This is
>one of the fundamental principles of unix (the user knows what they want
>to do better than the OS does.  The OS shouldn't get in the way of
>that.)).  If a different user is currently using the framebuffer for their
>console (or app or whatever), the permissions should be set to protect it,
>otherwise it's fair game.
>
>  
>
Depends on how you look at it.  If a user is on console 1 and starts a 
simple app (not a desktop environment) having that jump to console 9 is 
a little confusing.  And there are only so many function keys.  Several 
X sessions will eat up the remaining function keys.  Once all the 
function keys are used then it becomes a royal pain switching VTs. 

As for not mattering whether you're being started from a VT, I'm on the 
other side of the fence here.  When I ssh into a machine, the text 
apears on my local maching and not on the remote.  Same goes for the 
terminal bell and led status.  And when you run an X app the display is 
local as well.   Now the framebuffer breaks away from that.  When I fire 
up a framebuffer app the output doesn't appear locally but on the remote 
machine.  Now I agree that the system shouldn't stop someone from doing 
this if they really want to.  That's why the fb0, fb1, etc devices 
wouldn't stop you running them remote and would have the stricter 
permissions on them (root only for example).

Besides, the person that stole my console from under me remotely would 
be in a world of hurt once I got back into my machine.  :)

>Actually, no, the point I was making is that we should change the
>VT/console code to automatically copy the "current" mapping to a new VT
>when it gets created, so you don't need to remap anything for this case.
>
>  
>
We're both saying the same thing.  When I said "remap" I meant telling 
fbcon to assign a particular framebuffer to that console.

>Basically what I'm suggesting pretty much the same thing you are, I'm just
>saying we should do it with the existing VT infrastructure instead of
>creating a new /dev/fb for what's basically a very similar thing to what
>VT is already supposed to handle more generally (controlling which screens
>consoles/apps access and when).
>  
>

Pretty much.  The only differences are is that I want the app to always 
stay on the same VT number and that the programmer only have to deal 
with one interface.  Why should every frame buffer program be required 
to carry extra VT code and most programmers will be too lazy or won't 
know how to include it.  Even fbtest doesn't have any VT code in it.  
With the code in the kernel even legacy apps will start using the new 
correct behaviour.

John


John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
