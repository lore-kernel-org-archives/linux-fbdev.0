From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:18:51 +0000
Subject: Re: [PATCH 1/8] fbdev: sm712fb: fix white screen of death on reboot, don't set CR3B-CR3F.
Message-Id: <20190331121851.h3j2pud6yhelsknr@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-2-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-2-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:24:57AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), rebooting with
> sm712fb framebuffer driver would cause a white screen of death on
> the next POST, presumably the proper timings for the LCD panel was
> not reprogrammed properly by the BIOS.
> 
> Experiments showed a few CRTC Scratch Registers, including CRT3D,
> CRT3E and CRT3F may be used internally by BIOS as some flags. CRT3B is
> a hardware testing register, we shouldn't mess with it. CRT3C has
> blanking signal and line compare control, which is not needed for this
> driver.
> 
> Stop writing to CR3B-CR3F (a.k.a CRT3B-CRT3F) registers. Even if these
> registers don't have side-effect on other systems, writing to them is
> also highly questionable.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
