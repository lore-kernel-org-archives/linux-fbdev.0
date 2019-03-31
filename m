From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:21:03 +0000
Subject: Re: [PATCH 8/8] fbdev: sm712fb: use 1024x768 by default on non-MIPS, fix garbled display.
Message-Id: <20190331122103.o7ek46dvhop7lewm@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-9-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-9-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:04AM +0800, Yifeng Li wrote:
> Loongson MIPS netbooks use 1024x600 LCD panels, which is the original
> target platform of this driver, but nearly all old x86 laptops have
> 1024x768. Lighting 768 panels using 600's timings would partially
> garble the display. Since it's not possible to distinguish them reliably,
> we change the default to 768, but keep 600 as-is on MIPS.
> 
> Further, earlier laptops, such as IBM Thinkpad 240X, has a 800x600 LCD
> panel, this driver would probably garbled those display. As we don't
> have one for testing, the original behavior of the driver is kept as-is,
> but the problem has been documented is the comments.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
