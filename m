From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 11 Dec 2015 07:57:32 +0000
Subject: Re: [PATCH RFC 0/9] omapdrm/omapfb/omapdss split
Message-Id: <566A81EC.1090209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SpihjaTp0KuP068DQucf5ScNJHB9NUXTA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <566A69D8.2060607@codeaurora.org>
In-Reply-To: <566A69D8.2060607@codeaurora.org>
To: Archit Taneja <architt@codeaurora.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

--SpihjaTp0KuP068DQucf5ScNJHB9NUXTA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 11/12/15 08:14, Archit Taneja wrote:

> Is it possible to make omapfb get some of the old files (apply.c,
> overlay.c, manager.c, sysfs files etc)? It might be helpful to have git=

> associate these files with omapfb/omap_vout since they have been the
> only users of it. After cleanups, these files would eventually be
> removed in the omapdrm copy, and it would be hard to track their histor=
y
> using the omapfb copy.

Good point. Unfortunately I don't know how I could do that...

I need to keep all the files for a copy of omapdss intact, otherwise
that copy won't work. So I need all the files for omapfb's copy, but I
can't remove (i.e. move) any from the remaining copy...

However, in the commit where I create the omapfb copy, I can add the
original path in the commit description.

 Tomi


--SpihjaTp0KuP068DQucf5ScNJHB9NUXTA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWaoHtAAoJEPo9qoy8lh71fAIQAKgDarUhkOUmTbumQGyn1Q9e
1AXlny7td64BHcEorJ9FSKphp1dWmhkF2JxCCwhP0p0HSEP7xvG4Ul/KvjLWs5zH
hs5By6Zdy0kJvuAuItgff5658J19/JkfgJn94yQ6GP3NHNnS68PbTBGDpot3+vnv
FZ/FY3rUIuXremVe6fQp5l6fxmeFhR0gRpt6gjYTL/LQLzQxgspq3DJl3F6zVcw3
IhzPL+AfpGGs3ud3Wj3Har1avHCKSxWcBSxtOfZWhppkIorh3MG4+yC4/vsG9SJl
wQbScSUICA0XzodnzKAGvDqqBWPSyaVo1bMQj+/C8uh+5BrUdxyp4LsXFnDOfZBM
hOIb9OeclPPYEtD0Smh9nfmLUwh5yMgzYOWvW0FiHguSwaDWLnd0KGMre9a08Smd
BbU0d4q/8wfRd9vbRxqLih0ZeXhcez+8ae1zmbBdaRoRkfV86DkYISeQ1nguhKr8
2yNVHwTUmGBoQ2SrHgo1pKvaee/3QPZZ/f59XH2ahxfPKHHLQ9i09Ez2aSGOtRmN
vmV11KUH0ngReAQeDGTPZFEeYsrGrRONMplTf1u9Q1I/6HVs7uuaKqzs92qGSugO
fgbsXqUk2dHenpH9eL+2j7f0tBhXbiUxsEtf4rN0ARu1K3mqtReToCSCsdQtSBom
vstq+olT342letS3BJ0t
=W7Sf
-----END PGP SIGNATURE-----

--SpihjaTp0KuP068DQucf5ScNJHB9NUXTA--
