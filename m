From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 14 May 2004 21:08:14 +0300
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040514180814.GA18297@sci.fi>
References: <20040514172011.GA11990@pegasos> <20040514175135.41336.qmail@web14921.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040514175135.41336.qmail@web14921.mail.yahoo.com>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="iso-8859-1"
To: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 14, 2004 at 10:51:35AM -0700, Jon Smirl wrote:
> Just look at this picture and you can see the trend of 2D vs 3D (coproc=
essor
> based) graphics.
> http://www.de.tomshardware.com/graphic/20040504/images/architecture.gif
> Within one or two generations the 2D box is going to be gone.
>=20
> If Linux wants to stay current with technology we have to start using t=
he
> coprocessor features of the GPU. Most of the benchmarks I have seen sho=
w
> coprocessor vs programmed at 100:1 speed differential. This is also a
> competitive problem, Microsoft and Apple have both decided to go with t=
he GPU
> coprocessor this year.=20

I don't understand you GPU vs. PIO comparisons. You can use the 2D engine=
=20
with DMA as well. And at least with older cards the 2D engine is clearly=20
faster than the 3D engine (~100% faster for blits on my G400) so trying t=
o=20
bypass it is just stupid.

> I said OpenGL is the only accelerated API available on Linux. Can you n=
ame
> another?

DirectFB.

> There is a little acceleration in framebuffer, but I don't know of any
> others. Also, software mesa works just fine to provide OpenGL on dumb 2=
D cards.

Using unaccelerated OpenGL for 2D rendering doesn't sound exatly useful.=20

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
