From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 13:32:15 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310271316580.1636-100000@home.osdl.org>
References: <3F9D741C.9010501@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F9D741C.9010501@us.ibm.com>
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
To: Ian Romanick <idr@us.ibm.com>
Cc: David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


On Mon, 27 Oct 2003, Ian Romanick wrote:
> 
> I'm also baffled by the general animosty shown towards Linux.

I don't think it is animosity vs Linux per se, but I do think that XFree86 
tends to have a very strong bias against infrastructure change. 

Which is somewhat understandable: I'm a kernel person, so infrastructure 
change is what I'm all about, but most other projects really hate having 
any kind of rug pulled out from under them. 

And kernel modules are _nasty_. From past experience, I can just say that
external kernel modules (ones not integrated into the standard kernel
tree) just generate a lot of pain on all sides. Users, project developers, 
and kernel developers universally _hate_ having to try to keep external 
modules working and debugging the problems that inevitably happen when 
they don't work.

So animosity toward them is certainly understandable - they just don't
work very well, and are a total maintenance nightmare.

This is the reason why I decided I had to follow the DRI CVS tree: just to
try to make the DRI kernel modules basically irrelevant to most people. My
theory is that peopel are more likely to happily upgrade the whole kernel
than to try to fight the version skew that inevitable happens with
external kernel modules.

This is, btw, also the reason why I have been an asshole about backwards
compatibility wrt the DRI project, and was less-than-perfectly-polite to
some people when DRI upgrades caused older setups to fail. That's simply
because my belief is that version skew is simply unacceptable, which means
that the only _acceptable_ situation is to try to make it ok to always
have the most recent kernel.

So otherwise we'd have to go back to the "use external modules" thing,
which I just don't believe works.

This is also the reason I believe that the only really workable way to
handle this is to have a very version-neutral (and thus _stupid_)  
minimal driver for handling the low-level needs of all the projects
involved (DRI/XFree86/fbcon). Exactly to avoid the possibility of version
skew.

In other words, I'd keep it so simple that versions don't really matter,
because the low-level driver doesn't do enough complex things that you'd
be forced to upgrade it all the time. I don't think fbdev is at all the 
proper interface - I think the proper interface is something that is so 
close to the hardware that the hardware _forces_ all issues, and there are 
never any questions of what the low-level driver should be.

And since people still want to run X on old setups too, clearly X will 
have to have the ability to have its own user-space module. That's needed 
for other operating systems _anyway_, so this wouldn't obviate that. 

			Linus



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
