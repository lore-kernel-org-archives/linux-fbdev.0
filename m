From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:20:46 +0000
Subject: Re: [PATCH 7/8] fbdev: sm712fb: fix support for 1024x768-16 mode.
Message-Id: <20190331122046.dcdffbrifgphttpn@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-8-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-8-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:03AM +0800, Yifeng Li wrote:
> In order to support the 1024x600 panel on Yeeloong Loongson MIPS
> laptop, the original 1024x768-16 table was modified to 1024x600-16,
> without leaving the original. It causes problem on x86 laptop as
> the 1024x768-16 support was still claimed but not working.
> 
> Fix it by introducing the 1024x768-16 mode.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
