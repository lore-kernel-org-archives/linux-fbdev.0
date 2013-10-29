From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 29 Oct 2013 23:00:00 +0000
Subject: Re: [PATCH 1/1] video: exynos_mipi_dsi: Remove unused variable
Message-Id: <20131029230000.GA12746@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Fri, Oct 25, 2013 at 10:51:48AM +0530, Sachin Kamat wrote:
> On 24 October 2013 21:25, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > On Monday 21 October 2013 11:02 AM, Sachin Kamat wrote:
> >> 'pdev' is not used anymore (Removed vide commit 7e0be9f9 "video:
> >> exynos_mipi_dsim: Use the generic PHY driver"). Remove it and
> >> silence the following compilation warning:
> >> drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning:
> >> unused variable ‘pdev’ [-Wunused-variable]
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks Kishon.
> 
> I believe this patch should go through Greg's tree as your other
> patches are lined up there?

I don't take drivers/video/* patches now, am I?

greg k-h
