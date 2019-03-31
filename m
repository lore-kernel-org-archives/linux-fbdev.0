From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:20:08 +0000
Subject: Re: [PATCH 5/8] fbdev: sm712fb: fix crashes during framebuffer writes by correctly mapping VRAM.
Message-Id: <20190331122008.3ohmdjp54nts42kh@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-6-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-6-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:01AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), running fbtest or X
> will crash the machine instantly, because the VRAM/framebuffer is not
> mapped correctly.
> 
> On SM712, the framebuffer starts at the beginning of address space, but
> SM720's framebuffer starts at the 1 MiB offset from the beginning. However,
> sm712fb fails to take this into account, as a result, writing to the
> framebuffer will destroy all the registers and kill the system immediately.
> Another problem is the driver assumes 8 MiB of VRAM for SM720, but some
> SM720 system, such as this IBM Thinkpad, only has 4 MiB of VRAM.
> 
> Fix this problem by removing the hardcoded VRAM size, adding a function to
> query the amount of VRAM from register MCR76 on SM720, and adding proper
> framebuffer offset.
> 
> Please note that the memory map may have additional problems on Big-Endian
> system, which is not available for testing by myself. But I highly suspect
> that the original code is also broken on Big-Endian machines for SM720, so
> at least we are not making the problem worse. More, the driver also assumed
> SM710/SM712 has 4 MiB of VRAM, but it has a 2 MiB version as well, and used
> in earlier laptops, such as IBM Thinkpad 240X, the driver would probably
> crash on them. I've never seen one of those machines and cannot fix it, but
> I have documented these problems in the comments.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
