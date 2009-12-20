From: Dave Hylands <dhylands@gmail.com>
Date: Sun, 20 Dec 2009 02:07:24 +0000
Subject: Re: drivers/gpu/drm/radeon/radeon_test.c:45: undefined reference to
Message-Id: <c32efac40912191807o7f7b7c2dw2259721e6c0635f6@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.01.0912181147200.9874@filesrv1.baby-dragons.com>
	 <c32efac40912190113i5292a395tcc257c16a4870f3b@mail.gmail.com>
	 <alpine.LNX.2.01.0912191405460.12202@filesrv1.baby-dragons.com>
In-Reply-To: <alpine.LNX.2.01.0912191405460.12202@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, Linux Kernel Maillist <linux-kernel@vger.kernel.org>

Hi Jim,

> =A0 =A0 =A0 =A0Thank you , =A0For replying . =A0Now I being a kernel leve=
l nothing ,
> =A0How does this help me get past the 'ld' time undefined reference ? =A0=
So we
> can have a kernel build complete (hopefully) successfully .
>
> =A0 =A0 =A0 =A0I've another ? as well how is it that the drm/radeon_test.=
c is using
> (well at least referencing) a non-kernel symbol ? =A0That alone is rather
> interesting .
>
> =A0 =A0 =A0 =A0But all I had to do is Disable DRM in the kernel . =A0Sinc=
e this system
> is a remote device without a real need for DRI/DRM support that should cu=
re
> my problem . =A0But someone else is going to need that support & I am sure
> they'll hit that same bug .

I'm not familiar with the source code in question, but presumably,
someone will need to change the source to remove the 64-bit divide and
do it using the do_div macro or something equivalent.

--=20
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
