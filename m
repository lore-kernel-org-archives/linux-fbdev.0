From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 08 Feb 2017 15:15:40 +0000
Subject: Re: [PATCH v2 0/5] fbdev/ssd1307fb: Some changes and improvement
Message-Id: <2411010.1mLqlC3XW4@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170113103601epcas4p38f03c4eb4147ff5a08e93af2cda635ba@epcas4p3.samsung.com>
 <cover.1484303628.git.jsarha@ti.com>
In-Reply-To: <cover.1484303628.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org


Hi,

On Friday, January 13, 2017 12:35:44 PM Jyri Sarha wrote:
> Changes since first version:
> - Cherry-picked "fbdev/ssd1307fb: add support to enable VBAT" again
>   beacuse of weird mixup in the first version
> - Also tested the code on top of v4.10-rc3 with am335x-icev2 evm
> 
> We needed these changes for couple of our evm. Some of these patches
> have been on mainline list before, but after that forgotten. Now we
> are forward porting these on for out internal release, so this is a
> good time to get them to mainline too.
> 
> Everything else is quite straight forward, but removing the
> reset-active-low dts property is a questionable at least in
> theory. However, in practice if anyone was using the property in their
> device-tree blobs, they have never been able to get desired effect
> with mainline kernel.
> 
> Jyri Sarha (3):
>   fbdev: ssd1307fb: Start to use gpiod API for reset gpio
>   fbdev: ssd1307fb: Remove reset-active-low from the DT binding document
>   fbdev: ssd1307fb: Make reset gpio devicetree property optional
> 
> Tomi Valkeinen (2):
>   fbdev/ssd1307fb: add support to enable VBAT
>   fbdev/ssd1307fb: clear screen in probe
> 
>  .../devicetree/bindings/display/ssd1307fb.txt      |  5 +-
>  drivers/video/fbdev/ssd1307fb.c                    | 55 ++++++++++++++--------
>  2 files changed, 38 insertions(+), 22 deletions(-)

Patchset queued for 4.11, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

