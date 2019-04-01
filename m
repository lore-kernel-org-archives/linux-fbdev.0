From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 12:04:06 +0000
Subject: Re: [PATCH] video/macfb: Call fb_invert_cmaps()
Message-Id: <eaaa9e82-8194-17c3-6106-16a34a36a194@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190217233037epcas5p1f527f485e504ee424a1a26f47dc1ea51@epcas5p1.samsung.com>
        <80cf1394f099ced17bd5075be88cf33c1232086a.1550445927.git.fthain@telegraphics.com.au>
In-Reply-To: <80cf1394f099ced17bd5075be88cf33c1232086a.1550445927.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 02/18/2019 12:25 AM, Finn Thain wrote:
> The 'inverse' parameter has no effect otherwise. Remove set-but-unused
> variable.
> 
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
