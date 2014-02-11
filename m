From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 11 Feb 2014 12:13:53 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <CAK9yfHw_7AED5h+rPpU+OcR48_39LZ7d5Z0wPXm1NFy8mnCoEw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 10 February 2014 17:48, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 17/01/14 06:32, Sachin Kamat wrote:
>> Exynos is now a DT only platform. Hence there is no need
>> for an explicit OF dependency. Remove it.
>
> But the driver still depends on OF, doesn't it? I don't think it's very
> good for the driver Kconfig to make presumptions about what ARCH_*
> depend on.

Depending upon nested dependencies is redundant IMHO.

-- 
With warm regards,
Sachin
