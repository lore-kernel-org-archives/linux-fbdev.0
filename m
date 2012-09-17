From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 17 Sep 2012 18:21:08 +0000
Subject: Re: [PATCH 6/7 v2] HID: picoLCD: drop version check during probe
Message-Id: <20120917202108.3e39dedb@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home>
	<20120730213859.063173c1@neptune.home>
	<alpine.LNX.2.00.1208151015220.7026@pobox.suse.cz>
	<20120819185631.3a984aa4@neptune.home>
In-Reply-To: <20120819185631.3a984aa4@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Jiri,

You seem not to have applied this one yet (it doesn't show up in picolcd
branch).

Could you please apply it?
(or did I miss locking changes making it obsolete?)

Thanks,
Bruno

On Sun, 19 August 2012 Bruno Prémont <bonbons@linux-vserver.org> wrote:
> Commit 4ea5454203d991ec85264f64f89ca8855fce69b0
> [HID: Fix race condition between driver core and ll-driver] introduced
> new locking around probe/remove functions that prevents any report/reply
> from hardware to reach driver until it returned from probe.
> 
> As such, the ask-reply way to checking picoLCD firmware version during
> probe is bound to timeout and let probe fail.
> 
> Drop the check to let driver successfully probe again (until locking issues
> are resolved allowing to reinstate the check).
> 
> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> ---
> 
> Changes since v1:
> - drop version check during probe instead of commenting it out.
> 
> 
>  drivers/hid/hid-picolcd_core.c |   18 ------------------
>  1 files changed, 0 insertions(+), 18 deletions(-)
