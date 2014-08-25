From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 25 Aug 2014 15:07:05 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825150705.GB15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qrXwk4mdkt00hRU3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
In-Reply-To: <20140825145303.GC14763@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org


--qrXwk4mdkt00hRU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 04:53:06PM +0200, Thierry Reding wrote:
> Hmm... that's true. But we already have a way to deal with exactly this
> situation for regulators. There's a property called regulator-boot-on
> which a bootloader should set whet it has enabled a given regulator. It
> can of course also be set statically in a DTS if it's know upfront that
> a bootloader will always enable it. Perhaps what we need is a similar
> property for clocks so that the clock framework will not inadvertently
> turn off a clock that's still being used.

Except that such a property won't work either. Regulators with
regulator-boot-on will still be disabled if there's no one to claim
it. Just like what happens currently for the clocks.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--qrXwk4mdkt00hRU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+1EZAAoJEBx+YmzsjxAgD3AP/i7ysvnBzkMlQ8UAfCbxTY3D
4NHfA7kQmr/dTNOvhof12RPvy3HlwqgQil+c5URGoz+FChYWt39F+77lD8aZcKni
kowB9fRH3GujP2m8gD6ne3wxNt9df71mjE+KQMX6/4kNeXCHQsfRLKblBNcPFiVb
tv8vtCwLJLYRlNGEfrS7vbtnjM0cSBcuxBDse+4Sjqy9RCQJb6OGjJKbc8KOFulp
CMr1s6vyomb+/8ACAcV4HJuJcMv/k6UVyhwSE0GJA2Nq1DEHPBvL2W/yKEnEpIMy
ITr3PPRUYlPo72oSxI0EA7G5nRXAP1rYy3GEdiioL7FXdneBMVbmCe1vOPtmWd/R
EeabsKt0iyk3OpC7TVUIA3ZpNqezSpGKAkF2/+ElCo82z2rhjJSDYer6/WtWV/CZ
F+Pa+ivnwonG3jI3nskEcB+ZROWOKb1lKPVf+dPae30CeJK0UQDyNjLMxX7X5h7z
2uI/u4aIAvLE0mUWmtLDNGgtQkTBRk4qWI6+NPR5q2T+8xtqwfi7fhA7huDQarSl
jJ3KAWvWmXzyewihQ1byjLlN7WcNZs/n3fbNovtew6EvHHRzzkWYmTOe6Btghj4O
DudlJdfJNhMc1+B5B8j2WBLzZSUq5Z5o7IjQdn3x4C4UwjToeZFeQ+zPYxa1ge0/
CArj4eSfsOIos13M0vb8
=hv01
-----END PGP SIGNATURE-----

--qrXwk4mdkt00hRU3--
