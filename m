From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 23 Aug 2017 15:56:25 +0000
Subject: Re: [PATCH v3] fbcon: add fbcon=margin:<color> command line option
Message-Id: <1712803.5baJPN1EnC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501605357-30815-1-git-send-email-david@lechnology.com>
        <CGME20170818191930epcas3p16e6cac84fc9579a57208110214773221@epcas3p1.samsung.com>
        <0f404f59-f494-bd33-9a9a-f9b07a0dd7ee@lechnology.com>
In-Reply-To: <0f404f59-f494-bd33-9a9a-f9b07a0dd7ee@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi,

On Friday, August 18, 2017 02:19:28 PM David Lechner wrote:
> On 08/18/2017 01:21 PM, Geert Uytterhoeven wrote:
> > Hi David,
> > 
> > On Tue, Aug 1, 2017 at 6:35 PM, David Lechner <david@lechnology.com> wrote:
> >> This adds a new command line option to select the fbcon margin color.
> >>
> >> The motivation for this is screens where black does not blend into the
> >> physical surroundings of the screen. For example, using an LCD (not the
> >> backlit kind), white text on a black background is hard to read, so
> >> inverting the colors is preferred. However, when you do this, most of the
> >> screen is filled with white but the margins are still filled with black.
> >> This makes a big, black, backwards 'L' on the screen. By setting
> >> fbcon=margin:7, the margins will be filled with white and the LCD looks as
> >> expected.
> >>
> >> Signed-off-by: David Lechner <david@lechnology.com>
> > 
> >> --- a/Documentation/fb/fbcon.txt
> >> +++ b/Documentation/fb/fbcon.txt
> >> @@ -148,6 +148,13 @@ C. Boot options
> >>          Actually, the underlying fb driver is totally ignorant of console
> >>          rotation.
> >>
> >> +5. fbcon=margin:<color>
> >> +
> >> +       This option specifies the color of the margins. The margins are the
> >> +       leftover area at the right and the bottom of the screen that are not
> >> +       used by text. By default, this area will be black. The 'color' value
> >> +       is 0 to 7 where 0 is black and 7 is white.
> >> +
> > 
> > Given the standard console palette contains 16 colors, why limit this to
> > the first 8 colors, and not 0 to 15?
> 
> Good question. I think in some of my previous attempts there was a 0x7 
> mask involved somewhere and this is a carryover from that. But, after 
> having looked at this again, I don't see a reason for limiting to 7.

Could you please prepare the incremental patch raising the number of colors
possible to use?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

