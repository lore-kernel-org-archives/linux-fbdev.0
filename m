From: Otto Wyss <otto.wyss@bluewin.ch>
Subject: Re: [wx-dev] Linux GUI considerations
Date: Wed, 05 Feb 2003 20:44:00 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E416980.2B2F85@bluewin.ch>
References: <3E403C75.2DBCC9F8@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from isp247n.hispeed.ch ([62.2.95.247] helo=smtp.hispeed.ch)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gVSp-0007or-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 11:44:08 -0800
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
To: wx-dev@lists.wxwindows.org, linux-fbdev-devel@lists.sourceforge.net

> From: Julian Smart
> I would certainly be keen to encourage better uptake of Linux through
> use of wxWindows, but I have to take issue with the argument that
> a framebuffer-based approach is going to help this. XFree86 has had years
> of development and tweaking. Are you really saying that we could
> write a better X11 replacement? Even if we did and managed to write
> a 3rd super-duper desktop environment with all the required little apps,
> we'd face a huge struggle in persuading people to use our particular
> environment instead of X11.
> 
XFree86 has done a tremendous amount of effort. Still large part of this
is simply spent in the wrong places. Instead of keeping writing directly
to the hardware they should concentrate in building kernel drivers,
maybe separate maybe together with the framebuffer people. Currently it
looks close to that they fear anybody may come up with a better X
solution if the hardware part is made generally available. A second
part, the network part, is in a desktop environment or a PDA simply not
necessary but it's not possible to get rid of it. And can you explain
why VNC created their own protocol?

> >I fully agree with James Simmons when he complains about "Linux will
> >NEVER move into the desktop market!" (See
> 
> Chicken/egg...
> 
Yes but if nobody starts to build eggs out of "nothing" you'll never get chickens.

> I may be missing your line of reasoning here, but I think the main
> reason for lack of Linux uptake in the home is the lack of software,
> in particular games (pity Loki didn't succeed). So rather than
> invest in an entirely new GUI solution, perhaps the effort would
> be better spent on porting or writing games and other software...
> as well as trying to persuade more companies to release on
> Linux (by telling them how easy wxWindows is to develop with!)
> 
There will be never any successful Linux gaming business as long as
graphic cards manufactures don't provide their own written Linux
drivers. Again a chicken/egg situation.

> From: Robert Roebling 
> > why isn't there already a framebuffer port
> > in wxWindows?
>
This was more a rhetorical question for the framebuffer people.

> From: Vadim Zeitlin
> RR> > why isn't there already a framebuffer port
> RR> > in wxWindows?
> 
>  FB port could be useful for the devices such as PDA and, especially
> considering that it shouldn't be that difficult to create a wxFB port, I
> hope that this is going to happen if any interesting FB-based systems
> appear. For now I don't know of any however.
> 
IMO an FB port isn't even for PDA's a real alternative, since in a few
years PDA's will have the same power as desktop systems and requests
similar GUIs.

> RR> The Linux desktop will be based on X11 or it
> RR> will not happen at all.
> 
>  And I'd really like to sign under this. I really don't understand why so
> many people hate X so much. IMHO it's a very decent system. As for the
> Linux desktop, it is alive and well alive. Whatever you may think of KDE (I
> don't think much as I never used it myself anyhow) it's an amazingly
> successful project.
> 
Just look at the decision of the "Deutsche Bundestag" about using Linux
on the desktop (with KDE and OpenOffice). 

> From: Julian Smart
> Interesting. Here's another relevant story from today -- a Desktop Linux
> Consortium:
> 
> http://www.internetnews.com/ent-news/article.php/1579921
> 
Really interesting, especially the sencence about "end-users" shows that
I'm on the right track. 


What alternatives are there?

- sticking with X11: While this is currently the only working solution,
Linux won't get a widespread acceptance. It will silently evolve in its
niche but won't break out of it.

- trying a framebuffer port: This won't be successful as long as the
single application approach is overcome (also for PDA).

- trying a DirectFB port: This might be an alternative but my knowledge
is too small to say more. Someone with more insight should have a look.

- using QT: This might help Linux but it's no alternative for wxWindows.

- changing X11: I have absolute no wish to get into a flame ware with
the XFree86 people.

- reactivating Dinx: From the echo in the kernel mailing list this isn't
an option. Maybe it could be integrated into the framebuffer but this is
up to them.

- building a new API: As Julian said this is probably out of question.
Much too much work and persuasion has to be done. 

- re implementing a current API: IMO the only possible way is to take
the Xlib API, leave away any unnecessary functionality and re implement
it based on the framebuffer.

- others: Suggestions?

If you question if this is altogether possible, look at MacOS X. Why can
Apple build a GUI on top of FreeBSD without requiring a single line of
configuration from the user? Why can't this be done with Linux? Besides
why has MacOS a GUI right from the start but Linux hasn't? Besides MacOS
is famous for building a GUI where an ordinary user feels comfortable
with. IMO this should be equally possible for Linux and wxWindows and
not even that difficult. I'm not saying it isn't much work but it's
doable. 

O. Wyss


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
