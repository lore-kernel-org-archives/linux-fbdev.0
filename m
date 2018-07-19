From: Adam Borowski <kilobyte@angband.pl>
Date: Thu, 19 Jul 2018 14:28:44 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <20180719142844.u3u4p7tywb54y4yd@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180719114749.00a7f979@alans-desktop>
In-Reply-To: <20180719114749.00a7f979@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:47:49AM +0100, Alan Cox wrote:
> On Wed, 18 Jul 2018 05:01:52 +0200
> Adam Borowski <kilobyte@angband.pl> wrote:
> 
> > Hi!
> > Here's a patchset with two entangled improvements:
> > 
> > * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
> >   allows disabling it, rendering such characters with a bright background
> >   instead.
> 
> That's a matter of taste so needs to configurable. Changing the default
> ought I think to be its own patch as it's a separate discussion to having
> the choice there and easy to make.

For vgacon yeah, you have a good point, as it can support either (and to be
exact, exactly one of the two as they share a hardware bit).  Only reason to
not have this configurable would be avoiding bloating the kernel with knobs
hardly anyone flips -- but you can already set minutiae like replacement
color for underline/italic/dim.  Thus you're right that if/when killing
blink on vgacon is implemented, it probably should be settable.

This is not an option on fbcon, though -- it can't blink (doable but I'm not
seeing anyone wanting to implement that) and already interprets that
attribute bit the way VGA would.  Thus, this patch merely makes vt behave a
way to match what the driver does.  This fixes some visual corruption in
certain user programs.

> For the palette why does it needs changing and exactly what standards
> document defines 'right', especially given we don't do ICC in console
> mode ? Have you tested the values used against multiple monitor types and
> cards with a light meter ?

You don't need a light meter for a difference of 53-out-of-256.  Most
desktop environments don't do ICC out of the box either, but there's an
assumption that whatever your monitor does, it gives the same result for the
same input (in the same lighting conditions).

That patch's purpose is:
* behave consistently between two APIs to set the same thing (\e[38;5;m vs
  \e[38;2;m) in a way that matches other terminals
* in case a future driver has better color handling we'd be different from
  other terminals

By the way, you can have ICC on console: "apt install vtgamma"
(https://github.com/kilobyte/vtgamma).

> BTW visibly breaking the Nvidia crud is also fine. They'll then actually
> bother to fix it and uually quite soon.

Yeah, but they haven't fixed 512-glyph yet (at least the last time I
looked), broken since day one.  In any case, this patchset doesn't support
vgacon yet, thus this is moot for now.  I picked the easy case (fbcon which
is always unblinking) over writing stuff to ports, we can update other
drivers later.

And vgacon has code that looks like it can do CGA and MDA (redundant with
mdacon?), either of which I haven't used in... quite a while.  Might be
tricky getting access to such hardware to test...


Meow!
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
