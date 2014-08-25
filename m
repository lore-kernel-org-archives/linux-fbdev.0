From: Luc Verhaegen <libv@skynet.be>
Date: Mon, 25 Aug 2014 15:09:00 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825150900.GB21020@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com> <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com> <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com> <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
In-Reply-To: <20140825150501.GE14763@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
> 
> No. simplefb just wants to write to some memory that hardware has been
> set up to scan out. The platform requires that the clocks be on.

Simplefb also requires that the memory is there and is persistent. Fine 
for discrete graphics cards, fine for rpi where most things are hidden 
from the ARM core anyway, not so fine for anybody else.

Luc Verhaegen.
