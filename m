From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] Fix switch from XFree
Date: Tue, 10 Feb 2004 12:28:20 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040210112820.GA2273@lambda>
References: <1076409397.873.6.camel@gaston> <20040210110622.GA1913@lambda> <1076411840.874.18.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqW3y-0007Lm-F5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:28:22 -0800
Received: from smtp2.wanadoo.fr ([193.252.22.29] helo=mwinf0202.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqW43-0008G2-DV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:28:27 -0800
Content-Disposition: inline
In-Reply-To: <1076411840.874.18.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Feb 10, 2004 at 10:17:21PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Mmm, i wonder about this. The X driver is supposed to be responsible for
> > saving and reseting the engine when leaving/entering. This is usually
> > done in a separate way when using or not using fbdev.
> 
> This is a nice dream. It's both _very_ impractical (you can't always
> _read_ the engine state) and usually buggy as hell (and go fix XFree :)

Well, i have no problem in fixing XFree86. But then, one would have to
consider the alternate or outdated servers too, altough i doubt you care
about XiG or other such comercial servers which provide x86 only.

> On the other hand, it's very simple for the driver to just reset &
> restore the engine state it expects.

Or to use a different pipe, if the hardware provides accelerated context
switching :)).

> > Now, if we are going to save/restore the contect too, then this would
> > mean a risk of dual saving the engine state. Or maybe the X server
> > doesn't really save the context, but just reinitialize it when entering.
> 
> It tries too for the mode... but fails. It doesn't try for the engine

Ok.

> > I have the feeling that more working together would be helpfull, or
> > maybe setup a proper policy for X/fbdev to handle this properly.
> 
> I don't think it's reasonable to expect the XFree driver to save/restore
> the accel engine state. It's already quite broken with the mode on
> radeonfb (the VGA stuff seem to do bad things on PPC at least).

Ok, but for the mode, if you use UseFBdev, then the server will not
touch the mode, and rather use the underlying fbdev infrastructure for
it. Why not do something similar for 2D, and tell X that this version of
the fbdev does indeed know how to fix the accel engine, and doesn't care
about getting it in broken state.

> > Maybe the fbdev driver could set a flag or something, which would tell
> > the X server that it is taking charge of saving/restoring the accel
> > engine, so the X driver would not try doing this too, at least in the
> > UseFBDev case (but do we care about the other case ?).
> 
> No. Trying to save/restore the engine state would mean trying to
> save/restore dozens (or hundreds maybe ? depends if you count the 3D
> engine too :), it makes little sense, it's much simpler for fbdev
> to just reset the state it expects.

Ok, i understand, but again, maybe if the fbdev doesn't care, there is
no need for X trying to save/restore it ? Or whatever it tries to do.

I think we could decide on a sane policy for both fbdev and X to follow
(for example, each one is in charge of resetting their mode/accel engine
state), and then submit this policy to the XFree86 people to adhere too
if the UseFBDev option is used. If XFree86 drivers do not implement it,
then they are broken, and its their problem, but if they do, then we
result in having the most economical context swithc possible.

Friendly,

Sven Luther


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
