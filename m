From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Jun 2011 07:26:48 +0000
Subject: Re: [PATCH 0/4] fbdev: au1200fb updates
Message-Id: <20110614072648.GF17891@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307719384-23702-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1307719384-23702-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Jun 10, 2011 at 05:23:00PM +0200, Manuel Lauss wrote:
> Here are 4 updates to the au1200fb codebase to get it to work and compile
> again, also with PM enabled.
> 
> Run and PM-tested on DB1200 and DB1300.
> 
> Manuel Lauss (4):
>   au1200fb: use framebuffer_alloc()
>   au1200fb: fixup PM
>   au1200fb: make number of windows configurable at load time.
>   au1200fb: switch to FB_SYS helpers
> 
>  drivers/video/Kconfig    |    7 +-
>  drivers/video/au1200fb.c |  285 ++++++++++++++++++++--------------------------
>  2 files changed, 128 insertions(+), 164 deletions(-)
> 
This is quite a bit bigger than something I would generally like to push
along for -rc4 timing. Patches 1, 2, and 4 all technically qualify as
fixes, so those are workable. 3/4 on the other hand looks like a feature
enhancement that you're either dependent on for your new platform or a
cleanup to move off of the previous hardcoding (in either case not really
-rc4 material).

On the other hand, if you don't require any of these for -rc4 then I can
just apply the whole batch aimed at the next merge window.
