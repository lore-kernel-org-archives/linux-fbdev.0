From: John Zielinski <grim@undead.cc>
Subject: Re: Restoring Screen when coming back from	KD_GRAPHICS
Date: Wed, 24 Dec 2003 17:07:09 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEA0E0D.3030001@undead.cc>
References: <3FC4603C.2000702@undead.cc> <1072254378.739.65.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZHA7-0005s1-77
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 14:07:27 -0800
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZHA6-0003Mz-OO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 14:07:26 -0800
In-Reply-To: <1072254378.739.65.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

Benjamin Herrenschmidt wrote:

>That's an old problem, I think your patch isn't enough though, we really
>need to first callback into the fbdev layer with some sort of "restore state"
>call so we have a chance to restore the palette and accel engine status
>properly (and maybe even the mode).
>
>Basically, when switching to KD_TEXT, we switch from userland having taken
>control of the HW (either partially, that is only the accel engine, or
>completely including mode setting) back to kernel control. At this point,
>we need to restore the HW in a known state, we can't rely on userland to
>do it properly (and that's not always possible) while it's very simple
>for us to do it from the fbdev.
>
>It's on my todolist of things to fix, but still I lack time, if you feel
>like implementing the background (we can fix individual drivers later on)
>support for that, go on :)
>  
>

I'll take a look.  This fits well with what I'm trying to do with the 
mode switching between virtual terminals.  The callback will definately 
be neccessarry to tell the driver to save any driver specific data that 
I'm not already saving (ie anything that's not defined in fb.h).

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
