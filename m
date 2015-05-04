From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 04 May 2015 10:33:34 +0000
Subject: Re: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <55474AFE.5040605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rKm6fTV8mxCNWFIjCBUHKiwDbxxCadBBQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
To: linux-fbdev@vger.kernel.org

--rKm6fTV8mxCNWFIjCBUHKiwDbxxCadBBQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/04/15 22:18, Luis R. Rodriguez wrote:
> On Tue, Apr 21, 2015 at 1:16 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>
>> This series addresses simple changes to framebuffer drivers to use
>> arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to add
>> missing mtrr_del() calls. These changes are pretty straight forward.
>>
>> Luis R. Rodriguez (17):
>>   video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: gbefb: add missing mtrr_del() calls
>>   video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
>>   video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
>>   video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
>>   video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
>=20
> Hey folks, these are all pretty straight forward, can anyone take them?=


I can take these to fbdev tree. Unfortunately I'm not familiar with x86
nor mtrr, so I can't really say much about the patches themselves.

 Tomi



--rKm6fTV8mxCNWFIjCBUHKiwDbxxCadBBQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVR0r+AAoJEPo9qoy8lh71L9AQAK0mbisXTf7xi58cLeCIGCMq
6u5q2bUdLPLNPNXa6DXSenDxCjVsIuKeukFQYLN+4SuNNATJJ+dToHMYslbbZGFh
ySJl8H2jb7atpnEz2O83tRf9d37MK5+6DEbUHTvMPjM1W3NxKerETtA78uvfq1Wx
2ezAsuqJrekcr8bj4R3ISutjUCLhctkja62CXfeN4jMQp0U5P8PgGC2/1yxwEPvT
eWqkThiH/KdRaj9gAQVF1PDZHpFbareIp+XK3sSEd3cH/XP/1lbZ+giCXmUNyLiN
zMC9brPdDNPLBX1RDn7CIvJFH+mETcY8IxD+jRfIn4dFokpHZhuYvrWx3nT4KT63
xBHmGMpnGKnIR1+7LgIWH97wf8b65IT/qgb2mmuhFNzpivof7cZweQY2lLMjeoya
26nUIKSMu3pOIO9s9+fchZfNvt+mNL92oMtojmvFHtsWVfpzPGiDMuLkbo14HN1l
ckoKJixnfk0lAPp0nwlRo+hzOmUxBKo4Hsk2v/frtv84dkk5tWrogtpExeOUSIHI
f7ETDknTDiwgGmsQPHV17r63RRYakDR3sjM5tBLbQCBkpm93KsSMUs539mYoYbWe
qXi5s4sTdaaXIgvxVdbcQvNJ5Yo8nHpx9OSL1hUXdcDo77RC1xbh2Fe9zwv7IGES
x5MrcsKVcmc5NcuiMK30
=VkWA
-----END PGP SIGNATURE-----

--rKm6fTV8mxCNWFIjCBUHKiwDbxxCadBBQ--
