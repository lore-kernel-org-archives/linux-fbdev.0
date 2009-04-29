From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Intel KMS + fbcon + Mplayer
Date: Wed, 29 Apr 2009 13:21:47 +0200
Message-ID: <10f740e80904290421w3e914ebew94eb6081cbea1cdc@mail.gmail.com>
References: <7D4BD025A2554467AD77428C455E1FE0@avitech.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757518AbZD2LWD@vger.kernel.org>
In-Reply-To: <7D4BD025A2554467AD77428C455E1FE0@avitech.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Peter Hanzel <hanzelpeter@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

On Wed, Apr 29, 2009 at 12:04, Peter Hanzel <hanzelpeter@gmail.com> wrote:
> I have tried Intel KMS in kernel 2.6.91.1 with fbcon. I am using only
> framebuffer console.
> Most fb apps works, but I have problem with mplayer.
> The init works but the video is badly displayed.
> I have investigated the problem and found, that for my laptop mode
> 1280x800-32.
>
> The ioctl on /dev/fb0 FBIOGET_VSCREENINFO returns.
> var.bits_per_pixel=32
> var.transp.length = 0.
>
> So the mplayer thinks we are in 24 bit mode (maybe this is bug in mplayer,
> because bits_per_pixel is 32).
>
> But next I have checked it with kernel vesafb and for same mode
> (1280x800-32, vga=0x362 )
> The fb ioctl returns
> var.bits_per_pixel=32
> var.transp.length = 8.
>
> So is this intentionally made so. Because I think this mode use only red,
> green,blue and no transp. But for one pixel you must write 4 bytes. (so
> transp is not used).

That must be a bug in mplayer, as var.bits_per_pixel = 32. If there's
no transparency, it's
correct to hav var.transp.length = 0 . The additional 8 bits may be unused.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
