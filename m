From: Daniel Drake <dsd@laptop.org>
Date: Fri, 21 Jun 2013 17:31:05 +0000
Subject: Re: [V2 6/7] video: mmp: calculate pitch value when fb set win
Message-Id: <CAMLZHHRLv+qZXVOkZSH2FDxanhy6xitYgCbF3DHXS-8FEWNfuQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879585-11452-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370879585-11452-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 9:53 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
> From: Jing Xiang <jxiang@marvell.com>
>
> Add new func mmpfb_set_win to make code clean, it will calculate pitch
> value when fb set win in mmpfb_set_win.

It looks like a good idea to create a function for setting window
parameters from fb info, but this patch also starts to write into the
pitch[] fields which are not used anywhere. You should rework these
patches so that the pitch field is introduced, set, and consumed all
in the same patch.

The commit message for the patch that added pitch[] seems to suggest
that pitch[1] and pitch[2] are used for YUV formats. But in the code
posted here, they will not be used for PIXFMT_YUYV, PIXFMT_UYVY, etc.

Thanks,
Daniel
