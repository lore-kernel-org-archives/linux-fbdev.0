From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 17 Jan 2014 05:12:09 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <000401cf1342$ac612290$052367b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday, January 17, 2014 1:58 PM, Jingoo Han wrote:
> On 17 January 2014 10:17, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Friday, January 17, 2014 1:33 PM, Sachin Kamat wrote:
> >>
> >> Exynos is now a DT only platform. Hence there is no need
> >> for an explicit OF dependency. Remove it.
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> Thanks.
> >
> > Thank you for sending the patch. However, please CC me,
> > because I am a maintainer of Exynos DP driver.
> 
> Sorry for missing you on the CC list. I think you probably need to
> update the MAINTAINER file
> entry to reflect this.

Um, there is no problem in the MAINTAINER file about this.
Maybe, you are confused.

Now, Exynos "DP" and Exynos "MIPI" are separately maintained
as below:

EXYNOS DP DRIVER
M:	Jingoo Han <jg1.han@samsung.com>
L:	linux-fbdev@vger.kernel.org
S:	Maintained
F:	drivers/video/exynos/exynos_dp*
F:	include/video/exynos_dp*

EXYNOS MIPI DISPLAY DRIVERS
M:	Inki Dae <inki.dae@samsung.com>
M:	Donghwa Lee <dh09.lee@samsung.com>
M:	Kyungmin Park <kyungmin.park@samsung.com>
L:	linux-fbdev@vger.kernel.org
S:	Maintained
F:	drivers/video/exynos/exynos_mipi*
F:	include/video/exynos_mipi*

Thus, 2nd patch is related to "MIPI", thus, previous CC list is
right. However, 1st patch is related to only "DP". So, I should
be included to CC list.

Best regards,
Jingoo Han

