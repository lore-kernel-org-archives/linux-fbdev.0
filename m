From: Jan Gukelberger <g.u.g.i@gmx.de>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 18:25:00 +0100
Message-ID: <1110907500.3366.27.camel@elessar.home>
References: <1110696189.5787.100.camel@gaston>
	 <1110784327.5787.288.camel@gaston> <1110817205.4004.527.camel@localhost>
	 <1110837171.5863.16.camel@gaston> <1110838356.4003.548.camel@localhost>
	 <1110839873.5673.41.camel@gaston> <1110862777.4044.592.camel@localhost>
	 <20050315060138.GA13064@sci.fi> <1110869983.29138.88.camel@gaston>
	 <20050315140005.GB16051@sci.fi> <9e47339105031506292b1976b0@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031506292b1976b0@mail.gmail.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Tue, 2005-03-15 at 09:29 -0500, Jon Smirl wrote:
> Aonther approach would be to just say you have to choose to run one of
> X, DirectFB, FBUI, XGL and you can't switch between them. Other than
> developers I don't know if anyone really runs more than one of these
> at a time.

FWIW, yes we do. 

We're developing a system for neuro-scientific experiments where we
enjoy having a fast and lightweight graphics stack with access to VSYNC
interrupt (DirectFBGL) for reliable frame timing of visual stimuli.
OTOH the experimenter gets a QT control GUI running on a second graphics
card with regular X.

As this is not very common and quite a hassle to setup (e.g. X stomping
on other card's IRQ and the like) I'm eagerly following all efforts to
build a common standard graphics base with improved multi-head and GL
support.

That said, I realise that this is not a very widespread use-case. But
nonetheless there are such applications.

Thanks,
Jan



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
