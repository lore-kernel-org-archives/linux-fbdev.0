From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: waitforVBlank, how does this even work?
Date: Thu, 3 Mar 2005 09:55:59 +0200
Message-ID: <20050303075559.GA7469@sci.fi>
References: <9e473391050301215019081bce@mail.gmail.com> <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com> <1109806955.5610.129.camel@gaston> <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com> <1109816602.5610.153.camel@gaston> <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, Mar 02, 2005 at 10:01:00PM -0500, Vladimir Dergachev wrote:
>=20
>=20
> On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:
>=20
> >On Wed, 2005-03-02 at 20:03 -0500, Vladimir Dergachev wrote:
> >>
> >>On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:
> >>
> >>>
> >>>>
> >>>>    What about isolating interrupt-handling code into a small drive=
r ?
> >>>>Something simple to respond to interrupts and call all handlers wit=
h a
> >>>>certain mask.
> >>>>
> >>>>    This would be useful not only for drm and fbdev but also for km
> >>>>(v4l capture module) and stereo-glasses code.
> >>>>
> >>>
> >>>Nope, I don't agree.
> >>
> >>With which part ? ;)
> >
> >On having a small stub module that does just IRQs ... I think the base
> >module should be the fbdev (mode setting etc...)
>=20
> Oh, but I was not suggesting that. I just meant that interrupt handling=
=20
> code is self-contained and can easily serve several consumers.

I'm with you here. And the same should IMHO hold for DMA handling. And fo=
r=20
memory management of course.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
