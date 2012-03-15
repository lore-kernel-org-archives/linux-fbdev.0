From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 15 Mar 2012 19:29:20 +0000
Subject: Re: [Linux-fbdev-devel] [uclinux-dist-devel] [PATCH] [#7001] framebuffer: old image of last app woul
Message-Id: <201203151529.22298.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1901541.3H0gmpVrs1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203151508.04564.vapier@gentoo.org>
In-Reply-To: <201203151508.04564.vapier@gentoo.org>
To: linux-fbdev@vger.kernel.org

--nextPart1901541.3H0gmpVrs1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 15 March 2012 15:22:34 Geert Uytterhoeven wrote:
> On Thu, Mar 15, 2012 at 20:08, Mike Frysinger wrote:
> > On Thursday 15 March 2012 05:23:50 Wu, Aaron wrote:
> >> Old image of last application would retain for a while when starting a
> >> new application, this patch clear the frambuffer before displaying
> >> every time the fb is opened.
> >=20
> > i'm not sure the behavior you describe is wrong.  in fact, i'm pretty
> > sure it sounds correct.  if an app writes an image to the framebuffer
> > and then quits, that image should stay there indefinitely until
> > something else opens the framebuffer and draws their own image.
>=20
> Indeed. Else can you no longer make a screenshot using "cat /dev/fb0 >
> file".

ironically, that's one method we've documented for Blackfin platforms :)
http://docs.blackfin.uclinux.org/doku.php?id=3Duclinux-dist:framebuffer
=2Dmike

--nextPart1901541.3H0gmpVrs1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPYkMSAAoJEEFjO5/oN/WBjP4QAI9ZleskV9MbFdTuho4mrp7s
nsvaDPYVL6mwBRtLFSM6kiBdMIsagJvYoD8roRTUtKcywkTSEHNSNfbI899usvoh
DeZuwM0yif0Zt9+WqNJRSxUhLahHfMRVHcVSnPrOfxytt+kgWkPO07dgtyW7JZYY
OhekTXAhkNuZ6UBMRCpfFeZISW6k1VK/SkzX4O72Lk98NzdkJG+VKNmNofAC8IX/
fHecEYUcPnnAdeGNPmRzP3R0Iwb8Wkv+80KvDNc8BWxKVSH7JEDe6g5Yq44Gz8n/
JLLHzxu7mgI1detpZRd62p7pln1Cl8luMJfZwE/TWZBwzHH25Yo4jEIKDocn37BL
yfMk7rJCC+EtuFQFEhohh/hdpNA9NAU3eWaElQo64GtV8Ggc0ZZ6LlggY+yq2wXj
JtSgaQ/io7pOfWoNqqWcxYwmVopiufn/cQNYJbArT2nXUI7mqyUG40dn0vA/v+be
LhGj1S5ldyyNH0ekA9EumfDfnC1y6gm3c/Rq/gN6aVxKLOjlDFKXT/OsGqdGl2Kv
9CH8DouWmywpFB0WhBuxFH+tRG3L/HwyVZ68LYbtf7+/5hFYPGseI8t5BymolZwh
mJ+57KF7WK56wmKcon2Bx4dV09HjtOv9A7EMbvPfXS8ak03KiGfE+w8JBfztyBXf
vNiwUU/uyOStv2dWD7/m
=1672
-----END PGP SIGNATURE-----

--nextPart1901541.3H0gmpVrs1--
