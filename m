From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:19:24 +0000
Subject: Re: [PATCH 3/8] fbdev: sm712fb: fix VRAM detection, don't set SR70/71/74/75.
Message-Id: <20190331121924.5wjhhjp2j2gom7zp@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-4-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-4-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:24:59AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), the amount of Video
> RAM is not detected correctly by the xf86-video-siliconmotion driver.
> This is because sm712fb overwrites the GPR71 Scratch Pad Register, which
> is set by BIOS on x86 and used to indicate amount of VRAM.
> 
> Other Scratch Pad Registers, including GPR70/74/75, don't have the same
> side-effect, but overwriting to them is still questionable, as they are
> not related to modesetting.
> 
> Stop writing to SR70/71/74/75 (a.k.a GPR70/71/74/75).
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
