From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Oct 2012 04:07:07 +0000
Subject: Re: [PATCHv2 1/3] OMAP: VRFB: convert vrfb to platform device
Message-Id: <1349842027.5972.8.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-deUDns5DsXNLmxr9L9Au"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
	 <1349785827-27055-2-git-send-email-tomi.valkeinen@ti.com>
	 <87fw5n1iwh.fsf@deeprootsystems.com>
In-Reply-To: <87fw5n1iwh.fsf@deeprootsystems.com>
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>


--=-deUDns5DsXNLmxr9L9Au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-10-09 at 13:37 -0700, Kevin Hilman wrote:
> Hi Tomi,
>=20
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>=20
> > This patch converts vrfb library into a platform device, in an effort t=
o
> > remove omap dependencies.
> >
> > The platform device is registered in arch/arm/plat-omap/fb.c and
> > assigned resources depending on whether running on omap2 or omap3.
> >
> > The vrfb driver will parse those resources and use them to access vrfb
> > configuration registers and the vrfb virtual rotation areas.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
>=20
> [...]
>=20
> I was having a quick look at this for the context save/restore piece in
> order to understand how this driver's context is being saved/restored.
>=20
> Looking at mainline, I don't see where omap_vrfb_restore_context() is
> being called currently.  Am I missing something?

No, the driver is missing something. I noticed the same thing. It seems
ctx restore for vrfb has never been functional in mainline. I don't
really have any recollection if this was left out intentionally from
mainline (possibly because we didn't have a good way to handle it at
that point), or was it just a mistake.

Nobody has complained about it, though, so it can't be a major problem
=3D).

Vrfb is a platform device/driver after this patch. Do you see any
problem with handling the context restore in runtime PM's runtime_resume
callback? Hmm, I guess then we could have a problem if omapdss and
omapfb are resumed before vrfb.

Any way to manage the suspend/resume ordering of unrelated (i.e. no
parent/child relation) devices?

 Tomi


--=-deUDns5DsXNLmxr9L9Au
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQdPRrAAoJEPo9qoy8lh71MskP/3YKDWgMC85rKeFjmUu2/KNU
Amt5+9yht2iZLk2MdqPsuCZUPf3XycKP0PQ32i56jEu4Y9AGMgIsq355r68HZz+/
5swQCQ8RwkouhgBBegJEy7tgXQBVTAbEygZEu4aAi6eTlbW/JNBzt1RsgpESLLpW
bTsXK2s4wx+6MUqArEdCt8210cQgMIU9Uzx4v/aKwtdM/Qyi5l1v4EA+NRMnMGyg
23GBXtHunBK6CAKp7SGucFpUThV+6lCvfeEHPEXCGLnmqz5+RE9q+SLAbZ69NVKW
8QnGbC6ZDVMAHRkuHKvtxMEzaB6wBnFgtBTmtuEmmD6NVt4iOmD52eB7PxN+KW3I
BzXU8O91omSv5Hhf5mvKrslKtmZgCXV1A6mUIRQ7NFoMlvGi93qnCoZnHhLETgvZ
tkI3sGV1se/LAT4BrdZmrYTihvUmcRsOCeaQXD4BT+dkwvAuWFTzpnv3VEUbyMKp
bkxWh45r/e1demrmWoQd3olJ/kPNqF2Yaj2ds4pHoEPuXVI2rdJfmn8FKmzicvMF
8iZujOOrcjrOSorlg5Hso0tkgOE4SnDJCJRiQKFJbjaiHQoV193vmGkK4AHgRPjl
cYzthixSY7oE/UVIB1xZhDMdVBD6WuaC5v35Gr1w13U/hY+sWEJ0ga6CvwFL5W9u
bMq5qwULGOP3Y0DGdYJ4
=zHGA
-----END PGP SIGNATURE-----

--=-deUDns5DsXNLmxr9L9Au--

