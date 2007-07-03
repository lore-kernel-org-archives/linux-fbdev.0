From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] pxafb: Add support for other palette formats
Date: Tue, 03 Jul 2007 18:21:38 +0100
Message-ID: <468A85A2.1070506@grupopie.com>
References: <200707031607.08511.hjk@linutronix.de>
	<18058.28725.106989.860166@ipc1.karo>
	<468A7359.5010305@grupopie.com>
	<200707031845.57256.hjk@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200707031845.57256.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Hans-J=FCrgen Koch wrote:
> Am Dienstag 03 Juli 2007 18:03 schrieb Paulo Marques:
>> [...]
>> Or maybe teach fbcon to use 18bpp modes?
>=20
> This would only make sense if this is a common format that other
> chips use, too.

I don't see this as a good reason not to implement 18bpp support in=20
fbcon. "Just PXA270 18bpp devices" can be a lot of devices out there.

Anyway, can fbcon work with 18bpp palette mode? If it does, then this=20
should be enough for most users of 18bpp pxafb users: have a console=20
with a palette mode and then switch to non-palette mode and run whatever=20
windowing system supports 18bpp.

I guess that even if it doesn't support 18bpp palette mode now, it=20
shouldn't be that hard to implement (nor should it cause that much bloat=20
to fbcon).

>>> BTW: PXA255 doesn't have an LCCR4 register.
>> If we make sure that we don't touch LCCR4 registers unless the platform =

>> driver asks for 18bpp we should be in the clear, no?
>>
>> However, the current patch does write to LCCR4 without checking this,=20
>> but this should be a no-op if there is no register there, AFAICS.
>=20
> Arrg, no, you can't do this. Even if it works on your current PXA255
> revision, writing to a nonexistent register is certainly not something
> we should do in a proper driver.

Yes, I wasn't proposing that this be kept (that would be waaay too=20
ugly), only pointing out that it shouldn't crash existing setups.

>> I'll try to handle it more correctly in my next patch, anyway.
>=20
> So will I. I'll update my patch.

Ok.

--=20
Paulo Marques - www.grupopie.com

"God is real, unless declared integer."

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
