From: Michal Simek <michal.simek@xilinx.com>
Date: Fri, 31 May 2013 12:55:30 +0000
Subject: [PATCH v3 0/8] xilinxfb changes
Message-Id: <cover.1370004925.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-8064-1370004938-0001"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-8064-1370004938-0001

Hi,

I have done more changes in the driver to support probing
on little and big endian system where detection is done
directly on the hardware.
I have also done some cleanups to get it to the better shape.

Thanks for your review,
Michal

Changes in v3:
- Remove out_be IO name from function name
- Change patch subject from "Do not use out_be32 IO function"
  to "Do not name out_be32 in function name"
- New patch in this patchset based on discussions
- New patch in this patchset based on discussions
- New patch in this patchset
- New patch in this patchset based on discussions
- New patch in this patchset

Changes in v2:
- use of_property_read_u32 helper function
Series-changes: 3
- fix commit message

Michal Simek (8):
  video: xilinxfb: Fix OF probing on little-endian systems
  video: xilinxfb: Do not name out_be32 in function name
  video: xilinxfb: Rename PLB_ACCESS_FLAG to BUS_ACCESS_FLAG
  video: xilinxfb: Use drvdata->regs_phys instead of physaddr
  video: xilinxfb: Group bus initialization
  video: xilinxfb: Add support for little endian accesses
  video: xilinxfb: Fix sparse warnings
  video: xilinxfb: Use driver for Xilinx ARM Zynq

 drivers/video/Kconfig    |   2 +-
 drivers/video/xilinxfb.c | 157 ++++++++++++++++++++++++-----------------------
 2 files changed, 81 insertions(+), 78 deletions(-)

--
1.8.2.3


--=_mimegpg-monstr-desktop-8064-1370004938-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGoncoACgkQykllyylKDCH6YgCdFWERa94V6WU4izCoqkwPTwit
Tk8AnRrcmvOeFNtkYcPge4Slbs3wJkfR
=18q7
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-8064-1370004938-0001--
