From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 11 Jan 2017 18:48:43 +0000
Subject: Re: [PATCH] fbcon: Fix vc attr at deinit
Message-Id: <s5ha8axl9f8.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170103150322.10350-1-tiwai@suse.de>
        <s5h1swazzl9.wl-tiwai@suse.de>
        <1500556.Az9hZml9Y8@amdc3058>
        <CGME20170111145050epcas1p4b2e6b4ee2e813bbbb1dc10864bdc071c@epcas1p4.samsung.com>
        <1542584.CJ0JZaAd8m@amdc3058>
In-Reply-To: <1542584.CJ0JZaAd8m@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Wed, 11 Jan 2017 15:50:43 +0100,
Bartlomiej Zolnierkiewicz wrote:
> 
> 
> Hi,
> 
> On Tuesday, January 10, 2017 05:09:43 PM Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Tuesday, January 10, 2017 04:47:30 PM Takashi Iwai wrote:
> > > On Thu, 05 Jan 2017 13:26:07 +0100,
> > > Tomi Valkeinen wrote:
> > > > 
> > > > On 04/01/17 15:50, Takashi Iwai wrote:
> > > > > On Tue, 03 Jan 2017 16:03:22 +0100,
> > > > > Takashi Iwai wrote:
> > > > >>
> > > > >> fbcon can deal with vc_hi_font_mask (the upper 256 chars) and adjust
> > > > >> the vc attrs dynamically when vc_hi_font_mask is changed at
> > > > >> fbcon_init().  When the vc_hi_font_mask is set, it remaps the attrs in
> > > > >> the existing console buffer with one bit shift up (for 9 bits), while
> > > > >> it remaps with one bit shift down (for 8 bits) when the value is
> > > > >> cleared.  It works fine as long as the font gets updated after fbcon
> > > > >> was initialized.
> > > > >>
> > > > >> However, we hit a bizarre problem when the console is switched to
> > > > >> another fb driver (typically from vesafb or efifb to drmfb).  At
> > > > >> switching to the new fb driver, we temporarily rebind the console to
> > > > >> the dummy console, then rebind to the new driver.  During the
> > > > >> switching, we leave the modified attrs as is.  Thus, the new fbcon
> > > > >> takes over the old buffer as if it were to contain 8 bits chars
> > > > >> (although the attrs are still shifted for 9 bits), and effectively
> > > > >> this results in the yellow color texts instead of the original white
> > > > >> color, as found in the bugzilla entry below.
> > > > >>
> > > > >> An easy fix for this is to re-adjust the attrs before leaving the
> > > > >> fbcon at con_deinit callback.  Since the code to adjust the attrs is
> > > > >> already present in the current fbcon code, in this patch, we simply
> > > > >> factor out the relevant code, and call it from fbcon_deinit().
> > > > >>
> > > > >> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id00619
> > > > >> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > 
> > > > > Actually not only checkpatch but also I can't find the proper
> > > > > maintainer for this...
> > > > > 
> > > > > Tomi, could you check and take if it's OK?
> > > > > 
> > > > > Ideally, this kind of stuff should have been in rather vt side, I
> > > > > suppose.  But since the code is already present in fbcon, it's easier
> > > > > to reuse it as a fix for now.
> > > > 
> > > > I'm not fbdev maintainer anymore. Added Bartlomiej (and Andrew).
> > > 
> > > Bartlomiej (or Andrew), could you check the patch?  In case you missed
> > > it, I attach it below again.
> > 
> > Thanks, it is on TODO (should be processed till the end of the week).
> 
> Patch queued for 4.11, thanks.

Great, thanks!


Takashi
