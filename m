From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Thu, 17 Mar 2005 11:06:30 +1100
Message-ID: <1111017990.7192.78.camel@gaston>
References: <1110784327.5787.288.camel@gaston>
	<1110839873.5673.41.camel@gaston> <1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi> <4236C770.8020101@hispeed.ch>
	<1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston>
	<20050316200808.GB6651@sci.fi> <1111005770.5535.63.camel@localhost>
	<1111015617.15509.56.camel@gaston>
	<9e47339105031615355bb3986f@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031615355bb3986f@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org


> Why don't we modify the new radoenfb driver to have a real
> arbitration/management layer. Directfb can continue to use the old
> driver. The rule is that you can't mix old and new style fbdev drivers
> in a system. Over time DirectFb and X can be fixed to use the new
> model.
> 
> There is going to have to be a transition path while we debug the
> arbitration/management layer and figure out the right API for it.
> Supporting multiple disparate users of the graphics hardware is a
> quite complex feature that no other operating system implements.

I prefer letting the heat cool down for now. I'll implement the actual
mode setting etc... with a very basic memory management, and we'll move
from there once I have the code.

Ben.
