From: Jeremy Lacomis <j.lacomis@gmail.com>
Date: Mon, 27 Nov 2017 14:37:27 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: Fix coding style in ddk750_sii164.h
Message-Id: <20171127143727.GA4270@gs17931.sp.cs.cmu.edu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125182636.15245-1-j.lacomis@gmail.com>
 <20171127094622.phmx4ej2fljcytce@mwanda>
 <CAMuHMdWvFY72w9Shs3EzrHx-qfm5Z3eLdOPwaL6x1U-V_oA9Hw@mail.gmail.com>
In-Reply-To: <CAMuHMdWvFY72w9Shs3EzrHx-qfm5Z3eLdOPwaL6x1U-V_oA9Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, driverdevel <devel@driverdev.osuosl.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Nov 27, 2017 at 11:45:00AM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 27, 2017 at 10:46 AM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> > On Sat, Nov 25, 2017 at 01:26:35PM -0500, Jeremy Lacomis wrote:
> >> This patch to ddk750_sii164.h fixes line length warnings found by the
> >> checkpatch.pl script and reformats comments uniformly.
> >>
> >> Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
> >> ---
> >>  drivers/staging/sm750fb/ddk750_sii164.h | 57 +++++++++++++--------------------
> >>  1 file changed, 22 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
> >> index 2e9a88cd6af3..393a3c5be3ae 100644
> >> --- a/drivers/staging/sm750fb/ddk750_sii164.h
> >> +++ b/drivers/staging/sm750fb/ddk750_sii164.h
> >> @@ -4,15 +4,20 @@
> >>
> >>  #define USE_DVICHIP
> >>
> >> -/* Hot Plug detection mode structure */
> >> +/*
> >> + * Hot Plug detection mode structure:
> >> + *      Disable Hot Plug output bit (always high).
> >> + *      Use Monitor Detect Interrupt bit.
> >> + *      Use Receiver Sense detect bit.
> >> + *      Use Hot Plug detect bit.
> >> + */
> >>  enum sii164_hot_plug_mode {
> >> -     SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
> >> -     SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
> >> -     SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
> >> -     SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
> >> +     SII164_HOTPLUG_DISABLE = 0,
> >> +     SII164_HOTPLUG_USE_MDI,
> >> +     SII164_HOTPLUG_USE_RSEN,
> >> +     SII164_HOTPLUG_USE_HTPLG
> >>  };
> >
> > I feel like this makes it less readable.  The original was better.
> 
> And more error prone.

Thanks for taking the time to review my patch, I'm just getting into kernel
development and am trying to do as little disservice as possible while learning
the process.

For something like this, would using the kernel-doc format make more sense, or
should the original inline comments be kept? I found the original difficult to
read because my terminal was just small enough that this didn't fit.

Thanks,
- Jeremy
