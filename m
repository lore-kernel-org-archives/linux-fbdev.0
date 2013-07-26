From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jul 2013 07:35:30 +0000
Subject: Re: [PATCH v3] video: xilinxfb: Fix compilation warning
Message-Id: <51F226C2.9000206@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EnWmfqINw3pxcJoC2x2Q7tO0TLBvKK2WT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <b8701d73538d37495b41ef465440a6d5f3018870.1374759923.git.michal.simek@xilinx.com> <51F2262F.1020203@ti.com>
In-Reply-To: <51F2262F.1020203@ti.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--EnWmfqINw3pxcJoC2x2Q7tO0TLBvKK2WT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/07/13 10:33, Tomi Valkeinen wrote:
> On 25/07/13 16:45, Michal Simek wrote:
>> regs_phys is phys_addr_t (u32 or u64).
>> Lets use %pa printk format specifier.
>>
>> Fixes compilation warning introduced by:
>> video: xilinxfb: Use drvdata->regs_phys instead of physaddr
>> (sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

> Thanks, I've applied this into my 3.12/fbdev branch.

Actually, let's put this into 3.11-fixes/fbdev branch.

 Tomi



--EnWmfqINw3pxcJoC2x2Q7tO0TLBvKK2WT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8ibCAAoJEPo9qoy8lh71yp8QAILiKFtaKgYxVeJwXLu6/Gs/
8ozrxCUSN1gt0gxE9V7IJvvcUjKJmz/hPpLKnX8z4iRX87u/S/jTMa+dN0yFqPLq
tqzQDbHdZu/hZQ1w+yzZCC7howmZzqtt4IXUgbwbCUiJBv1du7vDRDIwnR2uy6lG
4tfX9ebcax6S+tmqLyCtGwVjGvJ/oWfRWYKGbs8n7aNvzo8uUTdNHUlwHqm2hObF
69BkEawdTcYZXRPsTkJOkK2zl5S2kok+szj7AfTDBXWNO9PRSMo3yMWjiev7nCni
SOM2+ezcRtKVGD6NphcD5lF4vrqwm+ugj9yUCXRdVp1yCZdYGxtItX7UO2ZCt8Cf
AgGyDIXZsGr14hnVftS9RkWsNiy5RjKK+dv+U/LMQ4AUaBZ6c7Du+gUJR1vsSuaR
G4w1dm2JmFrZpcLNL94wOO388Pain/SYxa1rNswXDIuEXcAwa1PUKvQY+rc8tZOI
w33jj2QuUVhM9zLkLISPnYi15dONuH9cf9w3pc1148Sck38CME+gpu/z2Reo4mAF
JeE9FRGXqVV9C3Pwfhoqmct6rlYYYW/klmEDwtnmrtAXqG4vVSEnIselPwcldBQ1
r3TwNF9VnCwtk3WnHQwanaZIKpFGSTdsHyUQkSaFsRWvqI+AsxgufRC9dmZwL1ck
pijA8qyTd/QbV6HxxV4N
=hDnl
-----END PGP SIGNATURE-----

--EnWmfqINw3pxcJoC2x2Q7tO0TLBvKK2WT--
