From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 05 Mar 2003 20:46:52 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046868330.1229.59.camel@localhost.localdomain>
References: <1046852721.1228.13.camel@localhost.localdomain> 
	<20030305110529.GA2036@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qYHB-0001PI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 04:45:39 -0800
In-Reply-To: <20030305110529.GA2036@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 19:05, Sven Luther wrote:
> On Wed, Mar 05, 2003 at 04:26:04PM +0800, Antonino Daplas wrote:
> > 
> > Hi,
> > 
> > I believe it's time to finalize what is needed/not needed for the
> > framebuffer framework:
> > 
> > 1. Text mode support?
> 
> Would this work also on arches which don't traditionnaly do text mode ?
> Like ppc for example. 

Yes, pixel-based drawing is still the default.  It's only for drivers
(matrox and sbus) where it might be needed.

> 
> > 2. console resizing using fbset (besides stty)?
> 
> What about dynamic multi-head support ?
> 
> > 7. Anything else?
> 
> Well, what is the exact status of mult-head and multi-seat ? It is

If you mean one card with multiple heads, that will need driver-specific
support. 
 
> supposed to work, but i did not (yet) experience it myself, mainly
> because non of my graphic cards are yet supported. One point i would
> like to see addressed is the ability to share one framebuffer and have
> both heads be separate viewports into this same framebuffer. This
> means setting a framebuffer with a stride equal to the sum of both's
> head resolution and having each head display a subset of it. This would
> also include having one head be a mirror of the other and other such
> things. This feature and resizing may cause problems though.
> 

Because of the massive rewrite, there wasn't really enough time to add
major feature sets to the framework.  Most of the effort was spent on
bug fixing, cleaning up, and speeding up the code (to justify the
rewrite). 

It does have one benefit though, the newer code should make it easier to
add an infrastructure on top of fbdev, such as xinerama-style support. 
But this will be in the future.

> > 8. feature freeze deadline?
> 
> This would be for fbdev deature freeze, right, not for the drivers ?
> 

Yes, to give people time to port their drivers.

> BTW, i will no more be able to work on pm3fb, since i just recently
> noticed that my nice AGP8 supporting motherboard doesn't accept my
> Appian Jeronimo 2000 board. :(((
> 

That's too bad :-(

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
