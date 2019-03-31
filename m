From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:19:07 +0000
Subject: Re: [PATCH 2/8] fbdev: sm712fb: fix brightness control on reboot, don't set SR30.
Message-Id: <20190331121907.npu4kehmgxmmf44j@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-3-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-3-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:24:58AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), rebooting with
> sm712fb framebuffer driver would cause the role of brightness up/down
> button to swap.
> 
> Experiments showed the FPR30 register caused this behavior. Moreover,
> even if this register don't have side-effect on other systems, over-
> writing it is also highly questionable, since it was originally
> configurated by the motherboard manufacturer by hardwiring pull-down
> resistors to indicate the type of LCD panel. We should not mess with
> it.
> 
> Stop writing to the SR30 (a.k.a FPR30) register.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
