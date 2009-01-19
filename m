From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
 damage
Date: Mon, 19 Jan 2009 14:59:00 +0200
Message-ID: <1232369940.6481.136.camel@tubuntu>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
	<45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
	<aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
	<45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Tomi.Valkeinen@nokia.com>) id 1LOtwx-00043H-UJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 13:13:55 +0000
Received: from smtp.nokia.com ([192.100.122.230] helo=mgw-mx03.nokia.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LOtwt-0006l8-82
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 13:13:55 +0000
In-Reply-To: <45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ext Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, 2009-01-17 at 06:14 +0800, ext Jaya Kumar wrote:
> On Fri, Jan 16, 2009 at 7:08 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > Any examples of non deferred io use cases? =)
> 
> Yes, I'm glad you asked. The first one that came to mind is the NO-MMU
> case. As you know, defio is MMU only today and I have no hopes of
> removing that. I had damage in mind especially for these NO-MMU cases
> (btw, if any vendor of such devices/cpus/boards is reading, please
> drop me a mail, i would like to help support this ).
> 
> Okay, so the above was the easy answer. There are also others I have
> in mind but it is debatable whether they should use damage API or
> whether they should use deferred IO. I would like to discuss the range
> of scenarios here:
> 
> a) Tomi raised omapfb at the start of this thread. He or she mentioned:

He =).

> OMAPFB_UPDATE_WINDOW
> I looked thru the code and saw:
> 
> +static int omapfb_update_window(struct fb_info *fbi,
> +               u32 x, u32 y, u32 w, u32 h)
> 
> [ btw, interesting to see use of u32 above, why not just u16? ]
> 
> I noticed dsi_update_screen_dispc. After reading this code, I formed
> the following conclusion:
> - this is to support the use of externally buffered displays. that is,
> there is an external sdram being handled by a separate controller,
> probably a MIPI-DSI controller
> - basically omapfb wants to know exactly what and when stuff is
> written from userspace because it has to push that manually through
> the MIPI-DSI interface
> 
> That driver currently uses a private ioctl to achieve that through the
> transfer of a single rectangle from userspace. It could, I believe,
> achieve the same effect using deferred IO since it has an MMU but lets
> leave that to one side for now. This kind of driver would be able to
> use the damage API with little change. They would add a GETDAMAGE
> handler that reports back their max rectangles (1) and then a
> PUTDAMAGE handler that does what they already do today.

You are obviously reading the new, not yet merged, display subsystem
code that I've been writing. Your analysis is correct.

Both MIPI DSI (in command mode) and MIPI DBI (or RFBI) are "manual
update" displays, so, as you said, there's an external framebuffer with
its own RAM which refreshes the LCD independently, and OMAP pushes the
pixels to the ext FB only when needed.

There's one more ioctl related to this, OMAPFB_SYNC_GFX. This ioctl will
wait until the ongoing update has been done.

The DSI implementation does not queue the updates in any way: if there
is an update ongoing when a new update ioctl is issued, omapfb will
return EBUSY. The old implementation for DBI in the current linux-omap
does queue the updates up to n (~5?) updates, but I didn't want to
implement queuing without knowing that it is really needed. I still
don't know =).

And an extra complexity comes from so called Tearing Elimination, in
which the ext FB informs OMAP when the LCD is drawing particular line,
usually the first or last line on screen. OMAP can then synchronize the
start of an update for this TE signal to prevent visible tearing on
screen. And having TE enabled and queuing the updates it could take
multiple frames until the update is on the screen. Probably not
intended.

We don't use deferred io, that is also something I should take time to
study at some point. And generally, I'm quite at loss which would be the
most efficient way of handling the updates. I guess I should just
implement all the possible options and do benchmarking.

Btw, how does the X damage extension work? I suppose you need some extra
code in X for it to be able to report the changes to the actual driver
below? And in this extra code you can choose how to report the damages
to the driver, either giving them one by one or combining them to a
larger area?

> Thanks, u2,
> jaya

 Tomi



------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
