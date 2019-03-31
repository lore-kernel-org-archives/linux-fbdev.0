From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 12:18:01 +0000
Subject: Re: [PATCH 0/8] fbdev: sm712fb: fix a series of lockups, crashes and gliches.
Message-Id: <20190331121801.ftwwm4dw2iev3xzf@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Sun, Mar 17, 2019 at 06:24:56AM +0800, Yifeng Li wrote:
> Hi all,
> 
> This patchset contains a series of important fixes to various problems,
> including lockups, crashes, screen gliches, and missing video modes.
> These patches are crucial to the correct operation to the hardware,
> especially Lynx3DM+ (SM720). I have tested and verified them on x86.
> 
> Please review and queue them for linux-stable.

Thanks for the changes.
Verified the register changes from the datasheet and also tested the full
series (separate test for individual patches) with SM712 on little endian
for any regression.

--
Regards
Sudip
