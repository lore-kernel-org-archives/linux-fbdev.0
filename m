From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 03 Feb 2016 09:05:22 +0000
Subject: Re: [PATCH] video: ARM CLCD: runtime check for Versatile
Message-Id: <5665949.mZpbM5Nbon@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454446059-30526-1-git-send-email-linus.walleij@linaro.org>
 <25978729.oSoMp4ZgxA@wuerfel> <20160203004154.GA10826@n2100.arm.linux.org.uk>
In-Reply-To: <20160203004154.GA10826@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 03 February 2016 00:41:54 Russell King - ARM Linux wrote:
> On Tue, Feb 02, 2016 at 10:10:49PM +0100, Arnd Bergmann wrote:
> > On Tuesday 02 February 2016 21:47:39 Linus Walleij wrote:
> > >         } else {
> > > -#ifdef CONFIG_ARCH_VERSATILE
> > > -               fb->off_ienb = CLCD_PL111_IENB;
> > > -               fb->off_cntl = CLCD_PL111_CNTL;
> > > -#else
> > > -               fb->off_ienb = CLCD_PL110_IENB;
> > > -               fb->off_cntl = CLCD_PL110_CNTL;
> > > -#endif
> > > +               if (of_machine_is_compatible("arm,versatile-ab") ||
> > > +                   of_machine_is_compatible("arm,versatile-pb")) {
> > > +                       fb->off_ienb = CLCD_PL111_IENB;
> > > +                       fb->off_cntl = CLCD_PL111_CNTL;
> > > +               } else {
> > > +                       fb->off_ienb = CLCD_PL110_IENB;
> > > +                       fb->off_cntl = CLCD_PL110_CNTL;
> > > +               }
> > >         }
> > > 
> > 
> > Could that be done based on the AMBA device ID instead?
> 
> Unfortunately not.  It's a mistake made on one Versatile board
> which reverses the registers.  There's nothing to distinguish it
> in the primecell itself.

Ok, I see. It would be nice to have this knowledge locally in
the driver, e.g. through a special compatible string for the
variant on the versatile, or a bool property, but this way seems
good enough as we can be reasonably sure that nobody else made the
same mistake.

	Arnd
