From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 06 May 2019 13:37:19 +0000
Subject: Re: [PATCH v3 14/26] compat_ioctl: move ATYFB_CLK handling to atyfb driver
Message-Id: <28b28937-cd5c-61f4-6f84-c6108c006e21@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
 <CGME20190416202751epcas3p3655845bd23c19d035b72d9b178427e28@epcas3p3.samsung.com>
 <20190416202701.127745-3-arnd@arndb.de>
In-Reply-To: <20190416202701.127745-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, y2038@lists.linaro.org, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mikulas Patocka <mpatocka@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


On 04/16/2019 10:25 PM, Arnd Bergmann wrote:
> These are two obscure ioctl commands, in a driver that only
> has compatible commands, so just let the driver handle this
> itself.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
