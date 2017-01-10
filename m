From: Adam Borowski <kilobyte@angband.pl>
Date: Tue, 10 Jan 2017 22:58:46 +0000
Subject: Re: [PATCH v9 4/4] console: Make persistent scrollback a boot parameter
Message-Id: <20170110225846.gd2pqczplnkl74d3@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4640722.jsFVORW8WM@amdc3058>
 <20170110212838.16175-5-manuel.schoelling@gmx.de>
In-Reply-To: <20170110212838.16175-5-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Jan 10, 2017 at 10:28:38PM +0100, Manuel Sch=F6lling wrote:
> The impact of the persistent scrollback feature on the code size is
> rather small, so the config option is removed. The feature stays
> disabled by default and can be enabled by using the boot command line
> parameter 'vgacon.scrollback_persistent=3D1' or by setting
> VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=3Dy.
>=20
> Signed-off-by: Manuel Sch=F6lling <manuel.schoelling@gmx.de>
> Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> +module_param_named(scrollback_persistent, scrollback_persistent, bool, 0=
000);
> +MODULE_PARM_DESC(scrollback_persistent, "Enable persistent scrollback fo=
r all vga consoles");

A command-line knob settable by the end-user is something more persistent
than a config option.  As you're going to extend this code beyond vgacon in
the near future, perhaps it'd be better to have a shared setting for all
console drivers?


Meow!
--=20
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=3Dzx-spectrum --build=3Dpdp11
