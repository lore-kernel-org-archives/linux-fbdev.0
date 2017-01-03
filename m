From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 03 Jan 2017 16:57:23 +0000
Subject: Re: [PATCH] fbcon: Fix vc attr at deinit
Message-Id: <s5hy3ysqdxo.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170103150322.10350-1-tiwai@suse.de>
        <20170103164905.GA24990@kroah.com>
In-Reply-To: <20170103164905.GA24990@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 03 Jan 2017 17:49:05 +0100,
Greg Kroah-Hartman wrote:
> 
> On Tue, Jan 03, 2017 at 04:03:22PM +0100, Takashi Iwai wrote:
> > fbcon can deal with vc_hi_font_mask (the upper 256 chars) and adjust
> > the vc attrs dynamically when vc_hi_font_mask is changed at
> > fbcon_init().  When the vc_hi_font_mask is set, it remaps the attrs in
> > the existing console buffer with one bit shift up (for 9 bits), while
> > it remaps with one bit shift down (for 8 bits) when the value is
> > cleared.  It works fine as long as the font gets updated after fbcon
> > was initialized.
> > 
> > However, we hit a bizarre problem when the console is switched to
> > another fb driver (typically from vesafb or efifb to drmfb).  At
> > switching to the new fb driver, we temporarily rebind the console to
> > the dummy console, then rebind to the new driver.  During the
> > switching, we leave the modified attrs as is.  Thus, the new fbcon
> > takes over the old buffer as if it were to contain 8 bits chars
> > (although the attrs are still shifted for 9 bits), and effectively
> > this results in the yellow color texts instead of the original white
> > color, as found in the bugzilla entry below.
> > 
> > An easy fix for this is to re-adjust the attrs before leaving the
> > fbcon at con_deinit callback.  Since the code to adjust the attrs is
> > already present in the current fbcon code, in this patch, we simply
> > factor out the relevant code, and call it from fbcon_deinit().
> > 
> > Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id00619
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/video/console/fbcon.c | 67 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 40 insertions(+), 27 deletions(-)
> 
> So this is an old bug?  Should it go to stable kernels?

Yes, the bug seems to be very old, but only recently revealed
accidentally (likely) because of the changes in boot sequences with
systemd & co.

The problem itself is fairly harmless: it just appears on VT1 with a
weird color after switching to the different fb until you scroll the
full screen out.  So I didn't care about stable.  But feel free to put
to stable if you think it's safe.

> And am I the fbcon maintainer now?

Heh, blame scripts/get_maintainer.pl (or I'm still in a new year
frolic).  Maybe I should have sent to Andrew instead :)


thanks,

Takashi
