From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 02 Oct 2014 14:18:49 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141002141849.GD4039@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lc9FT7cWel8HagAv"
List-Id: <linux-fbdev.vger.kernel.org>
References: <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
 <542D476D.50004@redhat.com>
 <CAKON4OwOFVFZjxN-SJpDJLcyCpNOT4_mjjr9OpgGXmTYvZwT+A@mail.gmail.com>
 <542D4FB9.6090805@redhat.com>
 <CAKON4Oyb3KBWhGgKfwNop7+cwR=p=ZpVs-jfH0iQwm5scfOJ-A@mail.gmail.com>
 <542D5444.8090903@redhat.com>
 <CAKON4OxTmNRxSJum17RZGLLku5dAFPauzqyP0BOF-VC=bD=Hng@mail.gmail.com>
 <542D5C74.4050602@redhat.com>
In-Reply-To: <542D5C74.4050602@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 04:08:52PM +0200, Hans de Goede wrote:
> > 2) delay the clock/regulator cleanup until after there is a fixed
> > window for device specific drivers to load in. Loading from initrd is
> > a fixed window.
>=20
> As I already explained by example in another mail, this won't work:
>=20
> "delaying over the initrd is not helpful. Not having the real driver
> load for whatever reasons, is not necessarily a boot blocking event,
> and if it us just missing will not lead to any error messages.
>=20
> So the boot will continue normally with a black screen, and things are
> still impossible to debug."

Plus:

1) you might not have an initrd, which doesn't change a thing: your
clock get disabled before you can load your driver

2) you might not have a rootfs, and no driver to load, which would
leave the clock enabled forever.

> We've been down the whole delay till $random point in time thing in the
> past with storage enumeration, where you need to wait for say all members
> of a raid set to show up. The lesson learned from that is that you should
> not wait $random time / event, but wait for the actual storage device to
> show up.
>=20
> And this is just like that, we need to wait for the actual display driver
> to have loaded and taken over before "cleaning up" the clocks used by
> the display engine.
>=20
> I guess we could just delay all clock cleanup until then, not really
> pretty, and I still prefer to just list the clocks in the simplefb
> dtnode, but if this version would be acceptable to all involved, I can
> live with it.
>=20
> Mike, would a patch adding 2 calls like these to the clock core be
> acceptable ?  :
>=20
> clk_block_disable_unused()
> clk_unblock_disable_unused()

Thierry actually already made such a patch somewhere in this
thread. The thing is that it should also block clk_disable (and all
the potential users of clk_disable: clk_set_rate, clk_set_parent,
etc.) from actually disabling them. Otherwise, you might still end up
with your clock disabled.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULV7JAAoJEBx+YmzsjxAg/zEQAKeKSeNJA1fPT3cwyWyjYDzE
SBdzv2FmS6DarsxB+fCbM9luwxiSsKzyigaVSuS0JRPlIJWyCSL315KQpGZhAen/
xabUfZump7/64kiZzE1AMyGhaIntickTqGJPhAD+qVRkTLOsM3GGRIN4/CSEcS5V
+xAZiWBWuH8kI/lkafOxykNnhhPYUWIolOhtPZTYhBOSxkiHXcOzurbIWfkc+lRf
V3eDLobizZQPPZ25jDJw34n0l777tsN1+u5rc+FGSUbGzGL58UwwEIxrBTsDGDCN
Np4gweU+ge3ecdP+0C0JT4ppF9SjjCNfs4b/ET5ufafzYeGQTsBCKVIUjD+WVTT0
2tPD5cFFxL8GR11Hhyz2PSVvHl4Af/hPI3kVeOefhvfVfv7usVSeHawQCw/uw4+k
ZSvqcLuOnl70n/wgQfSeBJ+MDEP6DYeDEU5yt3YL+UGYJDG5raFXrOyl7e4xq5Sq
ctLVdnp4g98h+e3ewk1mfzDiL/MfKYZYDUnBtmCz8LWuILHGChl7UX3bXKoGsXGn
I3XeyjlpvoCRsTFzXSi4hcAvV6rxfmiOXyNhPqyHrKw4Xu5tx3Dj1t9BR4j+hST+
/W46ES11qkh/j6dfbTWt0YPt+yr+/u5xVU/4nKvSKWScwebQYDn/mCee6YLUG4I2
VTNYB/nc4gHrOhvWDfcX
=c3KL
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
