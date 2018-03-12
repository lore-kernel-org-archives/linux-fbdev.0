From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 15:20:22 +0000
Subject: Re: [PATCH v5] Fix loading of module radeonfb on PowerMac
Message-Id: <2379985.mFGi9AtZPr@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180213180332epcas2p30b385519194cf8c820610768b93abed2@epcas2p3.samsung.com>
 <20180213180316.11934-1-malat@debian.org>
In-Reply-To: <20180213180316.11934-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday, February 13, 2018 07:03:16 PM Mathieu Malaterre wrote:
> When the linux kernel is build with (typical kernel ship with Debian
> installer):
> 
> CONFIG_FB=y
> CONFIG_FB_OF=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_FB_RADEON=m
> 
> The offb driver takes precedence over module radeonfb. It is then
> impossible to load the module, error reported is:
> 
> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
> 
> This patch reproduce the behavior of the module radeon, so as to make it
> possible to load radeonfb when offb is first loaded, see
> commit a56f7428d753 ("drm/radeon: Add early unregister of firmware fb's").
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Link: https://bugs.debian.org/826629#57
> Link: https://bugzilla.kernel.org/show_bug.cgi?id9741
> Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

