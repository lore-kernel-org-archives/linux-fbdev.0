From: Dave Airlie <airlied@gmail.com>
Date: Tue, 14 Dec 2010 20:18:34 +0000
Subject: Re: Force FB off
Message-Id: <AANLkTimEh+2rEFuq7q+wLcfHw_UKKHVipC0t7mFwSzx8@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.01.1012141840130.18577@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1012141840130.18577@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Dec 15, 2010 at 3:41 AM, Jan Engelhardt <jengelh@medozas.de> wrote:
> Hi,
>
>
> booting with video=off nor video=i915:off has any effect on skipping FB.
> What is the correct option to stop FB from taking over my boot consoles?

For KMS its not fb taking over its the drm i915 driver, nomodeset will stop it
however X will no longer work since it relies on the kernel driver.

Dave.
