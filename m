From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Mon, 26 Apr 2004 18:15:34 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <10682.171.72.5.133.1083028534.squirrel@www.foogod.com>
References: <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
        <Pine.LNX.4.44.0404261933130.5302-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIHCR-000709-08
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 18:15:51 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIHCQ-0003mM-JD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 18:15:50 -0700
In-Reply-To: <Pine.LNX.4.44.0404261933130.5302-100000@phoenix.infradead.org>
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
Cc: alex@foogod.com, linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org, benh@kernel.crashing.org

> Yipes!!!!! You found a nasty bug in modedb. The present modedb code sets
>  both xres/xres_virtual to the same value and yres/yres_virtual to the
> same value. This means any driver that uses modedb automatically turns
> off  panning. This is bad.

Heh.. and here I thought that was intentional (I assumed it was because
some drivers (which don't support panning) might balk at a perfectly valid
mode if the virtual and actual numbers weren't the same).  I had rather
assumed that other drivers worked around it like I did :)

> The new test I purpose is
>
> if (par->neo2200 && var->bits_per_pixel != 32)
> 	var->accel_flags = FB_ACCELF_TEXT;

Actually, since we don't have any way currently to get var->bits_per_pixel
== 32 (and the driver would need a lot of work to get to that point at
which point this case could (and should) actually be tested instead of
just assuming it doesn't work), why don't we just simplify it to:

if (par->neo2200)
	var->accel_flags = FB_ACCELF_TEXT;

I've never been too clear on what direction these FB_ACCELF things (and
related values) are supposed to be going.  Are they something set by the
driver to indicate what it can support, or are they something set by the
higher level systems (or the user) to tell the driver what they would like
to do?

I had figured from the previous code that these flags should be set when
calling check_var if the higher-level stuff wanted acceleration for the
particular mode setting, and the driver would unset any it wasn't able to
support.  This changes the behavior to automatically turning it on
whenever the hardware is capable of it, regardless of what the higher
level stuff asks for (which is actually probably a better protocol, but is
it the way all the other stuff is expecting it to work?).

Actually, in any case, the current code is still more correct than the
proposed code above.  Under the proposed code, if something sets
FB_ACCELF_TEXT, then calls check_var, FB_ACCELF_TEXT will stay set even if
the hardware can't do it.  We should probably keep the old test in there
too to prevent this case.

Howabout:

if (par->neo2200)
	var->accel_flags = FB_ACCELF_TEXT;
else
	var->accel_flags = 0;

-alex




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
