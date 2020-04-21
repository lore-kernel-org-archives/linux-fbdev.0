From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Tue, 21 Apr 2020 13:25:09 +0000
Subject: Re: [PATCH 0/8] drm, fbdev: rework dependencies
Message-Id: <877dy9ynre.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417171453.GS3456981@phenom.ffwll.local>
 <20200417190854.GI26002@ziepe.ca> <87y2qq1smt.fsf@intel.com>
 <CAK8P3a0eSHg6Hx-FqpEF-N4LhZjv4o3PooK2eKw7KTntoKKckQ@mail.gmail.com>
 <20200421122726.GW3456981@phenom.ffwll.local> <87a735yp0f.fsf@intel.com>
 <CAMuHMdXRwRe5p65+YM69HDM4BhW+ZuHUju9B9083+=HdCotsqw@mail.gmail.com>
 <CAKMK7uE7y8TVbZ8ExpDEA2MuvhSDxKQ6y=eDXSbwgjUzsbm44A@mail.gmail.com>
In-Reply-To: <CAKMK7uE7y8TVbZ8ExpDEA2MuvhSDxKQ6y=eDXSbwgjUzsbm44A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marex@denx.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Saeed Mahameed <saeedm@mellanox.com>, Thomas Hellstrom <thellstrom@vmware.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jens Frederich <jfrederich@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>

On Tue, 21 Apr 2020, Daniel Vetter <daniel@ffwll.ch> wrote:
> To clarify what I was aiming for with my mail: I'm not worried about
> fbdev here, I'm just worried that this will come back, and we'll grow
> select somewhere else until it's become a big & totally horrible mess.
> I think a lot of the backlight selects have also grown because of
> this, so this isn't just a one-off I think.
>
> If Arnd is happy to play "Kconfig select" whack-a-mole ever once in a
> while (and deal with the intermediate compile horrors while everyone
> upgrades) I'm ok with this landing. Just not terribly happy if the
> underlying issue isn't fixed.

And I'll keep ignoring the IS_REACHABLE() patches that make i915 build
with a config that should not exist. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
