From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 14:41:20 +0000
Subject: Re: [PATCH] video: hgafb: fix a NULL pointer dereference
Message-Id: <f239940f-d67c-ee8d-7d53-1df5543c9710@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190314073039epcas3p29225f2fcf1102266ce8265811f7f244e@epcas3p2.samsung.com>
        <20190314073027.22337-1-kjlu@umn.edu>
In-Reply-To: <20190314073027.22337-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Ferenc Bakonyi <fero@drama.obuda.kando.hu>, linux-nvidia@lists.surfsouth.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 03/14/2019 08:30 AM, Kangjie Lu wrote:
> When ioremap fails, hga_vram should not be dereferenced. The fix
> check the failure to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Patch queued for v5.2 with minor change in the patch summary
("video: hgafb: fix potential NULL pointer dereference"), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
