From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:19:44 +0000
Subject: Re: [PATCH 4/8] fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA.
Message-Id: <20190331121944.s67z7seyrgl5xnrw@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-5-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-5-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:00AM +0800, Yifeng Li wrote:
> When the machine is booted in VGA mode, loading sm712fb would cause
> a glitch of random pixels shown on the screen. To prevent it from
> happening, we first clear the entire framebuffer, and we also need
> to stop calling smtcfb_setmode() during initialization, the fbdev
> layer will call it for us later when it's ready.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
