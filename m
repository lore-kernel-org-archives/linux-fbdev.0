From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Aug 2019 14:10:01 +0000
Subject: Re: [PATCH] video: fbdev/mmp/core: Use struct_size() in kzalloc()
Message-Id: <d2b32f0f-307d-b286-22b5-2316c9de1d93@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190807161320epcas2p1457bd16d94c3f746543130153a472696@epcas2p1.samsung.com>
        <20190807161312.GA26835@embeddedor>
In-Reply-To: <20190807161312.GA26835@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 8/7/19 6:13 PM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct mmp_path {
> 	...
>         struct mmp_overlay overlays[0];
> };
> 
> size = sizeof(struct mmp_path) + count * sizeof(struct mmp_overlay);
> instance = kzalloc(size, GFP_KERNEL)
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, overlays, count), GFP_KERNEL)
> 
> Notice that, in this case, variable size is not necessary, hence it
> is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
