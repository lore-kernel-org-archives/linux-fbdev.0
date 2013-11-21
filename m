From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Date: Thu, 21 Nov 2013 08:05:28 +0000
Subject: Re: [PATCHv9][ 3/3] ARM: dts: cpuimx35 Add touchscreen support.
Message-Id: <20131121090528.41af72bd@e6520eb>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
 <1383916659-9988-3-git-send-email-denis@eukrea.com>
 <20131121050922.GF18477@ns203013.ovh.net>
In-Reply-To: <20131121050922.GF18477@ns203013.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Le Thu, 21 Nov 2013 06:09:22 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a =E9crit :
> > +	tsc2007: tsc2007@48 {
> > +		compatible =3D "ti,tsc2007";
> > +		reg =3D <0x48>;
> > +		interrupt-parent =3D <&gpio3>;
> > +		interrupts =3D <0x2 0x8>;
> > +		gpios =3D <&gpio3 2 1>;
> as explain on the binding drop this gpios this is an IRQ not a gpio
>=20
> NACK
>=20
please read the tsc2007's code, in the patch there is :

+static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
+{
+       return !gpio_get_value(ts->gpio);
+}
+

http://www.mail-archive.com/linux-input@vger.kernel.org/msg06765.html

Eric
