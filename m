From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 27 Dec 2010 02:02:58 +0000
Subject: Re: [PATCH 3/5] fbdev: sh_mobile_lcdc: increase maximum framebuffer
Message-Id: <AANLkTi=zRpLDg3Oqv+gq8sMAiidVoDojigQb9rn826aC@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1011041200050.13123@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011041200050.13123@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Sun, Dec 26, 2010 at 6:44 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Paul, apart from increasing the fb size to 1080p, this patch also fixes a
> regression, which leads to unusable by applications framebuffer on some
> platforms, including migor. This happens, when one of parameters lies
> outside of limits, being checked in sh_mobile_check_var(). On migor it is
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.left_margin =3D 0,
>
> Then the fb-console is working, but, e.g., mplayer is not. So, we need
> this patch in 2.6.37 too, please. Unfortunately, it also introduces a
> wrong format printk format, which a later patch of yours fixes, so, you
> might want to push that patch too, although, that's not that important.

It's great that you work on fixing this issue, thank you.

In the long run I wonder if it's best to try to get rid of the
MAX_XRES/MAX_YRES stuff from the LCDC driver. I understand that you
need to allocate the frame buffer memory early on, but it would be
much better if the maximum values could be kept in platform data. The
maximum resolution varies with CPU type, so a one-for-all modification
like this may break older platforms.

Thanks,

/ magnus
