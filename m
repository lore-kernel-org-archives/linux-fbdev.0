From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 21:56:18 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <53283.64.139.3.221.1083128178.squirrel@www.foogod.com>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
        <408EF0D9.6000403@undead.cc>
        <1083109849.20091.1.camel@gaston>
        <408EFD18.7070702@undead.cc>
        <1083112862.20474.14.camel@gaston>
        <408F0B61.5090806@undead.cc>
        <52520.64.139.3.221.1083122220.squirrel@www.foogod.com>
        <408F34BA.2090105@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIh7V-0004oH-Bk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 21:56:29 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIh7S-0000Ib-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 21:56:26 -0700
In-Reply-To: <408F34BA.2090105@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: grim@undead.cc
Cc: alex@foogod.com, benh@kernel.crashing.org, jsimmons@infradead.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

>> Firstly, all of the graphical apps you're describing should be
>> VT-aware.  If they aren't, you shouldn't be using them on anything
>> other than dedicated framebuffers anyway, really.  It's not hard to
>> make an app work with VTs and it really is the correct way to do things
>> for anything that is likely to be run in a VT-console environment.
>>
> Hmm, I'll have to do some hunting.  What is the easy way to find out if
> you're on a physical console and what vc num it is in user space?  I can
>  do it easily in kernel space...

Umm, the point is you don't have to.  Just create a new VT for whatever
you're doing.  If you have permission to do it, you will get a VT you can
work with.  If you don't, you'll get an error.  Ultimately, it shouldn't
matter whether you're being started from a VT to begin with anyway (a user
_should_ be able to login via ssh or serial console or whatever and start
up a framebuffer app if they want to and have the permissions to.  This is
one of the fundamental principles of unix (the user knows what they want
to do better than the OS does.  The OS shouldn't get in the way of
that.)).  If a different user is currently using the framebuffer for their
console (or app or whatever), the permissions should be set to protect it,
otherwise it's fair game.

>> With this issue solved, all that needs to be done is to make it so that
>> apps which open up a new VT, automatically get it on the same
>> framebuffer as the currently active console (or better yet, the console
>> associated with the app) is on (which is really the most intuitive
>> thing anyway, and should probably be done on general principle).
>> Problem solved.
>>
> That might be tricky as you'd probably have to change the con2fb map to
> remap the unused console to the right fb.

Actually, no, the point I was making is that we should change the
VT/console code to automatically copy the "current" mapping to a new VT
when it gets created, so you don't need to remap anything for this case.

Basically what I'm suggesting pretty much the same thing you are, I'm just
saying we should do it with the existing VT infrastructure instead of
creating a new /dev/fb for what's basically a very similar thing to what
VT is already supposed to handle more generally (controlling which screens
consoles/apps access and when).

-alex




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
