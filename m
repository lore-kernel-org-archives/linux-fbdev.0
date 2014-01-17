From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 17 Jan 2014 09:33:46 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <CAK9yfHzy33MkXCSJ4DBGxkFuGK+gMvBgRLd69Je1D8h2tJxcug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 17 January 2014 14:33, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2014-01-17 06:32, Sachin Kamat wrote:
>> Exynos is now a DT only platform. Hence there is no need
>> for an explicit OF dependency. Remove it.
>
> Is Exynos a DT-only platform in v3.13? Or only in v3.14?

It has been so since v3.11.



-- 
With warm regards,
Sachin
