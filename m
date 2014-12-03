From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 03 Dec 2014 12:57:33 +0000
Subject: Re: [PATCH] video: fbmon: Check Standard Timing against DMT and maxclk
Message-Id: <547F08BD.3070209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="j1PKsTCwLQsRsG4L3BnhnmSLkwkdH7t8F"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416626512-12919-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1416626512-12919-1-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--j1PKsTCwLQsRsG4L3BnhnmSLkwkdH7t8F
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/12/14 03:16, David Ung wrote:
> Ping?

Sorry I haven't been able to check this yet. I had a brief glance, and I
wonder if the patch should be split. You add modes to vesa_modes, I
presume those modes are valid even without any DMT or maxclk changes?

Also the maxclk check sounds like an independent change.

In any case, I think it's too late to include this into the next merge
window, as it's possible that this patch could break many fbdev drivers
and I'd rather have this patch sit on linux-next for a while.

 Tomi



--j1PKsTCwLQsRsG4L3BnhnmSLkwkdH7t8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfwi+AAoJEPo9qoy8lh71xXcP/jWivSmDny5do4l0zQN+LojM
Adv3SqTz2wFqKs+NnKNweLREsDr0pTKULZDVMxIceXLdHnFpJagU9i7eQz1E9Cfw
beXVm1Z8n8ec56pFX7i4Jq33SnQAp1JhPN6sf2JH+K+g9NZYAnDB08pifFCCZR4B
QQOqgSGGKCnBsZtBtB8djzSXcR02u1tVRDsBa5hzJoiPFNY+aGWw1uFHbNZqfsRV
d5zPlsL3B4lxVb4BtS7vVcCnKRyYneyNgU06oxLyHM4hMJjleKA9wK/E+SjPCRN0
kudmhYDciciBUbnwWlai6Th/X6sANM1qnavMYXOm1p82uwiSv4LEYrWigyn+lE94
DjyiZnqkQWks8bE3aSttpDTWiKRTbTGxnuLggK0yg370NPtU6gY4/1kYSxS5qD7A
CpfKgH0Olp51r5i5/ddywOu+dYq5Va0wMcszClMbaF+XyocgEnL+X+ZUo9qMlIhG
rzo1U0aNDoq8y3Wqk0nH/sOcGpq6NfdRw/HV+szatZX/6ccb/XcyAYGVd3B3OFRe
vR7JEGoPdbTb/yebntk4hZsfDbEUsfc5lxZTLnY5VQe4hdSjOyWmPF3x7mgmIiFn
Mi8DiCrZmFljkbiYqZ5zse/oE/lBBk8OxCI7NrVjKLnqRAIXWC9qbqbCPRucngEW
25qF/y4JHJ4Qjdd90k1j
=UcF8
-----END PGP SIGNATURE-----

--j1PKsTCwLQsRsG4L3BnhnmSLkwkdH7t8F--
