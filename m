From: Juergen Beisert <jbe@pengutronix.de>
Date: Mon, 22 Apr 2013 09:08:16 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: Fix colors display on lower color depth
Message-Id: <201304221108.17339.jbe@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Maxime,

Maxime Ripard wrote:
> The current code always registers as a 32 bits display, and uses the
> hardware to drop the MSB of each color to abjust to the interface width
> used by the panel.
>
> This results on 18 bits (and probably 16 bits display as well) in colors
> being displayed poorly, because the MSB are obviously the most important
> bits for each color definition.

But the "def_rgb666" bitfield description reports correctly to use bit 0..5 
for each colour component in this mode. Maybe your userland program has a bug 
and forgets to honor the bitfield description?

> The default controller behaviour when using an interface width smaller
> than the color depth is to drop the LSBs of each color, which makes more
> sense because you lose the least important part of the color definition.
>
> So, to fix the colors display, just get back to the default controller
> behaviour.

If you do this change, you also must adapt the "def_rgb666" bitfield 
description.
This structure currently reports the lower 6 bits to be used for this mode:
  blue -> 0..5 (skip 6/7)
  green -> 8..13 (skip 14/15)
  red -> 16..21 (skip 22/23).

> [...]

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
