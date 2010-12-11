From: Matt Turner <mattst88@gmail.com>
Date: Sat, 11 Dec 2010 22:44:26 +0000
Subject: Re: intelfb refuses to load
Message-Id: <AANLkTimMkee1-=qLQezBoq=4DNQDJ5mpFKmaoEn4VOZ9@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101211221325.GA1954@elf.ucw.cz>
In-Reply-To: <20101211221325.GA1954@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, mbroemme@plusserver.de

On Sat, Dec 11, 2010 at 10:13 PM, Pavel Machek <pavel@ucw.cz> wrote:

You want CONFIG_DRM_I915 and not CONFIG_FB_INTEL. The old framebuffer
driver should not be used in conjunction with xf86-video-intel.

Matt
