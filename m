From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 01 Aug 2012 07:17:43 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120801071743.GC29673@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E/DnYTRukya0zdZ1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <20120730113323.GA7303@avionic-0098.adnet.avionic-design.de>
 <5017AA87.2040503@nvidia.com>
 <20120731101931.GB16155@avionic-0098.adnet.avionic-design.de>
 <5018997B.7010808@nvidia.com>
In-Reply-To: <5018997B.7010808-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2012 at 11:50:35AM +0900, Alex Courbot wrote:
> On 07/31/2012 07:19 PM, Thierry Reding wrote:
> >* PGP Signed by an unknown key
> >
> >On Tue, Jul 31, 2012 at 06:51:03PM +0900, Alex Courbot wrote:
> >>I would like to do that actually. The issue is that it did not work
> >>go well with the legacy pwm_backlight behavior: a power sequence
> >>needs to be constructed out of a PWM obtained through
> >>pwm_request(int pwm_id, char *label) and this behavior cannot be
> >>emulated using the new platform data interface (which only works
> >>with pwm_get()). But if I remove this old behavior, then I could
> >>make power_seq opaque. I don't think many drivers are using it. What
> >>do you think?
> >
> >I don't see how that is relevant here, since this power-sequencing code
> >is supposed to be generic and not tied to any specific implementation.
> >Can you explain further?
> >
> >In any case you shouldn't be using pwm_request() in new code.
>=20
> Power sequences only rely on pwm_get, and never call pwm_request
> since it is, as you stated, deprecated. However there are still
> boards that use the old pwm_id member of the
> pwm_backlight_platform_data. For these, we must call pwm_request
> from the pwm_backlight driver in order to resolve the PWM (see
> pwm_backlight_legacy_probe of the seconds patch). As the PWM is
> being resolved by the backlight driver, and not within the power
> sequences parser, the resolved data structure must be visible to
> pwm_backlight so it can construct it. There are two ways to solve
> this and keep the power sequences structure private:
>=20
> 1) Add a way to resolve a PWM by id using pwm_request in the power
> sequences (we probably should not do that)

No. But I think we don't need that either. If you use power sequences,
then you shouldn't be using the pwm_id member. Both methods should be
exclusive.

> 2) Port the old platform pwm_request code to use pwm_add_table and
> pwm_get instead.

In the long term, every PWM user should move to pwm_add_table() and
pwm_get(), but there are quite a lot of boards that need conversion.

> Do I get points if I do 2)? :)

Yes. =3D) I have a sample patch for PXA EZX, but as I said, many more
boards need conversion.

Thierry

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGNgXAAoJEN0jrNd/PrOhjH8P/jwFMsjOzjdLlk6En+dhimdc
hEwsfudds/LWNomPtCaFV99BAe14Sa2iV8G23zdIoR2x5MkWJ7AQJkozrw+BRyzO
F9NoeA+MGsKmBtQAMic5t44JrD1F7ttxtY/hTdBrL+Vhnptp1f2h3Jb7eSeNuRFQ
eFHf+gMRS4agDExjEJv9pTLjmlQKnehFvUjpqcfr5XLmenYKCeY0urQO7ytuJd3F
EF54kEqPj8xS5JW3y5swJYgwJH2IJe+5Z1CkhF3QpgL8ZcPowF9MOVjUiq39GYlg
4ODENbljxqqtgxPKZt2aHQC6m9erw00WL/1GE4X/n5N8kqdaie+vKS+UvRYgTXEq
3A6yL+xXLcTO3CEkkCyRCKuIo2KnwK8mQm416ElshRUFY3G+inCak/PS5osFDItt
DYJFBvy3ZnqjC8N3nAHsq6tLoJSx7lKxhLSNaa+5wugG3w68gT/OMiLvu9WpA4Yr
v1eNrHe7Mwvn2ePpicW2zD/YtMhPv5X41b9UtYGrIHds7jzZ8tpY/uTZoxwIPojf
SF6Tv3ckw5WWnLKL8EBwtRvl60t91jXNIPbobsPJsHhS4ZcohSDdUoIReXeAeYmF
uRu04rX2YCqvb5Uwv/fs4QmK6+YNxB5Nf23ZGDEvPJHQYdn82AELyzTFTKqrFmYp
wc0BBKfaNplIr5dq+2b+
=FkVc
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
