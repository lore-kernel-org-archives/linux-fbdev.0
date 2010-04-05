From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Mon, 05 Apr 2010 22:35:38 +0000
Subject: Re: [PATCH v3 1/1] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <8739z9ttmt.fsf@deeprootsystems.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <A24693684029E5489D1D202277BE89445316FACC@dlee02.ent.ti.com>
In-Reply-To: <A24693684029E5489D1D202277BE89445316FACC@dlee02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

"Ambrose, Martin" <martin@ti.com> writes:

> This work includes the following:
>  . Implement handler for FBIO_WAITFORVSYNC ioctl.
>
>  . Allocate the data and palette buffers separately.
>    A consequence of this is that the palette and data loading is now
>    done in different phases. And that the LCD must be disabled
>    temporarily after the palette is loaded but this will only happen
>    once after init and each time the palette is changed. I think this
>    is OK.
>
>  . Allocate two (ping and pong) framebuffers from memory.
>
>  . Add pan_display handler which toggles the LCDC DMA registers between
>    the ping and pong buffers.
>
> Signed-off-by: Martin Ambrose <martin@ti.com>

Your mailer (probably outlook) is converting all tabs to spaces
resulting in a patch that wont apply.

I recommend using git-format-patch + git-send-email directly to your
SMTP server to avoid outlook mangling.

Kevin
