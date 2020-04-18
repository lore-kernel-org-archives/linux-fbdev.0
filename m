From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 18 Apr 2020 10:18:38 +0000
Subject: Re: [PATCH 2/8] fbdev/ARM: pxa: avoid selecting CONFIG_FB
Message-Id: <873691p05d.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417155553.675905-3-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-3-arnd@arndb.de> (Arnd Bergmann's message
 of "Fri, 17 Apr 2020 17:55:47 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, airlied@linux.ie, Andrzej Hajda <a.hajda@samsung.com>, Laurent.pinchart@ideasonboard.com, marex@denx.de, thellstrom@vmware.com, dsd@laptop.org, Jason Gunthorpe <jgg@ziepe.ca>, masahiroy@kernel.org, Saeed Mahameed <saeedm@mellanox.com>, geert@linux-m68k.org, linux-graphics-maintainer@vmware.com, haojian.zhuang@gmail.com, Nicolas Pitre <nico@fluxnic.net>, dri-devel@lists.freedesktop.org, jfrederich@gmail.com, linux-renesas-soc@vger.kernel.org, kieran.bingham+renesas@ideasonboard.com, daniel@zonque.org

Arnd Bergmann <arnd@arndb.de> writes:

> In order to add more compile-time dependencies to CONFIG_FB, remove the
> last few instances of selecting it from platform code.
>
> This was originally written to allow a modular driver, but that never
> worked because vmlinux cannot call exported functions from a loadable
> module.
>
> Just change the #ifdef check to what it should have been and remove
> the 'select' statement.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Hi Arnd,

Ok, so if you remove the select FB_PXA, I think there will be a couple of
defconfigs which _might_ break, namely :
	corgi_defconfig
	h5000_defconfig
	hx4700_good_defconfig
	lubbock_defconfig
	mmp2_defconfig
	multi_v7_defconfig
	mvebu_v7_defconfig
	pcm027_defconfig
	pxa168_defconfig
	pxa910_defconfig
	xcep_defconfig
	zylonite_defconfig

Could you please have a look to see if they shouldn't have a CONFIG_FB_PXA=y and
CONFIG_FB=y now with this change ?

Cheers.

--
Robert
