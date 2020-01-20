From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Jan 2020 17:54:35 +0000
Subject: Re: [PATCH] fbdev: wait for references go away
Message-Id: <a8031679-4fcf-830d-dcf5-80654f2fbc97@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
 <20200120100014.23488-1-kraxel@redhat.com>
 <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
In-Reply-To: <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, marmarek@invisiblethingslab.com, open list <linux-kernel@vger.kernel.org>


On 1/20/20 6:51 PM, Bartlomiej Zolnierkiewicz wrote:

> do_unregister_framebuffer() doesn't guarantee that fb_info is freed after
> function's return (it only drops the kernel reference on fb_info).
s/kernel/fbdev device driver/

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
