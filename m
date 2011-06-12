From: Wanlong Gao <wanlong.gao@gmail.com>
Date: Sun, 12 Jun 2011 23:36:47 +0000
Subject: Re: [PATCH] efifb: Fix call to wrong unregister function
Message-Id: <1307921807.1934.0.camel@Tux>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307875953.1859.6.camel@Tux>
	 <BANLkTimXALxHwNMSODXujT4pT-C+m3rcaQ@mail.gmail.com>
In-Reply-To: <BANLkTimXALxHwNMSODXujT4pT-C+m3rcaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Peter Jones <pjones@redhat.com>

On =E6=97=A5, 2011-06-12 at 19:48 +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> 2011/6/12 wanlong.gao <wanlong.gao@gmail.com>:
> > <snip>
> >
> > Hi Maarten:
> > It registered efifb_device but try to unregistered efifb_driver,
> > so I think you should fix it like this?
> Ah yes, that seems to be the correct one, platform_driver_register was
> removed. Not 100% sure if acked by or signed-off-by is appropriate
> here.
I think signed-off-by is OK.
>=20
> Signed-off-by: Maarten Lankhorst <m.b.lankhorst@gmail.com>
>=20
> ~Maarten


