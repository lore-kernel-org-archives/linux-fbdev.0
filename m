From: Pavel Machek <pavel@suse.cz>
Subject: Re: Cursor problems still in test9
Date: Thu, 30 Oct 2003 10:09:34 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030090934.GC295@elf.ucw.cz>
References: <20031028094907.GA1319@elf.ucw.cz> <Pine.LNX.4.44.0310300436440.28721-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF8oa-0001u6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 01:10:00 -0800
Received: from gprs197-81.eurotel.cz ([160.218.197.81] helo=amd.ucw.cz)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AF8oW-0004Wl-IA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 01:09:58 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310300436440.28721-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

> > [And they get worse in fbcon-test patches I tried].
> > 
> > Try this on 2.4 (with vesafb).
> > 
> > echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"
> > 
> > ...then try it on 2.6, type foo in bash then delete it using
> > backspace; ghost cursors stay there. Run emacs and quit it (it sets
> > cursor to very visible). Boom, special cursor settings are gone.
> 
> I experimented with the above. I tried it out on vgacon, fbcon 2.4.X and 
> fbcon 2.6.X. All give different results. What are suppose to see? 

Well, we certainly do not want to see artifacts leaved behind cursor,
which is what 2.6 currently does. (Type something in bash, backspace
over it).

Making it behave like it does now with 2.6, but with cursor properly
deleted after after backspace, it would be okay.

[It should behave the same way on 2.4 vgacon and fbcon... with
possible difference that "bright background" might cause characters to
blink on vgacon. That depends on vga card setting and is not really
important.]

> > And now, use gpm on text console to select some text. Hold down left
> > button, move mouse a bit. Sometimes cursor gets corrupted and stays
> > there.
> 
> Will try.

Were you able to reproduce it?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
