From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 20 Jun 2017 11:09:33 +0000
Subject: Re: [PATCH 1/2] drm/exynos/decon: Add include guard to the Exynos7 header
Message-Id: <CAJKOXPdfHoZY5QcZEvuN8nPsCwR4mvZ+aT5iZDVbSBgPRF46QA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170619163110.28173-1-krzk@kernel.org> <CACvgo51db4Gk+GHAO-F=rz8vLTG6A66f1ZeHPNuAQV1Qthaavw@mail.gmail.com>
 <CAJKOXPfjEozEM=q4hbWRBJngNDxnkJXF37gN2Es1Ju8Qze4J1g@mail.gmail.com> <CACvgo52KMMt+S-KVYnmMy9qGUL6jMD2Uj8EJWNkKUQLr0_wfAw@mail.gmail.com>
In-Reply-To: <CACvgo52KMMt+S-KVYnmMy9qGUL6jMD2Uj8EJWNkKUQLr0_wfAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On Tue, Jun 20, 2017 at 12:57 PM, Emil Velikov <emil.l.velikov@gmail.com> wrote:
> On 20 June 2017 at 11:02, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Tue, Jun 20, 2017 at 11:53 AM, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>>> On 19 June 2017 at 17:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> Although header is included only once but still having an include guard
>>>> is a good practice.  To avoid confusion, add SoC prefix to existing
>>>> Exynos5433 header include guard.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> ---
>>>>  include/video/exynos5433_decon.h | 6 +++---
>>>>  include/video/exynos7_decon.h    | 5 +++++
>>>>  2 files changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/video/exynos5433_decon.h b/include/video/exynos5433_decon.h
>>>> index 78957c9626f5..b30362da5692 100644
>>>> --- a/include/video/exynos5433_decon.h
>>>> +++ b/include/video/exynos5433_decon.h
>>>> @@ -6,8 +6,8 @@
>>>>   * published by the Free Software Foundationr
>>>>   */
>>>>
>>>> -#ifndef EXYNOS_REGS_DECON_H
>>>> -#define EXYNOS_REGS_DECON_H
>>>> +#ifndef EXYNOS5433_REGS_DECON_H
>>>> +#define EXYNOS5433_REGS_DECON_H
>>>>
>>> Drop the _REGS_ part from the guard on each header? The file name/path
>>> does not have it, plus it'll save some WTF moments when
>>> exynos{5433,7}_regs_decon.h comes about.
>>
>> So maybe it makes sense to reorder these patches and use the guard
>> name matching final file name?
>>
> That sounds better, IMHO.

OK then, I'll re-order the patches and use matching name
(EXYNOS_REGS_DECON{5433,7}_H).

Best regards,
Krzysztof
