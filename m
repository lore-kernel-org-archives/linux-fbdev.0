From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 31 Jul 2012 00:47:57 +0000
Subject: RE: [PATCH 1/3] Move FIMD register headers to include/video/
Message-Id: <000a01cd6eb6$2113a050$633ae0f0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
 <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
 <000001cd6e30$da849520$8f8dbf60$%han@samsung.com>
 <CAL1wa8e7Joghf9S=SgbQLJFWcYOrP5uK6qYXsV_N6rX1MVEALg@mail.gmail.com>
In-Reply-To: <CAL1wa8e7Joghf9S=SgbQLJFWcYOrP5uK6qYXsV_N6rX1MVEALg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, July 30, 2012 8:16 PM, Leela Krishna Amudala wrote:
> 
> Hello Jingoo Han,
> 
> On Mon, Jul 30, 2012 at 2:23 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Monday, July 30, 2012 5:45 PM, Leela Krishna Amudala wrote:
> >>
> >> Moved the contents of regs-fb-v4.h and regs-fb.h from arch side
> >> to include/video/samsung_fimd.h
> >>
> >> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >> ---
> >>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
> >>  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
> >>  include/video/samsung_fimd.h                    |  533 +++++++++++++++++++++++
> >>  3 files changed, 533 insertions(+), 562 deletions(-)
> >>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
> >>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
> >>  create mode 100644 include/video/samsung_fimd.h
> >>
> >> +*/
> >> +
> >> +/*FIMD V8 REG OFFSET */
> >> +#define FIMD_V8_VIDTCON0     (0x20010)
> >> +#define FIMD_V8_VIDTCON1     (0x20014)
> >> +#define FIMD_V8_VIDTCON2     (0x20018)
> >> +#define FIMD_V8_VIDTCON3     (0x2001C)
> >> +#define FIMD_V8_VIDCON1              (0x20004)


How about using soc_is_exynos5250()?

+#define VIDTCON0				(soc_is_exynos5250() ? \
+						(0x20010) : (0x10))

In this case, the FIMD driver does not need to change.
Also, one binary is available.


Best regards,
Jingoo Han


> >
> >
> > CC'ed Marek.
> >
> > To Leela Krishna Amudala,
> >
> > Don't add these definitions for FIMD_V8_xxx registers, which arenot related to current "regs-fb-v4.h
> and regs-fb.h".
> > Just "move" and "merge" regs-fb-v4.h and regs-fb.h to one header file, not "add" new definitions.
> > If you want to add these definitions, please make new patch for this.
> >
> 
> Will do it in the suggested way,
> 
> 
> > Also, "#define FIMD_V8_xxx" is ugly.
> > I think that there is better way.
> > Please, find other way.
> >
> >
> 
> I used FIMD_V8_xxx instead of  EXYNOS5_FIMD_*, because in future,
> there is a possibility that version 8 FIMD can be used in other
> application processors also.
> Thanks for reviewing the patch.
> 
> Best Wishes,
> Leela Krishna.
> 
> >> --
> >> 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

