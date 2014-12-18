From: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>
Date: Thu, 18 Dec 2014 10:26:47 +0000
Subject: Re: Weird/Unneeded call to msleep in exynos_mipi_dsi_wr_data in exynos_mipi_dsi_common.c
Message-Id: <5492ABE7.1060900@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54920A54.2060608@gmail.com>
In-Reply-To: <54920A54.2060608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 17.12.2014 23:57, nick wrote:
> Greetings Fellow Maintainers,
> Sorry if I wasting your time but it seems there is a unneeded call to msleep

Hi,

1. Please describe exactly why do you think this is not needed.
2. Do you have Exynos-based hardware to test your changes?

Best regards,
Krzysztof

> and rather trivial fix me to fix in the file,exynos_mipi_dsi_common.c for the function,exynos_mipi_dsi_wr_data . If there is a valid reason for this call please let me known when any of you  have some free time. Otherwise I will send in a patch to remove this unneeded
> call to msleep.
> Thanks,
> Nick  


