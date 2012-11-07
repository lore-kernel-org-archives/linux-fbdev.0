From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 07 Nov 2012 16:56:55 +0000
Subject: Re: tty, vt: lockdep warnings
Message-Id: <20121107170132.1df293d6@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50899507.1040900@oracle.com>
	<20121026143754.50277bd8@pyramind.ukuu.org.uk>
	<CA+1xoqdEesjh1EZvR_r7Hn0GUc7741EDWn59qagngcxg4=9bjQ@mail.gmail.com>
	<20121105175937.26f31d2a@pyramind.ukuu.org.uk>
	<5097FEA9.2090603@oracle.com>
	<alpine.LNX.2.00.1211051106590.1709@eggly.anvils>
	<20121105201507.79fe47d7@pyramind.ukuu.org.uk>
	<alpine.LNX.2.00.1211051231070.21645@eggly.anvils>
	<20121106161100.216c6d79@pyramind.ukuu.org.uk>
	<20121106164214.GA18246@redhat.com>
	<20121106173845.4a50d661@pyramind.ukuu.org.uk>
	<509A665C.3030603@gmail.com>
	<20121107160232.18e83ee9@pyramind.ukuu.org.uk>
	<87625h9yoe.fsf@nemi.mork.no>
In-Reply-To: <87625h9yoe.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?B?Qmr4cm4=?= Mork <bjorn@mork.no>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Hugh Dickins <hughd@google.com>, Sasha Levin <sasha.levin@oracle.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, florianSchandinat@gmx.de

On Wed, 07 Nov 2012 17:15:45 +0100
Bj=F8rn Mork <bjorn@mork.no> wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>=20
> > +
> > +static int bind_con_driver(const struct consw *csw, int first, int las=
t,
> > +			   int deflt)
> > +{
> > +	int ret;
> > +=09
> > +	console_unlock();
>=20
> console_lock() maybe...

Thanks I'll fix that path in v3
