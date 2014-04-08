From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Apr 2014 10:10:55 +0000
Subject: Re: [PATCH] video: imxfb: Select LCD_CLASS_DEVICE unconditionally
Message-Id: <5343CB2F.9060706@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mcdTmAgB2xa1As2EQBnogKKWdb2dti4Pu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395298711-14619-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1395298711-14619-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--mcdTmAgB2xa1As2EQBnogKKWdb2dti4Pu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/04/14 13:08, Alexander Shiyan wrote:
> Tue, 8 Apr 2014 12:58:32 +0300 =D0=BE=D1=82 Tomi Valkeinen <tomi.valkei=
nen@ti.com>:
>> Hi,
>>
>> On 20/03/14 08:58, Alexander Shiyan wrote:
>>> FB driver uses lowlevel controls for LCD powering and contrast changi=
ng.
>>> Since LCD class cannot be used as an optional feature and should be
>>> compiled for using in the driver, this patch selects LCD_CLASS_DEVICE=

>>> symbol for the driver.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
>>>  drivers/video/fbdev/Kconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfi=
g
>>> index 67409e0..b7cb0af 100644
>>> --- a/drivers/video/fbdev/Kconfig
>>> +++ b/drivers/video/fbdev/Kconfig
>>> @@ -328,6 +328,8 @@ config FB_SA1100
>>>  config FB_IMX
>>>  	tristate "Freescale i.MX1/21/25/27 LCD support"
>>>  	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
>>> +	select BACKLIGHT_LCD_SUPPORT
>>> +	select LCD_CLASS_DEVICE
>>>  	select FB_CFB_FILLRECT
>>>  	select FB_CFB_COPYAREA
>>>  	select FB_CFB_IMAGEBLIT
>>
>> I presume this should go in for 3.15?
>=20
> Yes. Otherwise we may have problems with the compiling.

Ok, queuing this for 3.15 fixes.

 Tomi



--mcdTmAgB2xa1As2EQBnogKKWdb2dti4Pu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ8svAAoJEPo9qoy8lh71sS8P/RZvu8zMq+2CiKN22ZDIAk31
gczR5kFLQp2nha05xzi8oGSqbcXGw8jfLOdqnmVz9v/pTkDYUQCzQOnrSTwKawP0
fCDClJFO0ydmfiTV5hpnV7NqDsVJ3eySDPpm8AaYZkNPB34DuAtQpg1Ws33d+rf9
l0x7cg67yhzbCGwn4dl/vP7R/yGG/8XCUIEytzCaoFQSureDKCDiSDhB6fP7vBOX
C9TMTK5OuvWqPIHHE1pPLkbOl8iYVzrAke7djsLFJGATt3uB3Ju2lyUZq/CSyiaV
uk4BM79c2dTkO0tVfKsZkCde8dzDJoOoD/XOnSe2FONclpf5YBaOjR6KRohms5Vk
c+fWdo5S2vI34MzDkEYsNjgewRddp3Gh3gnVIhZSAa/aWZYaXArn5UEszAvuKSM/
juh0ymKqpJmif99AH/Dn4DXYsIQwko6T1/BQvSuXqR5JEnYP3I3ggbtDHnyzPU6t
PMRTSuVyx7aBymp16NJdPZYlpXoLd2CjwSzoHfxvlIMYOK5L5Wq7naL9ZUc3vJ9a
m/ohr1wIGSW6u0xUq7IwbogTt6X2wjoJ6KuZKbQumuUmdNOqUdEhkerXT8bth0dE
seuxnGrt19dx6nCIDG8Ylrhhzh6SPCZReh1l7R1HVsh8CD4aAT1ou2nJaExRbf1V
HBdyixM1nHwaj7SIPbV/
=/R7m
-----END PGP SIGNATURE-----

--mcdTmAgB2xa1As2EQBnogKKWdb2dti4Pu--
