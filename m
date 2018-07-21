From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 21 Jul 2018 07:43:19 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <20180721074319.GA30454@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
In-Reply-To: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:01:52AM +0200, Adam Borowski wrote:
> Hi!
> Here's a patchset with two entangled improvements:
> 
> * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
>   allows disabling it, rendering such characters with a bright background
>   instead.
> * due to my error, 256-color mode uses a much darker palette for conversion,
>   resulting in behaving inconsistently with 24-bit mode.
> 
> The new code uses bright backgrounds when possible, enabled with \e[100m or
> \e[48;m.
> 
> Despite the whole idea following a VGA capability, this patchset doesn't
> change vgacon yet, just fbcon.  The reason being: ~80% of x86 users have an
> nVidia chip, which means nouveau or nvidia-proprietary.  Nouveau implies
> fbcon, nvidia-proprietary fails to properly restore text flags (as evidenced
> by 512 glyph mode turning to 256 on switch from graphics).  You don't care
> about the proprietary driver, but let's not break it pointlessly, and as
> both nVidia cards I own work only with nouveau, I don't want to touch what I
> can't test.
> 
> Thus, let's enable unblinking on fbcon for now.  We can flip that bit (in
> register 0x10) later.
> 
> This fixes the display of catimg and similar tools.

I've applied the first patch, as it was obvious :)

For the rest, can you make it a config option as Alan said?  And I
agree, we don't care about breaking nvidia systems, go ahead :)

thanks,

greg k-h
