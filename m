From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 14:09:18 +1100
Message-ID: <1110942559.24296.107.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston>	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>	<1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi>  <4236C770.8020101@hispeed.ch>
	<1110907029.4001.624.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110907029.4001.624.camel@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org


> It's ugly, but that's not the point. The point is that all deployed
> versions of X (and even current X.org CVS head still, in fact) make this
> assumption.

Oh, that's fine and that's not a problem. I will only repaint the
framebuffer on bit depth or line lenght changes. I'm trying to talk
about the _future_ here. That is support for dual head at the fbdev
level and other niceties.

We simply cannot guarantee preserving the video memory accross mode
switches. We have enumerated enough examples of that, and Ville himself
came up with a nice one about Matrox.

What we _can_ do is let people know what was expelled from video memory
eventually. But even the "let's ask fdbev what will change" before the
actual mode switch isn't really a good idea in the long run since it
sort-of defeats the purpose of having a common memory manager.

Ben.
