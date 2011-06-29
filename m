From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 29 Jun 2011 13:58:33 +0000
Subject: RE: [PATCH V7 5/5] ARM: EXYNOS4: Add platform data for EXYNOS4 FIMD
Message-Id: <004c01cc3664$a640dd00$f2c29700$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309171858-30397-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1309171858-30397-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Paul Mundt' <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: 'Anand Kumar N' <anand.kn@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Kyungmin Park' <kmpark@infradead.org>, 'Inki Dae' <inki.dae@samsung.com>, 'ARM Linux' <linux@arm.linux.org.uk>, 'Ben Dooks' <ben-linux@fluff.org>, 'Jonghun Han' <jonghun.han@samsung.com>

Jingoo Han wrote:
> 
> From: Jonghun Han <jonghun.han@samsung.com>
> 
> This patch adds support EXYNOS4 FIMD0 and LTE480WV LCD pannel.
> 
> Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/mach-exynos4/mach-smdkc210.c |   71
> +++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos4/mach-smdkv310.c |   71
> +++++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 0 deletions(-)
> 
As I said, don't push same codes into both.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

