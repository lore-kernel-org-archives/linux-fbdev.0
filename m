From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 28 Aug 2014 10:11:41 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140828101140.GB14388@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jq0ap7NbKX2Kqbes"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
 <20140827154221.GX15297@lukather>
In-Reply-To: <20140827154221.GX15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 05:42:21PM +0200, Maxime Ripard wrote:
> On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
> > On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> > > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> > > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> > > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> > [...]
> > > > > > > Mike Turquette repeatedly said that he was against such a DT =
property:
> > > > > > > https://lkml.org/lkml/2014/5/12/693
> > > > > >=20
> > > > > > Mike says in that email that he's opposing the addition of a pr=
operty
> > > > > > for clocks that is the equivalent of regulator-always-on. That'=
s not
> > > > > > what this is about. If at all it'd be a property to mark a cloc=
k that
> > > > > > should not be disabled by default because it's essential.
> > > > >=20
> > > > > It's just semantic. How is "a clock that should not be disabled by
> > > > > default because it's essential" not a clock that stays always on?
> > > >=20
> > > > Because a clock that should not be disabled by default can be turne=
d off
> > > > when appropriate. A clock that is always on can't be turned off.
> > >=20
> > > If a clock is essential, then it should never be disabled. Or we don't
> > > share the same meaning of essential.
> >=20
> > Essential for the particular use-case.
>=20
> So, how would the clock driver would know about which use case we're
> in? How would it know about which display engine is currently running?
> How would it know about which video output is being set?
>=20
> Currently, we have two separate display engines, which can each output
> either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
> one of these combinations would require different clocks. What clocks
> will we put in the driver? All of them?

Ideally the solution wouldn't involve hard-coding this into the clock
driver at all. There should be a way for firmware to communicate to the
kernel that a given clock shouldn't be disabled. Then since firmware
already knows what it set up it can tell the kernel to not touch those.

Thierry

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/wBcAAoJEN0jrNd/PrOhdEMQAJmSojRsTWD83SX+kjWE9AV2
uuerbfen/NeDJ9yuSi7/BC1M9qTOnfjJIsNY6FStZB+9tV9TY5vhbrTUWwOJ5xGM
vec6/5IvehNijMVWss6xiSLeui4xWtEcJzHHrY4GEhDt6qARxXDtZ6EN2EAoQaKP
3DJx/gK8s+0WJ84tMfS8agxyrhbTwmGp1wcsXcmLonQXZxiCtiL7NkRHldBORj8t
fiPcr8RNJqiRxUbBM+LQZYBMF0vyiKnN87NVxOanoO4TrlK8hpb40MoK8VB+nit9
sMYL8VHsuDTHjkyhh1NPZNSK239eLSGfxGPag2F7gM9+YOTX3/9p33Di14kML/zL
D1MRrYqgQwGueKAG50oxAqp7FeBNnpNQZJ2LruBdAMXZ4NeiCViAMlAvVaV5Pl6M
d0pVClXmvg/ZDBT0bgkxk0XgkmYqiTRGX800SEeEQJ4+R9FBC7I4/BvLjQqGX8so
IkcntO/emdm0oJFP4ympmsPIl/laTva/1tHsvxY//+nEX4YQPVRmIM1fOozrUO4E
ei0U1v1xIuFwbsW+1NM/3u3bFUGDwM8DUBM097DIoTsjuIjp5pYQz+yaCNxZ/nAw
aoSK/8MZOvBHg7GuQQRpj5Wqcu3Snt9XY+vea0tPoy5vv/dCjGc1cA9KJtS1KCD1
RRFGKfqHMYBIAKFl2DE1
=Hemx
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
