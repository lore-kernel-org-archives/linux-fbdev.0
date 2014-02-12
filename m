From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 12 Feb 2014 07:20:33 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <CAK9yfHzDR8gBNJyMvoL2o+uMbuC7QzQ8zemTUAwwX+GZFcdB+g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 11 February 2014 19:57, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 11/02/14 14:01, Sachin Kamat wrote:
>> On 10 February 2014 17:48, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On 17/01/14 06:32, Sachin Kamat wrote:
>>>> Exynos is now a DT only platform. Hence there is no need
>>>> for an explicit OF dependency. Remove it.
>>>
>>> But the driver still depends on OF, doesn't it? I don't think it's very
>>> good for the driver Kconfig to make presumptions about what ARCH_*
>>> depend on.
>>
>> Depending upon nested dependencies is redundant IMHO.
>
> Well, a driver should be independent of the underlying arch. In
> practice, we have ARCH dependencies, as many of the devices only exist
> on that arch. But I think the drivers should still be designed to be
> arch-independent, as far as possible (omapdss compiles fine on x86).
>
> If the driver depends on OF, it should depend on OF in the Kconfig, no
> matter if the arch also depends on OF.
>
> I don't really care if the EXYNOS_LCD_S6E8AX0 has OF dependency or not,
> but to me this just looks unneeded cleanup, cluttering git logs, and in
> my opinion it's even going to the wrong direction.

Your argument makes sense. Upon further experimentation I found that even the
Exynos video drivers are ARCH independent (i.e., they build on x86 too) and do
not need to depend on OF for compilation. So I believe, we can remove both these
dependencies. What is your opinion?

-- 
With warm regards,
Sachin
