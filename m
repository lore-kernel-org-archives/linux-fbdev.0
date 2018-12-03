From: Timur Tabi <timur@kernel.org>
Date: Mon, 03 Dec 2018 14:53:53 +0000
Subject: Re: [PATCH] fbdev: fsl-diu: remove redundant null check on cmap
Message-Id: <bda8bdc3-46cb-883d-1ddc-8fda0cf241be@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181203064317.57054-1-wen.yang99@zte.com.cn>
In-Reply-To: <20181203064317.57054-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wen Yang <wen.yang99@zte.com.cn>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn

On 12/3/18 12:43 AM, Wen Yang wrote:
> The null check on &info->cmap is redundant since cmap is a struct
> inside fb_info and can never be null, so the check is always true.
> we may remove it.
> 
> Signed-off-by: Wen Yang<wen.yang99@zte.com.cn>

Acked-by: Timur Tabi <timur@kernel.org>
