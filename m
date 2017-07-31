From: Adam Borowski <kilobyte@angband.pl>
Date: Mon, 31 Jul 2017 21:11:23 +0000
Subject: Re: [PATCH] fbcon: Use background color for margins
Message-Id: <20170731211123.trcyj7clxkmkf6df@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501273590-3237-1-git-send-email-david@lechnology.com>
 <20170730094726.GB18381@amd>
 <2cafbde9-6b31-9586-e3eb-0b80355eab3c@lechnology.com>
 <20170730215108.GA806@amd>
 <bffc57cf-bd63-ec3c-4b0b-986f11751bf3@lechnology.com>
In-Reply-To: <bffc57cf-bd63-ec3c-4b0b-986f11751bf3@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Lechner <david@lechnology.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

On Mon, Jul 31, 2017 at 12:25:28PM -0500, David Lechner wrote:
> On 07/30/2017 04:51 PM, Pavel Machek wrote:
> > > > > Screens that don't have a black border around the active area will have
> > > > > ugly black bars for the margin when the text background color is not black.
> > > > > This is especially noticeable on an LCD screen (not the backlit kind) when
> > > > > the terminal colors are inverted.

Also when you have multiple monitors of different resolutions (VT does
mirror them which is quite pointless, but hey, VT is meant for rescue tasks
so for fancy features you'd better use X).

I see this on nouveau which your patch doesn't handle, but we can extend it
to nouveau later.

> Ah. I see what you mean now. The margin will be whatever is set for the
> vc_video_erase_char in the kernel, which can be changed by userspace. I
> tried midnight commander and sure enough, I still have the black margins
> when I invert the screen (`setterm -inverse on`). Interestingly, after
> allowing the console to blank after a timeout, the console was blanked with
> white, then after pressing a key to unblank, the margins were also white.

"setterm -inverse on" looks ugly.

I've just added reverse to my vtgamma (https://github.com/kilobyte/vtgamma),
it uses a different method (setting the palette instead of \e[?5h) which on
VT looks a lot nicer.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ What Would Jesus Do, MUD/MMORPG edition:
⣾⠁⢰⠒⠀⣿⡁ • multiplay with an admin char to benefit your mortal
⢿⡄⠘⠷⠚⠋⠀ • abuse item cloning bugs (the five fishes + two breads affair)
⠈⠳⣄⠀⠀⠀⠀ • use glitches to walk on water
