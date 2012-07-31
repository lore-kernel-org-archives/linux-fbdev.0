From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 31 Jul 2012 13:03:47 +0000
Subject: Re: [PATCH V2 2/5] include/video: Add Exynos5 specific FIMD register offsets
Message-Id: <5017D7B3.1080001@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-3-git-send-email-l.krishna@samsung.com>
 <5017D4D7.3040303@mvista.com>
In-Reply-To: <5017D4D7.3040303@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sshtylyov@mvista.com>, Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, kgene.kim@samsung.com, jg1.han@samsung.com, joshi@samsung.com, dri-devel@lists.freedesktop.org, inki.dae@samsung.com, ben-linux@fluff.org, m.szyprowski@samsung.com

Hi,

On 07/31/2012 02:51 PM, Sergei Shtylyov wrote:
>> +/*EXYNOS5 FIMD REG OFFSET */

How about changing it to, e.g.

/* EXYNOS5 specific register offset definitions */

(but just in case you happen to resend this patch series)

>> +#define EXYNOS5_VIDTCON0    (0x20010)
>> +#define EXYNOS5_VIDTCON1    (0x20014)
>> +#define EXYNOS5_VIDTCON2    (0x20018)
>> +#define EXYNOS5_VIDTCON3    (0x2001C)
>> +#define EXYNOS5_VIDCON1        (0x20004)
> 
>    Parens not needed around simple literals.

Yes, I agree it looks insane. But, I think we could allow
this for consistency with the remaining definitions.

-- 

Regards,
Sylwester
