From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Apr 2017 14:31:59 +0000
Subject: Re: [PATCH] video: ARM CLCD: fix dma allocation size
Message-Id: <2871477.J78ljCzBX8@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170308145805.1325-1-slemieux.tyco@gmail.com>
 <CGME20170407143202epcas5p337f2b743793c97abbb5e0c441eaae163@epcas5p3.samsung.com>
In-Reply-To: <20170308145805.1325-1-slemieux.tyco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi,

On Wednesday, March 08, 2017 09:58:05 AM Sylvain Lemieux wrote:
> From: Liam Beguin <lbeguin@tycoint.com>
> 
> This patch forces the frambuffer size to be aligned on kernel pages.
> 
> During the board startup, the splash screed did appear;
> the "ts_test" program or our application were not able to start.
> 
> The following error message was reported:
> error: failed to map framebuffer device to memory.
> LinuxFB: driver cannot connect
> 
> The issue was discovered, on the LPC32xx platform, during the migration
> of the LCD definition from the board file to the device tree.
> 
> Signed-off-by: Liam Beguin <lbeguin@tycoint.com>
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

