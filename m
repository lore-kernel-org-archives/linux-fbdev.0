From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:20:28 +0000
Subject: Re: [PATCH 6/8] fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting.
Message-Id: <20190331122028.sfdbpojjxdwjuvp2@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-7-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-7-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:02AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), blanking the display
> or starting the X server will crash and freeze the system, or garble the
> display.
> 
> Experiments showed this problem can mostly be solved by adjusting the
> order of register writes. Also, sm712fb failed to consider the difference
> of clock frequency when unblanking the display, and programs the clock for
> SM712 to SM720.
> 
> Fix them by adjusting the order of register writes, and adding an
> additional check for SM720 for programming the clock frequency.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
