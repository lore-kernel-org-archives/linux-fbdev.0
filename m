From: Adam Borowski <kilobyte@angband.pl>
Date: Sat, 21 Jul 2018 21:38:43 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <20180721213843.wkculy5cdrrbmuij@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180721074319.GA30454@kroah.com>
In-Reply-To: <20180721074319.GA30454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 09:43:19AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 18, 2018 at 05:01:52AM +0200, Adam Borowski wrote:
> > Here's a patchset with two entangled improvements:
> > 
> > * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
> >   allows disabling it, rendering such characters with a bright background
> >   instead.
> > * due to my error, 256-color mode uses a much darker palette for conversion,
> >   resulting in behaving inconsistently with 24-bit mode.
> > 
> > The new code uses bright backgrounds when possible, enabled with \e[100m or
> > \e[48;m.
> > 
> > Despite the whole idea following a VGA capability, this patchset doesn't
> > change vgacon yet, just fbcon.  [Not breaking nvidia-proprietary.]
> > 
> > Thus, let's enable unblinking on fbcon for now.  We can flip that bit (in
> > register 0x10) later.
> > 
> > This fixes the display of catimg and similar tools.
> 
> I've applied the first patch, as it was obvious :)
> 
> For the rest, can you make it a config option as Alan said?  And I
> agree, we don't care about breaking nvidia systems, go ahead :)

The only thing such an option would be able to set is disabling blinking on
vgacon, which is not yet implemented.  fbcon never blinks, and the only case
it can't display bright background is 1-bit black&white.

I probably should change the line in fbcon:
+       vc->vc_unblinking = vc->vc_can_do_color;
to always use 1, but it doesn't matter either way.  Only difference would be
matching the variable name ("unblinking" vs "shows_bright_bg").

Console drivers can interpret that bit of attribute as:
* blinking (vc_unblinking = 0)
* bright background (vc_unblinking = 1)
* neither (result is ignored down the pipeline)

The matrix is:
                color                                     b&w
-------+-------------------------------------------+--------------
fb            bright bg                                 neither
mda              N/A                                     blink
newport      ?bright bg?                                 ?N/A?
sti           ?neither?                                    ?
vga      CGA/VGA: hardware switch (write to port)      MDA: blink
sisusb            ?                                        ?

Technically, every console can be made to blink by drawing/clearing affected
characters a few times per second, but that'd be quite a waste of coding
time and kernel size.  There's a reason browsers dropped support for <blink>
and text-decoration:blink.

This patchset doesn't drop blink in any case that was supported before,
though.  I did the easy part used by most people first (fbcon), so it can be
reviewed/merged.  Doing the hard part is quite pointless if this is NAKed
(but obviously doesn't require actual merging).

But perhaps by "option" you mean letting the user drop blink with no
replacement, which might also be a good idea if configurable?


Meow!
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
