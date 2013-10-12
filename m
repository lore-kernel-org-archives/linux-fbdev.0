From: Joe Perches <joe@perches.com>
Date: Sat, 12 Oct 2013 16:08:18 +0000
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
Message-Id: <1381594098.8864.9.camel@joe-AO722>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
         <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>
         <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
         <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
         <1379702587.2301.12.camel@joe-AO722>
         <alpine.LFD.2.03.1309201946430.8379@linux-mips.org>
         <alpine.LFD.2.03.1310121308310.10951@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1310121308310.10951@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>

On Sat, 2013-10-12 at 14:08 +0100, Maciej W. Rozycki wrote:
[]
> So I think I've got all the basic stuff covered now, including a change 
> similar to your proposal as well as a conversion to the driver model/new 
> TURBOchannel support infrastructure.  But what I remembered is actually 
> right, the issue is wiring hardware cursor support into fbcon.  The driver 
> uses its own display_switch structure with its own aafbcon_cursor handler 
> to use the twin onboard Bt431 chips for cursor generation (there's also 
> aafbcon_set_font that pokes at the Bt431s for cursor dimension changes).  
> I need to figure out what the best way will be to make the fbcon subsystem 
> support such an arrangement and that'll take me a little bit yet, so 
> please be patient.
> 
> Note that the board is weird enough to have a 1-bit (true monochrome) 
> graphics plane, however the Bt455 used by the MX graphics adapter for 
> screen image generation is a 4-bit grey-scale video RAMDAC (only the LSB 
> inputs of its pixel port are wired to the graphics plane) and the twin 
> Bt431s use the overlay plane to produce a 2-bit grey-scale cursor.  So we 
> do want to use the hardware cursor to be able to make it prominent among 
> the characters displayed throughout the screen and a software-generated 
> cursor cannot really substitute what hardware provides.

I hope you're enjoying tinkering with old toys.

Best of luck getting it going.


