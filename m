From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 17 Jan 2014 06:07:23 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <000101cf134a$635cfda0$2a16f8e0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday, January 17, 2014 2:44 PM, Sachin Kamat wrote:
> On 17 January 2014 10:42, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Friday, January 17, 2014 1:58 PM, Jingoo Han wrote:
> >> On 17 January 2014 10:17, Jingoo Han <jg1.han@samsung.com> wrote:
> >> > On Friday, January 17, 2014 1:33 PM, Sachin Kamat wrote:
> >> >>
> >> >> Exynos is now a DT only platform. Hence there is no need
> >> >> for an explicit OF dependency. Remove it.
> >> >>
> >> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> >
> >> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> >>
> >> Thanks.
> >> >
> >> > Thank you for sending the patch. However, please CC me,
> >> > because I am a maintainer of Exynos DP driver.
> >>
> >> Sorry for missing you on the CC list. I think you probably need to
> >> update the MAINTAINER file
> >> entry to reflect this.
> >
> > Um, there is no problem in the MAINTAINER file about this.
> > Maybe, you are confused.
> 
> No confusion from my side :)
> The entries below do not list maintainer for the Kconfig file since
> you have added specific filters.
> Please verify using get_maintainers script.

Ah, I see.
Right, there is no entries for 'drivers/video/exynos/Kconfig'.
Because, this Kconfig file is shared by both "EXYNOS DP DRIVER"
and  "EXYNOS MIPI DISPLAY DRIVERS", I did not add it to "EXYNOS
DP DRIVER" entry.

> 
> scripts/get_maintainer.pl -f drivers/video/exynos/Kconfig
> 
> This is what it gives (and you are not listed as a maintainer in this case):
> 
> Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> (maintainer:FRAMEBUFFER LAYER)
> Tomi Valkeinen <tomi.valkeinen@ti.com> (maintainer:FRAMEBUFFER
> LAYER,commit_signer:1/4%%)
> Kukjin Kim <kgene.kim@samsung.com> (maintainer:ARM/S5P EXYNOS AR...)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:2/4P%)
> Kishon Vijay Abraham I <kishon@ti.com> (commit_signer:2/4P%)
> Sachin Kamat <sachin.kamat@linaro.org>
> (commit_signer:2/4P%,authored:2/4P%,added_lines:3/5`%,removed_lines:2/3g%)
> Jingoo Han <jg1.han@samsung.com>
> (commit_signer:1/4%%,authored:1/4%%,added_lines:1/5 %,removed_lines:1/33%)
> Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> (authored:1/4%%,added_lines:1/5 %)
> linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/S5P EXYNOS AR...)
> linux-samsung-soc@vger.kernel.org (moderated list:ARM/S5P EXYNOS AR...)
> linux-kernel@vger.kernel.org (open list)

If you have a good idea for get_maintainer.pl, please let me know.
Thank you.

Best regards,
Jingoo Han

