From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 May 2014 08:01:52 +0000
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and probably 3630
Message-Id: <536C8B70.1000306@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3jIX68OOgDqkWAxTqG5EtkJ1weIGNAqvK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <20140508232006.GG2198@atomide.com>
In-Reply-To: <20140508232006.GG2198@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--3jIX68OOgDqkWAxTqG5EtkJ1weIGNAqvK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/14 02:20, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140429 16:53]:
>> Otherwise we can get often errors like the following and the
>> display won't come on:
>>
>> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
>> the output with video overlays disabled
>>
>> There are some earlier references to this issue:
>>
>> http://www.spinics.net/lists/linux-omap/msg59511.html
>> http://www.spinics.net/lists/linux-omap/msg59724.html
>>
>> It seems that it's safe to set the lower values even for 3630.
>> If we can confirm that 3630 works with the higher values
>> reliably we can add further detection.
>=20
> BTW, I'm also seeing this warning on 3730-evm it may be related:
>=20
> [    3.523101] ------------[ cut here ]------------
> [    3.528015] WARNING: CPU: 0 PID: 6 at drivers/video/fbdev/omap2/dss/=
dss.c:483 dss_set_fck_rate+0x6c/0x8c()
> [    3.538360] clk rate mismatch: 108000000 !=3D 115200000
> [    3.543518] Modules linked in:

Hmm... Can you paste the clk_summary from debugfs? Somehow the clock
framework calculates the clock rate differently than the dss. Or do we
have different clock.dts files used for 3730 and 3630?

 Tomi



--3jIX68OOgDqkWAxTqG5EtkJ1weIGNAqvK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbItwAAoJEPo9qoy8lh71tFcP/1p90wC6hphrF0G+gPZX/AEX
An0Mzt0BXvPzVBsyy/KQxMtpr/YFRPvNiGL52zYkMsLWaSkzfExGxfj5VboCWr6D
1uspLD+dr12EUKYpk2rlGARLh2OiNvoC0p8nDmbvWCL4Eo+aWPEB24lFg6EbCChy
VyMZzpaNultkwAxCH7/PJ3WIFuVGl1TptWM2a7mLIfdmeFr1nPfrz1JNrBgDlqbi
3NhuJJK2zroTM8h2U3RufLu+EwpFuVXf+N72/ZkOcqPb+YuF0+H4ahNHqDXAq6FW
cA/9B6qFzKSgI5/t9peEYbSLjneKPSApnMjluUabxjmQ8RoA0DSruidODwdbBaLj
AfLz4pZJky7XwawxVwCUgRouQbdjxVMnPAqOCCysiqVLCSwsbXepP3W46vXHHpKe
P4BD14G0WpJETzMdtrh+8PnNCmxeV+cdvj/d1RZWz8XGEkjaw/ecsWeBKoyP80q6
9j2Vo2QeC2EP8q3QT/W9S5fQkL2/KTfpKyb3TYAZVTIiyyK2csjqCMTRs1VmMUA7
MtZp8iUXAaqPg8KADcL/ab/K4o16AXpmVsAA37Bhw05auXtMPwijb1PEKzydjheF
IkD49RImPplb+yhsWD+PzdB88H99Li8dVjehseO4/qj7DUT/jm++w8L9mqDrvDN+
8yKOaA5gWBjImaheoX2b
=Oyw8
-----END PGP SIGNATURE-----

--3jIX68OOgDqkWAxTqG5EtkJ1weIGNAqvK--
