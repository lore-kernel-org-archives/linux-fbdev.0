From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 14:42:00 +0000
Subject: Re: [PATCH] video: fbdev: fix potential NULL pointer dereferences
Message-Id: <d4e4253a-05e8-c857-1632-8dc3a4040ca9@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190314073330epcas5p3ac243599bdd87be63b94f9d75b396a9e@epcas5p3.samsung.com>
        <20190314073319.23209-1-kjlu@umn.edu>
In-Reply-To: <20190314073319.23209-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Finn Thain <fthain@telegraphics.com.au>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 03/14/2019 08:33 AM, Kangjie Lu wrote:
> In case ioremap fails, the fix releases resources and returns
> -ENOMEM to avoid NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Patch queued for v5.2 with minor change in the patch summary
("video: imsttfb: fix potential NULL pointer dereference"), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
