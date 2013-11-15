From: Inki Dae <inki.dae@samsung.com>
Date: Fri, 15 Nov 2013 02:00:13 +0000
Subject: RE: [PATCH] video: exynos_mipi_dsim: Remove unused variable
Message-Id: <01f701cee1a6$6c403110$44c09330$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384463364-28864-1-git-send-email-olof@lixom.net>
In-Reply-To: <1384463364-28864-1-git-send-email-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Olof,

> -----Original Message-----
> From: Olof Johansson [mailto:olof@lixom.net]
> Sent: Friday, November 15, 2013 10:49 AM
> To: Greg Kroah-Hartman
> Cc: Kishon Vijay Abraham I; linux-fbdev@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org; linux-kernel@vger.kernel.org; Sylwester Nawrocki;
> InKi Dae
> Subject: Re: [PATCH] video: exynos_mipi_dsim: Remove unused variable
> 
> On Thu, Nov 14, 2013 at 5:32 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Nov 14, 2013 at 01:09:24PM -0800, Olof Johansson wrote:
> >> commit 7e0be9f9f7cba3356f75b86737dbe3a005da067e ('video:
> exynos_mipi_dsim:
> >> Use the generic PHY driver') resulted in a warning about an unused
> >> variable:
> >>
> >> drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning: unused variable
> >>     'pdev' [-Wunused-variable]
> >>
> >> It is indeed unused; remove it.
> >>
> >> Signed-off-by: Olof Johansson <olof@lixom.net>
> >> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> ---
> >>  drivers/video/exynos/exynos_mipi_dsi.c |    1 -
> >>  1 file changed, 1 deletion(-)
> >
> > I had to take the offending patch through my tree due to the phy
> > changes, but I'm not the maintainer of it, nor the video mantainer, so I
> > can't really take this patch through my trees, sorry.
> 
> I was wondering why you had signed off, since it didn't follow the
> regular path. Makes sense.
> 
> So, looks like most historical patches to this file have gone through
> Andrew. Can I get an ack from someone and just take it through arm-soc
> in this case, please? Inki?
> 

Acked-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> 
> -Olof

