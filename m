From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Apr 2013 11:46:20 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <517FAF0C.1060901@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2SSNGBLWECRASEISUWXSU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <517F7245.2050606@iki.fi> <201304301228.42245.arnd@arndb.de>
In-Reply-To: <201304301228.42245.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org

------enig2SSNGBLWECRASEISUWXSU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/30/2013 01:28 PM, Arnd Bergmann wrote:
> On Tuesday 30 April 2013, Tomi Valkeinen wrote:
>=20
>> The bootloader would init the display hardware, the bootfb would give =
an
>> early /dev/fb0 for the kernel and userspace, and when the real display=

>> driver is loaded, the bootfb would be unbound and the real driver woul=
d
>> take over.
>=20
> I think that's a great idea. What I'm not sure about is how that
> infrastructure for switching frame buffers would work and how hard
> it's to write.

I don't have any clear ideas either, just some vague ones:

I think the simplest option would be for the userspace to just unbind
the fbcon, then the bootfb device/driver, and then load the real driver.
I don't see why that would not work, but it's far from optimal. The fb
memory would become unallocated for a while, and the user could see
garbage on the display.

A proper hand-over would be more complex. So, I don't know... Maybe the
bootfb driver could have custom API for this. When the real driver is
loaded, it'd call the bootfb to get the fb memory, and to unbind the boot=
fb.

Would there be issues with passing the fb memory? If one uses dma_alloc,
the device is linked to the allocated memory, so I presume you can't
just pass that around and remove the original device.

Then again, dma_alloc would not be used here, as bootfb needs the fb
memory from a particular location, so I guess bootmem is needed here.

I think it would be reasonable to have a restriction of only a single
bootfb instance, so one could just use static global variables/funcs to
manage the hand-over.

All this, of course, presumes that nobody else than fbcon is using the
fb. But I think it's also a reasonable restriction that the fb device is
not used (mmapped) by anyone.

 Tomi



------enig2SSNGBLWECRASEISUWXSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRf68MAAoJEPo9qoy8lh71+uoQALJjgPJLhXiltM/VfFcXRXg+
KszaL4x5v18AvbpXulFtHPry4+hKyli0lObMFluEM3mSnmVCmBer5BzaR80sGDj/
S8hf8Z8hCiRgVFM1HmVZMUN2eJXIkqGSRKIqn8FznsnnZtAFps+VpfO8eJqFQHYn
tVfZcmQ4a7P3Pvyuk8Cp37jmcO6cjRLtBj+N4eDIwX8J8Z5Y8mCnBowmX+7L1ZFV
7IU4+yP11e9wL5lC/TQWvM0ap8gryxoun207GPgajrzjpY4wmvjJlwtpqnaXNN++
0D9zTv9wtwUQaTc5YhvdaaNMqjywY/MGYPS3trbEHuwW/qnOClKofp4o2KAgxxTH
/U1GsyEU3gE+HpEI++tEp8Z/gZjBfi1c7QuiTYDTba/XreSh4at1HmmTapEvYQgB
ms7ulWyt0UHAobE1Ykowwdf1dztCCOl8V+v7r9H7MfQNdlHa8qu/iLYH/1+KyEZD
GnUKhdVOYHUOtcXANH3z1mFy7lFooVL3pxXFmVAy/XGM+nWXRmJ97ZUt3WXyFc0J
awvvL8c+mR57NEkY3WHrL2qsJXvj/RF95zLlLe8W5Uei2hr3OVRxl+E2iaBKuPDN
yOAVBidkoOt1J34b0nZ1VEGNEITpuHSCRJ+6q5v4NbwR26p2PSj6Fzcq9+L1NR46
smDIOixjOZeNHCurjzo2
=Un5v
-----END PGP SIGNATURE-----

------enig2SSNGBLWECRASEISUWXSU--
