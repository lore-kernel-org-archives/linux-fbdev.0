From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Mar 2016 16:49:53 +0000
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <20160331164953.GD2350@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tfudkhBUqbdcU4Ca"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org


--tfudkhBUqbdcU4Ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 09:30:11AM +0300, Tomi Valkeinen wrote:

> This code did fix an issue, see 02b7a32083b9930543663720758de249b4f6a2a3.

That change isn't sensible, especially the _can_change_voltage() like I
said in the commit log.

> Now, even at the time when I wrote that fix, it did feel a bit odd to
> me. I have to say I don't remember the discussion that led to the patch,
> perhaps it was something along "yes, the driver should not need to do
> that, but for the time being do it".

That wasn't a discusion I was involved in, a quick google suggests it
might've been off-list.

> So where are these "machine constraints" defined?

They're the DT.  Your machine constraints just seem broken and need to
be fixed, most likely whoever wrote the constraints for the platform
completely failed to understand the purpose of constraints and filled in
the maximum range of voltages that the regulator in use on the board can
support.

--tfudkhBUqbdcU4Ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/VUwAAoJECTWi3JdVIfQxVMH/R6ho85B1eXt32o6VlZgy+6m
dTRhTaL8Mm0ZidjKCPSy51JskZS2f08zNwrBVqLzTL408yjPPxsDhyy0/1N11iO8
Ona+6+g7kaKrPmfEFPuqnd3EbK5Gyc+LMUMIzSo/wTT/S/R2V/siJZvYqOEal7Zg
qtZ/XMlwt1osxuvb+pSYimQF2Zf3cNumjxJKwswwS9yNiSUfM7jYtqCY1+CmMqP5
WwlUWiatkhgE15NWN0nQ+NJpRklGAX6MBatJIki4CzRA8BBdy9HXDTQ4APx+kQ66
nPom+2AH+3tUpEqaNvdFxJJep/r46RU6UlwKmlAEOfAVaxU1KQL/0h0s9ceUvGc=
=qW8n
-----END PGP SIGNATURE-----

--tfudkhBUqbdcU4Ca--
