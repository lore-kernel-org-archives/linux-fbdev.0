From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 20:17:00 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <52520.64.139.3.221.1083122220.squirrel@www.foogod.com>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
        <408EF0D9.6000403@undead.cc>
        <1083109849.20091.1.camel@gaston>
        <408EFD18.7070702@undead.cc>
        <1083112862.20474.14.camel@gaston>
        <408F0B61.5090806@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIfZW-0004TA-Uo
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 20:17:18 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIfZU-00027d-PJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 20:17:16 -0700
In-Reply-To: <408F0B61.5090806@undead.cc>
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
Cc: benh@kernel.crashing.org, jsimmons@infradead.org, geert@linux-m68k.org, alex@foogod.com, linux-fbdev-devel@lists.sourceforge.net

> Benjamin Herrenschmidt wrote:
>
>>You don't need a /dev/fb for that do you ? You need to map the current
>> vt to it's fb via the existing fbdev ioctls, isn't that possible ?
>> (just asking , I've never actually done that).
>>
>>
>>
> But how does the app find this out?  It would have to figure out if it's
>  running on a real console then figure out which console is mapped to
> which fb and then try to find out which /dev/fbx device points to that
> fb.  Programmer's are lazy, they'll just make it a command line switch
> to specify what device to use which is not very user friendly.
>
> What I'm proposing is that you open /dev/fb.  If it fails you're running
>  on a serial line or shh or whatever.  If it succedes you issue
> KD_GRAPHICS ioctl on the /dev/fb device and that's it.  Very simple for
> the programmer.

I like the idea of having graphical apps automatically open on the same
framebuffer device as the console they were started from, but I agree with
Ben, I think this approach is way more complicated than it needs to be.

Firstly, all of the graphical apps you're describing should be VT-aware. 
If they aren't, you shouldn't be using them on anything other than
dedicated framebuffers anyway, really.  It's not hard to make an app work
with VTs and it really is the correct way to do things for anything that
is likely to be run in a VT-console environment.

With this issue solved, all that needs to be done is to make it so that
apps which open up a new VT, automatically get it on the same framebuffer
as the currently active console (or better yet, the console associated
with the app) is on (which is really the most intuitive thing anyway, and
should probably be done on general principle).  Problem solved.

You really don't need all the complex machinations of a magic /dev/fb
device to achieve this.  If the rest of the system is designed well the
right behavior should be automatic without this extra effort.

-alex




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
