From: Egbert Eich <eich@suse.de>
Subject: Re: Who is stomping PCI config space?
Date: Fri, 4 Mar 2005 13:02:34 +0100
Message-ID: <16936.20058.49842.231100@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: jonsmirl@gmail.com wrote on Thursday,
	3 March 2005 at 22:03:43 -0500 
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
Cc: Xserver development <xorg@freedesktop.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Egbert Eich <eich@pdx.freedesktop.org>


Jon,

you know well that we are not living in the same time zone, so you
may want to give me some time to answer.

Jon Smirl writes:
 > Hopefully someone who knows what is going on with VT switching and how
 > hardware gets enabled will respond and we can get this fixed in the
 > server.  I see Zoltan's patch but we shouldn't have to tell X to leave
 > hardware alone that doesn't belong to it. X just has no business
 > messing with cards it does not own.

Err. We can reenable the card if no other card is interested in this
kind of legacy resource (we distinguish between mem and io resources
as we can disable them separately). And as far as I remember X does
this already when it is not in setup mode.
However if your X driver says it needs these resources - during 
'normal' operation, not setup - then there is no way around turning
of other cards.

 > 
 > Meanwhile I am forced to write to PCI config space and reenable IO
 > access from inside my interrupt handler. Yuck, yuck, yuck!!!

Even with a central resource manager (regardless if you have it inside
the kernel or not) your interrupt code would have to do this - as 
you don't know if the code you are coming from needed to access these 
these ports on another card.

Egbert.
