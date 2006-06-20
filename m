From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
Date: Tue, 20 Jun 2006 09:09:27 +0800
Message-ID: <44974AC7.4060708@gmail.com>
References: <44957026.2020405@gmail.com> <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965032AbWFTBJj@vger.kernel.org>
In-Reply-To: <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> I gave this patch a try and it seems to work. I say seems because I
> could not get the nvidiafb driver to set a usable mode after it was
> bound/unbound.

What do you mean by this?  You mean that you cannot restore vgacon?
If that's the case, then yes, that is perfectly understandable as
nvidiafb does not restore VGA to text mode.

> That's not a problem with the patch, the patch is not
> addressing that issue. I tried vbetool but it kept GPFing.

I use nvidiafb, and vbetool works for me. It probably depends on the
hardware. Some nvidia cards have faulty BIOS'es and this has been reported
several times, at least when using nvidia cards with vesafb-tng.

> This is a
> patch to help developers so maybe someone will fix nvidiafb to be more
> friendly.
> 
> Is there any way to lessen this problem?

The best and simplest way is to make nvidiafb behave like i810fb and rivafb
where they completely restore the VGA hardware to text mode. Hopefully
adding this is not as difficult as it sounds. (I'll see if I can work on
this within this week).

>  Would it help if fbcon worked
> with text modes,

fbcon does work with text mode. One developer converted viafb to work
this way.  Each driver must be converted separately though.
 
 or would it be better for each driver to set in a
> default mode that it understands when it gets control? The fbdev
> driver should not set a mode when it loads, but that doesn't mean
> fbcon can't set one when it is activated. Similarly VGAcon would set
> the mode (and load its fonts) when it regains control.

The problem with vgacon setting its own mode is that it does not know
anything about the hardware. So VGA text mode will need to rely on
a secondary program to set the mode (whether it's vbetool, another
fb driver, or X does not matter).

A standalone vga text driver is next to impossible to do.

> 
> It would also be interesting to make VGAcon a modular driver. You
> could build in fbcon and then work on VGAcon.
> 

This is very doable.  Add a module_init() for vgacon where it calls
take_over_console(). And make sure the system driver points to
dummycon.

Tony
