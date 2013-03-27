From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Mar 2013 12:05:24 +0000
Subject: Re: [PATCH] powerpc: remove PReP
Message-Id: <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363864206.1390.117.camel@x61.thuisdomein>
 <20130322042159.GC26908@concordia>
 <1364381223.1345.18.camel@x61.thuisdomein>
In-Reply-To: <1364381223.1345.18.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>, Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org, Adam Belay <abelay@mit.edu>

On Wed, Mar 27, 2013 at 11:47 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> 3) I removed two files in documentation that are almost entirely PReP
> specific. The remaining lines looked uninteresting.

> --- a/Documentation/powerpc/sound.txt
> +++ /dev/null

> -2. IBM CHRP
> -
> -  I have only tested this on the 43P-150.  Build the kernel with the cs4232
> -  set as a module and load the module with irq=9 dma=1 dma2=2 io=0x550

This section is CHRP-specific. The cs4232 driver also worked on the
CHRP LongTrail.
But I don't remember if the parameter values above also applied to LongTrail.
I do remember it didn't work without specifing the right parameters, so you
probably want to keep this section.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
