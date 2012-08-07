From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 07 Aug 2012 10:52:03 +0000
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Message-Id: <1344336723.7216.44.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-edqsgrFFLbjcrd/N7qrp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
In-Reply-To: <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>, Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-edqsgrFFLbjcrd/N7qrp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-08-07 at 13:57 +0530, Chandrabhanu Mahapatra wrote:
> The cpu_is checks have been removed from DISPC providing it a much generi=
c and
> cleaner interface. The OMAP version and revision specific functions are
> initialized by dispc_ops structure in dss features.

I think this needs some changes. I think our general approach to these
version differences should be such that the component in question (dispc
in this case) should ask from somewhere what the DSS version is, and
then using that version, handle the different versions internally.

What that means related to this patch is that we should keep all those
functions static, and initialize the dispc_ops structure inside dispc.c.

However, we don't have any such "DSS version" yet. I have previously
wanted to move the cpu_is checks to one place (dss_features), but I
think it's probably cleaner if we allow cpu_is checks in the other files
also. However, there should be only one place in the file where those
should be.

So I think we should have something like this, called from
omap_dispchw_probe():

static void dispc_init_features(void)
{
	if (cpu_is_foo())
		setup features for this omap;
	else if (...)
		...
}

This would setup the ops, or whatever is needed. This function would be
the only place in dispc.c that contains cpu_is checks.

 Tomi


--=-edqsgrFFLbjcrd/N7qrp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIPNTAAoJEPo9qoy8lh715l8P/j26txlRVi7E6qyl9ECOixrC
UnagaYUTT9mE+XN26JtL1WV+YbqyfD3JjlbydPRKZLiqNjO/h4FgnKLxfpfPjmlC
VL/Pds/Ra+jYRfvNkr0S131yf+IGU3GvzMj+s0DZ0O85delI7Q/JZ0o5jUQdlL7h
r2xhzh4vml3asdUtjqRMs5/ScOoQxmkOp39L9sL/Q7C6yTMADpcq0IkLx6gMem9S
TjQVkxUEYR07CKWqT95aL6Qc6/sUnKub4R+AhgqF5MibngyZVeXonCyBnV/kVtsb
ZTHpXTsYU0HHSyXb7iNnRF2MhloeG4o4rWs0/tXTl5uU1JKVkwVRTGzZXtcE3nBk
uOTZf6+nFB7POtBi2cNN6PWL1CSKctF3BGcXst3oxfTUaIiaUAnszfu0fHXP5T+f
iLTR0GhZJIzvrf74rEmeXpuwjNKk3m4luuxtPghDlT51mPglU3TE+9lum4ZXJvOa
/VbjpwLu4YQ83xTX49tomYsifuKq9ssz84hfd6yDpyICoAXZLB5jeGzuJvW0nGzu
IxkRsYolM3TE3N+qD7YuhYR/ur7zVuWG/c8dQ0ztWjiCIrbF3r/Ip2CVR6bGniEz
xkh73QRaBOLvG/2n3gTxM+iXPcNGTIbxG3Om9nIjWXJzY0Jk887nH02jnBgQHy8s
0zsZk/1k6heYSN9rCYT6
=0ppW
-----END PGP SIGNATURE-----

--=-edqsgrFFLbjcrd/N7qrp--

