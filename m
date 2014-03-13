From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Mar 2014 08:23:10 +0000
Subject: Re: [PATCH] lcd: Provide dummy functions if CONFIG_LCD_CLASS_DEVICE is not set
Message-Id: <53216AEE.7070403@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MF10mrX3egJrdrsNSfOSWMDi37rDV59lm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394695879-22845-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1394695879-22845-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--MF10mrX3egJrdrsNSfOSWMDi37rDV59lm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/03/14 09:31, Alexander Shiyan wrote:
> Provide dummy functions for LCD register()/unregister() if
> CONFIG_LCD_CLASS_DEVICE is not set.

Hmm, why do you want to do that? If a driver needs the LCD class, it
should depend on or select it.

 Tomi



--MF10mrX3egJrdrsNSfOSWMDi37rDV59lm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIWruAAoJEPo9qoy8lh71F60QAJObxkTeWEKJu43hZ+zd2ho8
StS6iT1/aS3p6+MQUyFw8KAr0QEidbFi5/V7fok/dXeARIHT4ef6fcgFjb77+xdX
1+bj8tUkjlgMJ72UxF5W6IbLkER2pdaaWwGZsM3Q2zz9UiHuyRzbRWtyQiVSxaWy
AJG/wmAklZakY0HsZrlQLrC2JfDakOrwZZsqiHNdeotEv9fzrxgRpkUg2w3XGowd
B1UwWXfgLd+nFHowb1xwzn5CFgonas3rpTYJdOfVgJlwltcrxYQ+WXLhnX+TwcHY
2BsGEZKTFtB65E9joiLiAWKHUTA0s9v3GJ+4rKSatSlM9qdQYEsiAnGpVHXbmEBC
WFZgrhq7maeIb3OjMNuEosvkAzS/fbqcvdIZwy+AMXqPFtXYj8fpqoAflpgzmaki
or5V9q0xrCoC1bz1xT/EDXQ2OrUZUohgzvE14NrexOxJQx0eC+AUPABpXwlPsXWw
bOA2p7U5LbGLfwmRkzMbUkxmRzRxzOL8D/ruzuk0f2brdlWZYUT53VeWr1txfz70
EPFSmI2u31moBWEDBKfDJmXwYfivAosGwBE+rZSw5+sEzfdI/CMFYkl+ljiZVnCg
l7conULURTOQY4bryEVL2khVCvWaTgqVhh/Rgv3n5hH7PYZe6jGxiIPNHAPnVMH/
DZXFawczDIcR7BBpjoCY
=iYfr
-----END PGP SIGNATURE-----

--MF10mrX3egJrdrsNSfOSWMDi37rDV59lm--
