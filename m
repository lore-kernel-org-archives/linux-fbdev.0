From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 20 May 2015 08:45:39 +0000
Subject: Re: [Cocci] [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <555C49B3.7000804@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tKGwQ4jC3dmrovobIOb2xG6UplL4s3n6m"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150519175802.GJ23057@wotan.suse.de>
In-Reply-To: <20150519175802.GJ23057@wotan.suse.de>
To: linux-fbdev@vger.kernel.org

--tKGwQ4jC3dmrovobIOb2xG6UplL4s3n6m
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/05/15 01:17, Dave Airlie wrote:
> On 20 May 2015 at 03:58, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> On Thu, May 14, 2015 at 04:26:45PM +0200, Luis R. Rodriguez wrote:
>>> On Tue, May 05, 2015 at 06:47:31AM -0700, Andy Lutomirski wrote:
>>>> On Mon, May 4, 2015 at 3:33 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>>>>> On 29/04/15 22:18, Luis R. Rodriguez wrote:
>>>>>> On Tue, Apr 21, 2015 at 1:16 PM, Luis R. Rodriguez
>>>>>> <mcgrof@do-not-panic.com> wrote:
>>>>>>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>>>>>>
>>>>>>> This series addresses simple changes to framebuffer drivers to us=
e
>>>>>>> arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to ad=
d
>>>>>>> missing mtrr_del() calls. These changes are pretty straight forwa=
rd.
>>>>>>>
>>>>>>> Luis R. Rodriguez (17):
>>>>>>>   video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()=

>>>>>>>   video: fbdev: gbefb: add missing mtrr_del() calls
>>>>>>>   video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc=
()
>>>>>>>   video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()=

>>>>>>>   video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
>>>>>>>   video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
>>>>>>>   video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
>>>>>>
>=20
> These 17 are all
>=20
> Reviewed-by: Dave Airlie <airlied@redhat.com>
>=20
> Tomi, can you please take them via the fbdev tree?

Thanks. Yep, I'll queue them for 4.2.

 Tomi


--tKGwQ4jC3dmrovobIOb2xG6UplL4s3n6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVXEmzAAoJEPo9qoy8lh71nJwP/jm0W+VcjSXhpivZhXD2LkoH
/L3tUMk/Awu0zICdFfZPNlP1pslDnkQoY6aLO9X9SBCcMflWjQPDB4VpTFdpkJU6
CDuCz4l3ULkRwEU9uWlSpTc8whxAyzkHVfRomYS3Et4d5JSbr1nNePrTmB4nlGiS
qPscdTuA6g+OlaM49hzJvKiXTuXn6Y5SmbnvsSgTnasRTcFdIQNxQqW3S1lotZ2d
ACfrZbqr9nq23xWWzYNC+Bc/MatZ8fsbkmD+TZ2a+sKWlLOYrLbIvZjLp2riQ7pT
EUCzkXRmxTcVTRth9VdMZNmWnqrVja2eXQ0kAaxcotcRvBTAhsQBMNzL4IHrviyW
QjVmcO/W1mrkZpgfxZ9AGzAl21yUdgLpkJ6Cgf0W0WDYNdKUy16fiKXUlTuJpuZ+
BEA6AkqUCWAu3almxXqbLyx8zbqsjIF7RAOKTW1i1apEBuAdfpyFesdLyhkua1YF
qGoWq0cUcQSt2qLwBxjXt0qRi3hhPUIad37DymaOK7IiB0K808TO4pW+hfIlDqlW
GCjMlgiStZwm+Kvo2rslz6IHL3tyD3DqFTXYaaeP0WWh6giKq+fn2gEa4CHYgYCs
SiZwtEuFViBF4NFwzCxQtMzKjUUW7yZjOM9xS25EU1X9FMKGxpXY3q11DEKB7Rsd
SW80+Stuta+Dj6wXD7ED
=/7lt
-----END PGP SIGNATURE-----

--tKGwQ4jC3dmrovobIOb2xG6UplL4s3n6m--
