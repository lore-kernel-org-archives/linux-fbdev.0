From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:41:45 +0000
Subject: Re: [PATCH] fbdev: Convert to using %pOFn instead of device_node.name
Message-Id: <20181008104146eucas1p206774c188cefcfd36e33b467ed7b67ad~bnBPnnsKU2190121901eucas1p2U@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <CGME20180828015547epcas1p421d327fc2f675bcf45431bb3fe9e678f@epcas1p4.samsung.com>
 <20180828015252.28511-49-robh@kernel.org>
In-Reply-To: <20180828015252.28511-49-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 08/28/2018 03:52 AM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
