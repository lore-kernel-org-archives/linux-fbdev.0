From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 31 Jul 2012 12:38:11 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731123811.GA25855@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <5017CDF9.2060304@firmworks.com>
In-Reply-To: <5017CDF9.2060304-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
To: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 08:22:17PM +0800, Mitch Bradley wrote:
> On 7/31/2012 6:56 PM, Thierry Reding wrote:
> > On Tue, Jul 31, 2012 at 07:32:20PM +0900, Alex Courbot wrote:
> >> On 07/31/2012 07:45 AM, Stephen Warren wrote:
> >>> I wonder if using the same structure/array as input and output would
> >>> simplify the API; the platform data would fill in the fields mentioned
> >>> above, and power_seq_build() would parse those, then set other fields=
 in
> >>> the same structs to the looked-up handle values?
> >>
> >> The thing is that I am not sure what happens to the platform data
> >> once probe() is done. Isn't it customary to mark it with __devinit
> >> and have it freed after probing is successful?
> >=20
> > No, platform data should stay around forever. Otherwise, consider what
> > would happen if your driver is built as a module and you unload and load
> > it again.
> >=20
> >> More generally, I think it is a good practice to have data
> >> structures tailored right for what they need to do - code with
> >> members that are meaningful only at given points of an instance's
> >> life tends to be more confusing.
> >=20
> > I agree. Furthermore the driver unload/reload would be another reason
> > not to reuse platform data as the output of the build() function.
> >=20
> > But maybe what Stephen meant was more like filling a structure with data
> > taken from the platform data and pass that to a resolve() function which
> > would fill in the missing pieces like pointers to actual resources. I
> > imagine a managed interface would become a little trickier to do using
> > such an approach.
> >=20
> >>> If the nodes have a unit address (i.e. end in "@n"), which they will
> >>> have to if all named "step" and there's more than one of them, then t=
hey
> >>> will need a matching reg property. Equally, the parent node will need
> >>> #address-cells and #size-cells too. So, the last couple lines would b=
e:
> >>>
> >>> 		power-on-sequence {
> >>> 			#address-cells =3D <1>;
> >>> 			#size-cells =3D <0>;
> >>> 			step@0 {
> >>> 				reg =3D <0>;
> >>
> >> That's precisely what I would like to avoid - I don't need the steps
> >> to be numbered and I certainly have no use for a reg property. Isn't
> >> there a way to make it simpler?
> >=20
> > It's not technically valid to not have the reg property. Or
> > #address-cells and #size-cells properties for that matter.
>=20
> I'm not keen on this representation where individual steps are nodes.
> That seems like it could end up being too "heavyweight" for a long sequen=
ce.

The other alternative would involve using a single property to encode
one sequence. I think that was the initial proposal, though using proper
phandle encoding it could probably be enhanced a bit. However anything
that involves a single property has the problem that we need to encode
the type of resource as an integer, and that makes things very hard to
read.

So it would look something like this:

	power-on =3D <1  &gpio 6 0            1
		    0                   10000
		    2  &reg                 1
		    3  &pwm  0 5000000      1>;

	power-off =3D <3  &pwm  0 5000000      0
		     2  &reg                 0
		     0                   10000
		     1  &gpio 6 0            0>;

So the first cell would encode the type:
  0: delay
  1: gpio
  2: regulator
  3: PWM

The next n cells would be the phandle and the specifier, while the last
cell would encode a resource-specific parameter:
  delay: time in microseconds
  gpio: set level (0: low, 1: high)
  regulator: 0: disable, 1: enable
  pwm: 0: disable, 1: enable

I guess this would be more compact, but it is also very hard to read. Is
that something you would be happier with? Perhaps you were thinking of
something completely different?

Thierry

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQF9GzAAoJEN0jrNd/PrOh124P/iTHY6PDKSAJpAwz72SKyqeU
/UA9uu8Dz3rVW5NaruM4xEcZtVsKAkgOfj9w2Bvc28eUX4Xns8KIkkYvXbU/Zt2L
ESAUq1huI4fNWTYSaEX7+G4iYiEc7BrIhBCHh0Zo/rlVVuhk9FAC9ZfJm1iH+JMR
5ferj3cIz4BbxvozChPix95YvehoBxHZ/05IZGZSXLIYcFB1lkBs/HEvo2F/Bapk
by8dUy94xjSECCMXcbBOmDEJex313Z24r1Wo26fTVpkYQy2t/SahvFfU5179ueiT
kOFnYw++yfwvttM9PwxUt2YfLSO3XpXi/1ZKZpmRYeEdBrJajN9EwnmAQ8nhb2io
jq9r9jWvGjcZoyRSRYECVsWIXyuvtuf8aFpP/+zJKIrjC4MstudVbc+q/W5utLry
xX03Jyup78baKegOkRzED1IxIbAW4ZZce7oymsQAOOpev5Sw4VrlS6CbfcZXWJwT
CUcKz480lm3YEhRRu79eW4sn5Gge5CFcd+wH5W1hL7HqAoSpAvN/a8ZHIz84iqOW
KtVYqQnO5vGAmAx2+legyizYEVC8djVSQlfU7VKzCOM+rWq5f224WKkKrysrR1dw
je4l9lmOsYygY0ywxUcUkmT/DVPqr26UaUtKt8EhKW7o0Sd2h1t6jwCZaR5Id0QW
re1hYOr/x66yPMN3dzAH
=tkdt
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
