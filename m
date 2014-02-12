From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 12 Feb 2014 08:41:06 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <CAK9yfHwxj0iz8iqXh3RZJ_C0ZGzffjmDFYLQbgaV=EkF1mgzhg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12 February 2014 12:55, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 12/02/14 09:08, Sachin Kamat wrote:
>> On 11 February 2014 19:57, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On 11/02/14 14:01, Sachin Kamat wrote:
>>>> On 10 February 2014 17:48, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>>> On 17/01/14 06:32, Sachin Kamat wrote:
>>>>>> Exynos is now a DT only platform. Hence there is no need
>>>>>> for an explicit OF dependency. Remove it.
>>>>>
>>>>> But the driver still depends on OF, doesn't it? I don't think it's very
>>>>> good for the driver Kconfig to make presumptions about what ARCH_*
>>>>> depend on.
>>>>
>>>> Depending upon nested dependencies is redundant IMHO.
>>>
>>> Well, a driver should be independent of the underlying arch. In
>>> practice, we have ARCH dependencies, as many of the devices only exist
>>> on that arch. But I think the drivers should still be designed to be
>>> arch-independent, as far as possible (omapdss compiles fine on x86).
>>>
>>> If the driver depends on OF, it should depend on OF in the Kconfig, no
>>> matter if the arch also depends on OF.
>>>
>>> I don't really care if the EXYNOS_LCD_S6E8AX0 has OF dependency or not,
>>> but to me this just looks unneeded cleanup, cluttering git logs, and in
>>> my opinion it's even going to the wrong direction.
>>
>> Your argument makes sense. Upon further experimentation I found that even the
>> Exynos video drivers are ARCH independent (i.e., they build on x86 too) and do
>> not need to depend on OF for compilation. So I believe, we can remove both these
>> dependencies. What is your opinion?
>
> Indeed, the driver doesn't even seem to call any of_* funcs. Looking at
> the commit f9b1e013f1c6723798b8f7f5b83297e2837aaef7 (video: exynos_dp:
> remove non-DT support for Exynos Display Port), it kind of sounds to me
> that the OF dependency was put there just to prevent non-DT use.
>
> I'm fine with removing OF dependency, if the commit description is
> updated to say that it can be removed as the driver doesn't actually
> depend on OF at all.
>
> As for the ARCH dependency, I think we should keep it. I once removed
> ARCH_OMAP dependency from omapdss, but Linus wasn't impressed when his
> kernel compilation started to ask him if he wants to enable OMAPDSS
> this, OMAPDSS that =). So I think it's fine to keep ARCH dependencies in
> cases where the driver is clearly used only on some architecture.

Yes, I remember that :)

>
> However, you can use COMPILE_TEST kconfig option if you want to compile
> test on other archs. I.e.:
>
> depends on ARCH_EXYNOS || COMPILE_TEST

For now I will update the commit description and re-send the patch.
Thanks for your
comments Tomi.



-- 
With warm regards,
Sachin
