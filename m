From: Egbert Eich <eich@pdx.freedesktop.org>
Subject: Re: [Dri-devel] Redesign of kernel graphics interface
Date: Mon, 10 May 2004 14:07:48 +0200
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <16543.28820.68493.459151@xf11.fra.suse.de>
References: <20040506181639.61975.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: jonsmirl@yahoo.com wrote on Thursday, 6 May 2004 at 11:16:39 -0700 
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl writes:
 > At the X Developers Conference there was a discussion of the issues around
 > framebuffer and DRI. Theodore Ts'o suggested that I write it up and post it for
 > discussion. I'm going to try and list all of the issues I've heard from all
 > sides so some of the proposed solutions are in conflict. The goal of this list
 > is to provide direction for a topic discussion at the Ottawa Kernel Summit.
 > 
 > The top item is that accessing the video hardware is a free for all. There are
 > two device drivers, FB and DRI, plus numerous user space apps, like X and
 > SVGlib, all trying to control the hardware. The result of this is that it is
 > easy to lock up your machine when switching between the different usages. X does
 > particularly nasty things to the hardware from user space without informing the
 > kernel.

Here it should be looked at why this is the case.

 > 
 > First is a little background that should have been in my original post:
 > http://thunker.thunk.org/pipermail/ksummit-2004-discuss/2004-May/000399.html
 > 
 > Next is the orginal post:
 > http://thunker.thunk.org/pipermail/ksummit-2004-discuss/2004-May/000379.html
 > 
 > The reply thread on the kernel summit list is here:
 > http://thunker.thunk.org/pipermail/ksummit-2004-discuss/2004-May/thread.html
 > 
 > Some talk about doing a better video memory manager and kgi is here:
 > http://marc.theaimsgroup.com/?l=dri-devel&r=1&b=200405&w=2
 > 
 > A major topic that I missed in the original list was how to handle BSD. DRM is
 > under the BSD license and FB is GPL. If these two code bases are merged, what
 > are we going to do about BSD? I don't know the appropriate BSD lists to post
 > this to so please forward as necessary.

The problem is bigger than that. There are other OSes that take advantage of
the mode initialization code in X. Those people don't have their own mailing
lists but exchange informations on those of the X projects. Most of them
should be active on the XFree86 lists.

 > 
 > Another topic that I missed was, why did kgi fail and what can we do to avoid
 > repeating the same path this time around.
 > 
 > After the flames from this settle down I'll try to write a document summarizing
 > the conclusions reached, if any. The best possible outcome would be a design
 > document for review at Kernel Summit.
 > 

There are many considerations from the XFree86/X.Org Xserver side that people
here may only be marginally aware of. After all, these people were those who
were involved with some of the issues the most in the past.
It would be useful to give those people a chance to state their views, too.

Egbert.





-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
