From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 31 Jul 2012 10:56:40 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d9ADC0YsG2v16Js0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
In-Reply-To: <5017B434.2010706-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 07:32:20PM +0900, Alex Courbot wrote:
> On 07/31/2012 07:45 AM, Stephen Warren wrote:
> >I wonder if using the same structure/array as input and output would
> >simplify the API; the platform data would fill in the fields mentioned
> >above, and power_seq_build() would parse those, then set other fields in
> >the same structs to the looked-up handle values?
>=20
> The thing is that I am not sure what happens to the platform data
> once probe() is done. Isn't it customary to mark it with __devinit
> and have it freed after probing is successful?

No, platform data should stay around forever. Otherwise, consider what
would happen if your driver is built as a module and you unload and load
it again.

> More generally, I think it is a good practice to have data
> structures tailored right for what they need to do - code with
> members that are meaningful only at given points of an instance's
> life tends to be more confusing.

I agree. Furthermore the driver unload/reload would be another reason
not to reuse platform data as the output of the build() function.

But maybe what Stephen meant was more like filling a structure with data
taken from the platform data and pass that to a resolve() function which
would fill in the missing pieces like pointers to actual resources. I
imagine a managed interface would become a little trickier to do using
such an approach.

> >If the nodes have a unit address (i.e. end in "@n"), which they will
> >have to if all named "step" and there's more than one of them, then they
> >will need a matching reg property. Equally, the parent node will need
> >#address-cells and #size-cells too. So, the last couple lines would be:
> >
> >		power-on-sequence {
> >			#address-cells =3D <1>;
> >			#size-cells =3D <0>;
> >			step@0 {
> >				reg =3D <0>;
>=20
> That's precisely what I would like to avoid - I don't need the steps
> to be numbered and I certainly have no use for a reg property. Isn't
> there a way to make it simpler?

It's not technically valid to not have the reg property. Or
#address-cells and #size-cells properties for that matter.

Thierry

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQF7noAAoJEN0jrNd/PrOhQrIP/1aKVnCe0ismm9KHjsPrV5YR
LEki71luehGkF0xbg6thde0y/r+Zi3QcA4oXRpvEznazgT+qqZBgK9LojCv36Q4+
aTgI+VVi+H+WcbRZg3hS+jqP1r17EjQ9WP6S+FuWqYgSfPWao6K8NM/FuuEtC5az
CHoZc0WabwI13D+zNlhjA7N1gx6vsYdMSf33Gf6aS+MUnuHuIduQWxC8AuCUvTT9
72bYhDyRGG73a5ooIHqVxCj3MRnGQAu8FYVaSDVlhmT6nzgd6Gh0ms6n9qRC/2wH
k96OenFkDgkVpFgPqg22sKR+0fJOniCNxrKhMQ8Tr9Hzb0T4OfFFtHI/FXL6z1gG
fVwdVkkd9ViG580/21xA+i0TLSFtqNuNHUclaKNMwBJAC9VFs+JwaeHQ48fFe37n
+LNhyAFti+Lf6mc8h3/9/l455Ix7xnXYy8zPov5JwFCMyD4FFo0By4k7UGSmOEY/
WRs0ODwDv0Md6OvDipRFbKLw+L1coYmsgEnndLDrrQcbEWo854lUEClcNmDl8yk8
pmdXKc0pdGhDZF/hZDfp/e8NyGiH1VgmIupDF/JFJ6NTeWF/OprElSPJRwchEW8N
/MkE2me+ruLrzNWqmUYqdJWurM9PZW0OwDwvq8TZr4hsCMmYjLAd+ANUkBod0xU6
eQJZzZ4tJ6+KzprosuDC
=Y3Sh
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
