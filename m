From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this one works ;-)
Date: Tue, 27 Apr 2004 21:43:51 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <53204.64.139.3.221.1083127431.squirrel@www.foogod.com>
References: <1083108311.16476.56.camel@gaston>
        <Pine.LNX.4.44.0404280039460.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIgvU-0002fF-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 21:44:04 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIgvU-0005qp-9J
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 21:44:04 -0700
In-Reply-To: <Pine.LNX.4.44.0404280039460.23153-100000@phoenix.infradead.org>
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
To: jsimmons@infradead.org
Cc: benh@kernel.crashing.org, grim@undead.cc, eger-dated-1083663529.7e8c27@theboonies.us, geert@linux-m68k.org, adaplas@hotpop.com, eger-dated-1082943669.d79d33@theboonies.us, linux-fbdev-devel@lists.sourceforge.net

>> > 1) Color depth.
>> > 2) Frequency.
>> > 3) Over scan color.
>>
>> No, no, no ... We don't need those, we need a var structure, that's
>> all.

I agree, a var structure is how video modes are represented, and should be
the way they're always represented.  Anything else will either be
inadequate or horribly duplicative.  I also think that storing pixel
resolutions and depths (let alone frequencies, etc) in a layer that
shouldn't even know what a framebuffer is generally a poor way to do
things.

> No. Look the logic should go from the upper VT layer to the lower driver
>  to accomplish something. Not the reverse.
>
> struct vc_data -> native console driver structure --> fbdev
>
> Not.
>
> fbdev --> native console driver --> struct vc_data.

Heh, well, I hope I'm not stirring things up too much here if I say I
think both of those paths are wrong :)

Actually, I think we're going round and round here partly because nobody
has really sat down and thought about what roles different components
should be playing in the overall system.

The way I see it, we have the following components, which perform the
following general tasks (note, I'm talking intended functionality, not
necessarily exact implementation):

framebuffer device driver (fbdev) - manages the actual hardware.
fbcon - Represents a text console using a framebuffer for display.
console - upper layer (generic) console system.
vt - allows multiple things (consoles, other apps) to access the same
display and input hardware.
other apps - VT-aware userland framebuffer apps.

Now one of the problems I see with things at the moment, is that some of
these components (vt and the console stuff in particular) have very
ambiguous and sometimes conflicting heirarchies in the current
implementation.  I think it would be good to start by defining what the
right relationships between these components should be.

The way I see it, if we formalize the boundaries between these components
a bit better, the best arrangement is something like the following:

1. fbdev sits on the bottom, talks to the hardware. (this is pretty obvious)

2. vt sits on top of fbdev.  Its purpose is to arbitrate access to
hardware resources.  It does not care about consoles, or display settings,
just who's allowed to talk to the device drivers right now.

3. fbcon sits on top of vt.  It uses vt to obtain access to fbdev, just
like any other application should.  vt should not really need to care that
this is a console as opposed to any other application which just wants to
access the framebuffer.

4. console sits on top of fbcon (for display) and vt (for keyboard access).

5. other apps sit on top of vt, to talk to fbdev (and possibly keyboard,
etc).
 _____________________________
|     console     |     |     |
|-----------------|other|other|
|      fbcon      | app | app |
|-----------------+-----+-----|
| (1) | (2) | (3) | (4) | (5) |
| :::::::::::: vt ::::::::::::|
|--------------.--------------'
|     fbdev    |   keyboard   |
`--------------'--------------'

Now, first of all, I realize this is not the way things currently work.  I
think this is part of the problem.  In the proposed heirarchy, fbcon and
the rest of the console are treated exactly the same as any other
application from the standpoint of accessing the framebuffer. 
Applications do not need to know or care whether there's a console running
on this framebuffer or not if they're just wanting to draw on a
framebuffer, and vt doesn't have to know or care what a "video mode" is.

If we want to set the video mode used by a framebuffer console, we should
tell fbcon.  fbcon is (by definition) the only component which has (or
should have) a concept of "video mode" and also has a concept of
"console".  fbcon sets the appropriate var using fbdev (assuming vt says
it is the currently active app for that screen), and then remembers what
the right var is for future reference.  Any time vt changes to another VT,
and then changes back to this one, fbdev gets notified that this VT has
become active again, and can re-set fbdev's var to the right values.

This of course requires that we have some appropriate way for something
like fbset to "tell fbcon" to change the video mode.  I suggest it just be
done through a fbcon-specific console ioctl (console passes it through to
fbcon, fbcon interprets it and communicates with fbdev as appropriate). 
vt never comes into the picture.

By moving the console and fbcon code out to the same layer as other
VT-aware framebuffer applications, the architecture becomes much cleaner,
and a bunch of the nagging little issues we're currently discussing become
a lot easier to deal with.

So now you can all tell me how much crap you think this suggestion is..

-alex




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
