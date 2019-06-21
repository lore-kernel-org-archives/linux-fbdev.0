From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 12:40:35 +0000
Subject: Re: [PATCH] video: fbdev-MMP: Use struct_size() in devm_kzalloc()
Message-Id: <f789452f-5b4e-543e-67e2-16157af8e49e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190604233211epcas1p1473ce5a9bb5e1113a91b37ec9a43f320@epcas1p1.samsung.com>
        <20190604233205.GA5377@embeddedor>
In-Reply-To: <20190604233205.GA5377@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 6/5/19 1:32 AM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = devm_kzalloc(dev, size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
> 
> Notice that, in this case, variable size is not necessary, hence it
> is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
