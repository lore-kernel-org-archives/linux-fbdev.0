From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Feb 2013 13:22:14 +0000
Subject: Re: [PATCH 0/9] System Framebuffer Bus (sysfb)
Message-Id: <CAMuHMdUfyOe_ySL0gB_FQLjz2ACQhk6cPWi_ty5pMb6=zZduSA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1361123951-587-1-git-send-email-dh.herrmann@gmail.com>
	<CAPM=9txQtJ6FLFTEFr_Wi6RK=W9y3gKYxV_+zPCo6kLi4nM8eA@mail.gmail.com>
	<CANq1E4TTB-Lp+eVRPpzOMnS7XNbzHJRTicwCcwXw3AUs11XFMw@mail.gmail.com>
	<CAPM=9tzDXLqUG3c6VsMjaJ_1997h7f+_3kB0C0N2imuQcXsD6Q@mail.gmail.com>
	<CANq1E4QoutxRkuBj3p2vaw2U4-GN0Gz4ueopKkDavX_ZmgMC-w@mail.gmail.com>
In-Reply-To: <CANq1E4QoutxRkuBj3p2vaw2U4-GN0Gz4ueopKkDavX_ZmgMC-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org

On Thu, Feb 28, 2013 at 1:20 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> We currently have different drivers that can make use of "system
> framebuffers" (as I call them for now):
>  - vgacon
>  - fbdev
>  - DRM
> (- vgalog) (similar to fblog/drmlog but using vga/VBE)

offb

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
