From: James Simmons <jsimmons@infradead.org>
Subject: Re: endian problem ?
Date: Fri, 18 Oct 2002 10:43:57 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210181041210.10832-100000@maxwell.earthlink.net>
References: <20021013184921.4571@192.168.4.1>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182bGV-0006F8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 10:50:27 -0700
In-Reply-To: <20021013184921.4571@192.168.4.1>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


On Sun, 13 Oct 2002, Benjamin Herrenschmidt wrote:

> Ok, I've ported radeonfb, controlfb and platinumfb to the
> new API (which is quite nice since allowed me to remove
> a whole bunch of cruft from these drivers, good job !)

Great!!!! Just let me know when you want them placed into fbdev BK.

> However, I'm having a problem: With controlfb and
> radeonfb (couldn't test platinum yet but it's very similar
> to controlfb), the console is fine in 8 bpp, but text is
> plain blue in any higher bit depth (15, 16 or 32).

Okay I have seen this problem on a few drivers. It is either a bug in
setcolreg which is often copied from one place to another or a bug in the
upper levels. I seen this on the atyfb driver happen.

> X with "fbdev" driver works fine, so I think setcolreg
> works properly. All those drivers are set to DIRECTCOLOR
> for these bit depth. Maybe I've missed something about
> the pseudo_palette thing (is it documented somewhere ?)
> or are there known endian bugs in the cfb_* routines ?

I now know it isn't a endian issues since on my little endian machine I
have the same problem. I don't know if it is a cfb_* bug. I will try out
my tdfx card to see. It has accelerated functions so the error woudln't be
there.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
