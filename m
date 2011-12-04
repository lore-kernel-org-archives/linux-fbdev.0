From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Sun, 04 Dec 2011 02:35:59 +0000
Subject: Re: [PATCH v3.1] [resend] Resurrect Intel740 driver: i740fb
Message-Id: <CAOZdJXWp24Kday8vt6vXsr6bYbVyLmMqrFfY_n7kboKpj0a8Ug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201111182154.45139.linux@rainbow-software.org>
	<4EDA9882.208@gmx.de>
In-Reply-To: <4EDA9882.208@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Ondrej Zary <linux@rainbow-software.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Kernel development list <linux-kernel@vger.kernel.org>

On Sat, Dec 3, 2011 at 3:45 PM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
>
>> + =A0 =A0 return !!(i740inreg(par, XRX, REG_DDC_STATE) & DDC_SCL);
>
> Why "!!"?

This is a trick that guarantees that the return value is either 0 or
1.  Without the !!, the return value will be either 0 or DDC_SCL.

--=20
Timur Tabi
Linux kernel developer at Freescale
