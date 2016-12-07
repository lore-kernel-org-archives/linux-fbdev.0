From: Ley Foon Tan <ley.foon.tan@intel.com>
Date: Wed, 07 Dec 2016 05:13:10 +0000
Subject: Re: [PATCH] video: vgacon: disable vgacon on nios2
Message-Id: <1481087590.2638.2.camel@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161128124850.14383-1-tklauser@distanz.ch>
In-Reply-To: <20161128124850.14383-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sel, 2016-12-06 at 08:04 +0100, Tobias Klauser wrote:
> On 2016-12-06 at 04:29:12 +0100, Ley Foon Tan <ley.foon.tan@intel.com
> > wrote:
> > 
> > On Isn, 2016-11-28 at 13:48 +0100, Tobias Klauser wrote:
> > > 
> > > The allyesconfig/allmodconfig build currently fails on nios2 with
> > > the
> > > following linker error:
> > > 
> > > drivers/built-in.o: In function `vgacon_switch':
> > > vgacon.c:(.text+0x34750): undefined reference to `screen_info'
> > > vgacon.c:(.text+0x34758): undefined reference to `screen_info'
> > > drivers/built-in.o: In function `vgacon_resize':
> > > vgacon.c:(.text+0x349b4): undefined reference to `screen_info'
> > > vgacon.c:(.text+0x349b8): undefined reference to `screen_info'
> > > drivers/built-in.o: In function `vgacon_save_screen':
> > > vgacon.c:(.text+0x34ae8): undefined reference to `screen_info'
> > > drivers/built-in.o:vgacon.c:(.text+0x34aec): more undefined
> > > references to `screen_info' follow
> > > 
> > > Since the nios2 architecture doesn't define the screen_info
> > > symbol.
> > > 
> > > Fix it by disabling VGA console for nios2.
> > > 
> > > Cc: Ley Foon Tan <lftan@altera.com>
> > > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > Sudip sent this patch in early November before to add screen_info
> > in
> > nios2. However, I don't have hardware to test the settings used in
> > this
> > patch is working or not. We only need either one of these 2
> > patches. Do
> > you have any comment?
> > https://patchwork.kernel.org/patch/9420315/
> I don't have any hardware to test this on either, so I thought this
> was
> the safest fix.
> 
> If we're going to define screen_info, I'd suggest to do it in a
> similar
> manner as e.g. tile, sh, score, ia64, hexagon, cris, c6x and
> unicore32.
> They all just define an struct screen_info screen_info; without any
> of
> the members set explicitely. I think they should only be set, once
> they
> actually have been tested on hardware.
> 
> In any case, I'd propose to apply either one of the solutions for 4.9
> in
> order to fix the build breakage.
Okay, I will follow other architectures approach. Just add the
declaration for screen_info:

struct screen_info screen_info;

Thanks.
Ley Foon

