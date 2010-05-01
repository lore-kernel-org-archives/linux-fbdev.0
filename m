From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 01 May 2010 12:08:21 +0000
Subject: Re: [PATCH 2/2] sh: make interrupt resource optional in SH
Message-Id: <v2laec7e5c31005010508ke98e31f4pe8d61600035fb12f@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1004301805371.4055@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004301805371.4055@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, May 1, 2010 at 1:07 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> The SH LCDC driver can also function without the IRQ, in which case the
> FBIO_WAITFORVSYNC ioctl() cannot be supported. Enable such a mode.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Why? Doesn't the LCDC hardware block always come with an IRQ line?

/ magnus
