From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 16:12:54 +0000
Subject: Re: [PATCH v2 15/20] video: exynos: Rename Exynos to lowercase
Message-Id: <aa7a3dc9-2ab1-1a5a-9c23-95226033cd98@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
 <CGME20200104152253epcas3p364103342a5c96fd12d226be9fa5d4cba@epcas3p3.samsung.com>
 <20200104152107.11407-16-krzk@kernel.org>
In-Reply-To: <20200104152107.11407-16-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 1/4/20 4:21 PM, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> name.
> 
> "EXYNOS" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/video/samsung_fimd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
> index b6571c3cfa31..c4a93ce1de48 100644
> --- a/include/video/samsung_fimd.h
> +++ b/include/video/samsung_fimd.h
> @@ -10,7 +10,7 @@
>   *
>   * This is the register set for the fimd and new style framebuffer interface
>   * found from the S3C2443 onwards into the S3C2416, S3C2450, the
> - * S3C64XX series such as the S3C6400 and S3C6410, and EXYNOS series.
> + * S3C64XX series such as the S3C6400 and S3C6410, and Exynos series.
>  */
>  
>  /* VIDCON0 */
> 
