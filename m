From: Ryan Mallon <rmallon@gmail.com>
Date: Thu, 21 Mar 2013 22:00:46 +0000
Subject: Re: [PATCH for 3.8+] drivers/video/ep93xx-fb.c: fix missing declaration of devm_ioremap()
Message-Id: <514B830E.9040609@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363876715-22039-1-git-send-email-hauke@hauke-m.de>
 <ADE657CA350FB648AAC2C43247A983F0020980225826@AUSP01VMBX24.collaborationhost.net>
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020980225826@AUSP01VMBX24.collaborationhost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 22/03/13 03:22, H Hartley Sweeten wrote:
> On Thursday, March 21, 2013 7:39 AM, Hauke Mehrtens wrote:
>> This fixes the following compile error:
>> drivers/video/ep93xx-fb.c: In function 'ep93xxfb_probe':
>> drivers/video/ep93xx-fb.c:532:2: error: implicit declaration of function 'devm_ioremap' [-Werror=implicit-function-declaration]
>> drivers/video/ep93xx-fb.c:532:17: warning: assignment makes pointer from integer without a cast [enabled by default]
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: stable@vger.kernel.org
> 
> This patch is already in Andrew Morton's -mm tree.
> 
> 
> Ryan,
> 
> Maybe you should pick this up in your fixes branch?

I don't see any reason to since Andrew already has it queued. If it
needs to be backported to stable, then check with Andrew to make sure
that it will be merged in the right places.

In general I don't want to take ep93xx driver patches through my tree,
they should instead go to the appropriate subsystem maintainer.

Thanks,
~Ryan


