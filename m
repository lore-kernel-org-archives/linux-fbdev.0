From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: i810fb fails to load
Date: Mon, 22 Jan 2007 19:30:38 +0100
Message-ID: <45B502CE.1040500@imap.cc>
References: <20070111222627.66bb75ab.akpm@osdl.org>	<45AAC244.8060607@imap.cc> <20070114162235.4c8d241f.akpm@osdl.org> <45B4BF50.9010105@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5C69C2B78136CD764C050A5"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932219AbXAVS0G@vger.kernel.org>
In-Reply-To: <45B4BF50.9010105@tungstengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Dave Airlie <airlied@linux.ie>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5C69C2B78136CD764C050A5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 22.01.2007 14:42 schrieb Thomas Hellstr=F6m:
>>> On Mon, 15 Jan 2007 00:52:36 +0100 Tilman Schmidt <tilman@imap.cc> wr=
ote:
>>> With kernel 2.6.20-rc4-mm1 and all hotfixes, i810fb fails to load on =
my
>>> Dell Optiplex GX110. [...]
>>  =20
> Can you try the attached patch to see if that fixes the problem.

Yes, that patch fixes it.

Thanks
Tilman

> -----------------------------------------------------------------------=
-
>=20
> diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
> index 91c1f36..6ef0960 100644
> --- a/drivers/char/agp/generic.c
> +++ b/drivers/char/agp/generic.c
> @@ -190,6 +190,7 @@ struct agp_memory *agp_create_memory(int
>  		return NULL;
>  	}
>  	new->num_scratch_pages =3D scratch_pages;
> +	new->type =3D AGP_NORMAL_MEMORY;
>  	return new;
>  }
>  EXPORT_SYMBOL(agp_create_memory);
> diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.=
c
> index b8896c8..5a0713c 100644
> --- a/drivers/char/agp/intel-agp.c
> +++ b/drivers/char/agp/intel-agp.c
> @@ -260,6 +260,7 @@ static int intel_i810_insert_entries(str
>  		readl(intel_i810_private.registers+I810_PTE_BASE+((i-1)*4));
>  		break;
>  	case AGP_PHYS_MEMORY:
> +	case AGP_NORMAL_MEMORY:
>  		if (!mem->is_flushed)
>  			global_cache_flush();
>  		for (i =3D 0, j =3D pg_start; i < mem->page_count; i++, j++) {

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigF5C69C2B78136CD764C050A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFtQLPMdB4Whm86/kRAmPEAJ4pQCV1vtBQTHCUUFXHrPlakUJaVACfSTE2
7n0NMkd5q0AKx361gERgB0k=
=xAy5
-----END PGP SIGNATURE-----

--------------enigF5C69C2B78136CD764C050A5--
