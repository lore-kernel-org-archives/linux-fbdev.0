From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 30 Apr 2013 11:49:28 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <124304591.tbnLlR41q2@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2710109.8gOsri3Y4h"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <1547536.Us4pVspuI2@avalon> <517FAF78.1010306@ti.com>
In-Reply-To: <517FAF78.1010306@ti.com>
To: linux-arm-kernel@lists.infradead.org


--nextPart2710109.8gOsri3Y4h
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 30 April 2013 14:48:08 Tomi Valkeinen wrote:
> On 04/30/2013 02:42 PM, Laurent Pinchart wrote:
> > On Tuesday 30 April 2013 12:28:42 Arnd Bergmann wrote:
> >> On Tuesday 30 April 2013, Tomi Valkeinen wrote:
> >>> The bootloader would init the display hardware, the bootfb would give an
> >>> early /dev/fb0 for the kernel and userspace, and when the real display
> >>> driver is loaded, the bootfb would be unbound and the real driver would
> >>> take over.
> > 
> > This could be done with a KMS driver as well ;-)
> 
> Right, I forgot to mention that. I had it in mind also =).
> 
> DRM has the same problem as fbdev with multi-arch and lots of display
> and panel drivers.
> 
> Probably the same bootfb could be used for DRM also. Or do you see any
> benefit of having a "bootkms" driver, or such?

As part of the (long term) effort to deprecate fbdev I would of course prefer 
a bootkms driver. The KMS fbdev emulation layer would provide fbdev 
compatibility for free during the transition.

-- 
Regards,

Laurent Pinchart

--nextPart2710109.8gOsri3Y4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJRf6/NAAoJEIkPb2GL7hl1c3sIAIZZdaRLBo+Hus0WbLtABrCK
CkCYelaTN4BDe25gcBeCx4Ns/7+9d0GS1O1Zbe6EWZDwi31ZrU7d8bpqvsfHqbjC
5EOOemg9tBaYBirrM1Mip7CKUK1dD/BJjwgHhK5HUIzASlLcPO4jfUHUF5CBn9Q1
bj6po94j4RDQ1eq0andgRSIO/5KwHtHCo4anXYLYQm/hz6bTByEVQ3uTPwZZSUBH
CtpLobbpnmfdupfZlFE2coFpLYg2ssbtxhAfQMiV5YSfjtDVuIh3z2MIytsSEjIZ
GIcOwhMULf6tHq82UYTllbddTwjXEIyChgSCVRkk3Hlj2Owy3I9P11bboR9JAZI=
=D52O
-----END PGP SIGNATURE-----

--nextPart2710109.8gOsri3Y4h--

