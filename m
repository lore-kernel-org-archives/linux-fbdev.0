From: Ismael Luceno <ismael.luceno@gmail.com>
Date: Sun, 30 Jun 2013 17:54:30 +0000
Subject: Re: [PATCH] fbmem: Export fb_get_options and (un)register_framebuffer symbols
Message-Id: <20130630175418.07f024d6@pirotess>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/xt3NuPtQ=lKv_jp475g_9Q/"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372624575-7664-1-git-send-email-ismael.luceno@gmail.com>
In-Reply-To: <1372624575-7664-1-git-send-email-ismael.luceno@gmail.com>
To: linux-fbdev@vger.kernel.org

--Sig_/xt3NuPtQ=lKv_jp475g_9Q/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Jun 2013 19:42:36 +0200
David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>=20
> On Sun, Jun 30, 2013 at 10:36 PM, Ismael Luceno
> <ismael.luceno@gmail.com> wrote:
> > Signed-off-by: Ismael Luceno <ismael.luceno@gmail.com>
> > ---
> >  drivers/video/fbmem.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> > index 098bfc6..910909c 100644
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -1743,6 +1743,7 @@ register_framebuffer(struct fb_info *fb_info)
> >
> >         return ret;
> >  }
> > +EXPORT_SYMBOL(register_framebuffer);
>=20
> These EXPORT_SYMBOL() calls should all be available at the end of
> fbmem.c.
>=20
> Cheers
> David

I noticed that just after sending the patch :/. Sorry for the noise.
I'm getting the following errors while trying to load ttm and nouveau on
a vanilla kernel:

drm_kms_helper: Unknown symbol register_framebuffer (err 0)
drm_kms_helper: Unknown symbol fb_get_options (err 0)

--Sig_/xt3NuPtQ=lKv_jp475g_9Q/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQEcBAEBAgAGBQJR0Jr6AAoJEBH/VE8bKTLbVooIANOlhsYeYzt3ynggdDgi5PpH
oL2VyBOz3nlSuhxP+hhSKikGoM2FpzPFcFZ7B/nCEr528sly62SkHjW9EXPOp1Ob
41JBEl47jRFaUd55iHyvQJ8/wQ3Z/YYk8gCCdCM/ukmqUwq7P507uOK9MZX2lSTX
OdSa+XBATPl9o5jsHp4ootCKiA19H+7pSgJjYlJTMc0xvxyrG/J/rGw6xQDeLjFX
8c1CvUUZdKsi4iQ0eEJcTYTI5kjNCQV7OIOkRjk1TZ0Y35b+SfG/HDp0mwk0bC1B
3Bm5WK2k0aNEnAMpuC+xeJHVBEHGjRtwh30fVpQg6u7jzFJw9ZiFBfq10GeKdbo=
=Ay4o
-----END PGP SIGNATURE-----

--Sig_/xt3NuPtQ=lKv_jp475g_9Q/--
