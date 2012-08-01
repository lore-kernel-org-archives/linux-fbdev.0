From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 01 Aug 2012 10:09:01 +0000
Subject: RE: [PATCH V2 5/5] arm: samsung: delete frame buffer header files from platform
Message-Id: <037d01cd6fcd$ac64d300$052e7900$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-6-git-send-email-l.krishna@samsung.com>
 <02ee01cd6f89$f218b2c0$d64a1840$%kim@samsung.com>
 <CAL1wa8cShB7zDj-CPvfEncX+Up7enKM9MJOt-488dThj_tXbMA@mail.gmail.com>
 <037101cd6fc9$85386e30$8fa94a90$%kim@samsung.com>
 <5018FE28.8070907@samsung.com>
In-Reply-To: <5018FE28.8070907@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Sylwester Nawrocki' <s.nawrocki@samsung.com>
Cc: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, joshi@samsung.com, jg1.han@samsung.com, m.szyprowski@samsung.com

Sylwester Nawrocki wrote:
> 
> Hi,
> 
> On 08/01/2012 11:39 AM, Kukjin Kim wrote:
> > Leela Krishna Amudala wrote:
> >> On Wed, Aug 1, 2012 at 7:34 AM, Kukjin Kim <kgene.kim@samsung.com>
> wrote:
> >>> Leela Krishna Amudala wrote:
> >>>>
> >>>> The FIMD register headers are moved to include/video/
> >>>> hence, deleting these files from platform side
> >>>>
> >>>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >>>> ---
> >>>>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 ---------
> >>>>  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403
> >>> -------------------
> >>>> ----
> >>>>  2 files changed, 0 insertions(+), 562 deletions(-)
> >>>>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
> >>>>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
> >>>>
> >>> No. This should be squashed into first patch on this series. See
below.
> >>>
> >>>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159
> >>> --------------------
> >>>  .../plat/regs-fb.h => include/video/samsung_fimd.h |  145
> >>> ++++++++++++++++--
> >>>  2 files changed, 134 insertions(+), 170 deletions(-)
> >>>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
> >>>  rename arch/arm/plat-samsung/include/plat/regs-fb.h =>
> >>> include/video/samsung_fimd.h (74%)
> >>>
> >>
> >> If I squash it with the first patch and if somebody set that as a head
> >> commit, it will break the build. Hence, splitted it up from the first
> >> patch.
> >>
> > NACK. your changes are not adding just moving. So should be squashed. If
> > required, you could create just one patch for moving them, probably,
1st,
> > 3rd, 4th and 5th patches into one patch.
> 
> Yes, this patch series is mainly moving files around. But to avoid git
> bisect breakage, it should be split as it is done now, or the whole
> series should be squashed into one patch. The latter might be even easier
> to handle, but having a single patch touching arch/arm/ and drivers/
> might not be a good idea. If you're fine handling that, then we just
> need to squash this series into single patch.
> It just need to be ensured, IMO, there is no bisection breakage.
> 
I know you meant. But we don't need to keep the changes 'adding and
removing' for just moving on this.

I commented on 0/5 patch in this series before, if this is ready, I will
create topic branch so that it could be merged into both mine and Florian's.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

