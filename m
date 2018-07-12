From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 12 Jul 2018 10:16:05 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <d9030c6d-e650-0b8d-541b-76542515387e@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
 <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
 <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
 <20180711151911.2ea40200@gandalf.local.home>
In-Reply-To: <20180711151911.2ea40200@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: Petr Mladek <pmladek@suse.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hans de Goede <hdegoede@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z
Content-Type: multipart/mixed; boundary="PWWLxQqOZ55MRNZx1kdjmHyUp5uLhbqD2";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: Petr Mladek <pmladek@suse.com>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>
Message-ID: <d9030c6d-e650-0b8d-541b-76542515387e@suse.de>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
 <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
 <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
 <20180711151911.2ea40200@gandalf.local.home>
In-Reply-To: <20180711151911.2ea40200@gandalf.local.home>

--PWWLxQqOZ55MRNZx1kdjmHyUp5uLhbqD2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 11.07.2018 um 21:19 schrieb Steven Rostedt:
> I just sent the patch. If the printk maintainers take it, then you can
> update the fb driver to set the ignore_console_lock_warning when
> lockless_fb_register is set.

Thank you.

>=20
> -- Steve
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--PWWLxQqOZ55MRNZx1kdjmHyUp5uLhbqD2--

--6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltHKmoACgkQaA3BHVML
eiO5TQgAqm8yCMpy2qDkvDfvqNqm6ymICc04QWvrr9Cm7oKTB+9NzxHy7lhsknYi
NnGEdEtujEprj9+3ntTYpc2CEsbf5zvLlGDKcmOZiaod6SdcMUOboD3ramm6I7e/
l49HZILSc6CEkY00yWWfn9QLTIe/lIHpjHoV0Yq+KtPV19vFr5KPFnHS9/yPSpTR
g8zs75ENTn6qetEQCPO9l87zIiXxXYsjQBTB6FP/5r7OP/Eo5w0tcN+sP53L2GYO
u549hxGVPiA+JhPqIX6EZOInHDFWqGGhxxOMoRLkBUyfHPzcWRW8BuUSR5KeN9g5
7X0aCYILKL9BXcGWeKnMyIK/GGE93w==
=TPee
-----END PGP SIGNATURE-----

--6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z--
