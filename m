From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 03 May 2020 20:11:47 +0000
Subject: Re: [PATCH] video/fbdev/matroxfb: Remove dead code
Message-Id: <CAFqt6zb94Wj_dkSb2NJ6TOJczxJErvFRB7OSzZieOTot-EL+qw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com>
 <20200503174040.GA27362@ravnborg.org>
In-Reply-To: <20200503174040.GA27362@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Thomas Gleixner <tglx@linutronix.de>

On Sun, May 3, 2020 at 11:10 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Souptick
>
> On Sat, May 02, 2020 at 03:28:11AM +0530, Souptick Joarder wrote:
> > These are dead code since 3.15. If there is no plan to use it further
> > it can be removed forever.
> Could you explain why you conclude this is dead code sine 3.15 -
> and maybe point to the commit that made it dead.
> I failed to look it up.
> And I would assume I did not have to look it up, but that you have
> provided enough background to evaluate the patch.

I trace this back till linux version 2.3.9 & 2.4.0 in
drivers/video/matrox/matroxfb_DAC1064.c
(3.15 was the version when this is moved to
drivers/video/fbdev/matrox/matroxfb_DAC1064.c)
and I think this driver support was added mostly in 2.4.0, but as it
is pre git era, unable to provide
commit id. Code commented with *#if 0* in discussion existed since 2.4.0.

First two *#if 0* can be removed as these are just declaration of
variables, never used.

-#if 0
-static int def50 = 0;  /* reg50, & 0x0F, & 0x3000 (only 0x0000,
0x1000, 0x2000 (0x3000 disallowed and treated as 0) */
-#endif

 static void MGAG100_progPixClock(const struct matrox_fb_info *minfo, int flags,
                                 int m, int n, int p)
@@ -843,9 +840,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
        struct matrox_hw_state *hw = &minfo->hw;

         u_int32_t reg50;
-#if 0
-       u_int32_t q;
-#endif

In my opinion 3rd *#if 0 is not for documentation purpose and can be
removed as well.

-#if 0
-               if (mga_readb(minfo->video.vbase, 0x0000) != 0xAA) {
-                       hw->MXoptionReg &= ~0x1000;
-               }
-#endif

There is a 4th *#if 0 in this file. But it wasn't removed as there are
some documentation
comment exists for it.

#if 0
/* HELP! If we boot without DFP connected to DVI, we can
  poweroff TMDS. But if we boot with DFP connected,
  TMDS generated clocks are used instead of ALL pixclocks
  available... If someone knows which register
  handles it, please reveal this secret to me... */
hw->DACreg[POS1064_XPWRCTRL] &= ~0x04; /* Poweroff TMDS */
#endif



>
> Sometimes dead code are kept becasue it documents something etc.
> So it is not always a simple removal.
>
Yes, I agree there are some dead code kept tree wide for documentation purpose,
but many of them are truly dead code as well and it differ from case to case.
