From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 Jan 2013 22:44:27 +0000
Subject: Re: [PATCH] goldfish: framebuffer
Message-Id: <20130125144427.9d1184d7.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130125153100.7317.23971.stgit@bob.linux.org.uk>
In-Reply-To: <20130125153100.7317.23971.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, 25 Jan 2013 15:31:17 +0000
Alan Cox <alan@linux.intel.com> wrote:

> Framebuffer support for the Goldfish emulator. This takes the Google emulator
> and applies the x86 cleanups as well as moving the blank methods to the usual
> Linux place and dropping the Android early suspend logic (for now at least, that
> can be looked at as Android and upstream converge). Dropped various oddities
> like setting MTRRs on a virtual frame buffer emulation...
> 
> With the drivers so far you can now boot a Linux initrd and have fun.

That looks nice and clean.  I'll grab it; hopefully for Florian to take
off my hands when he returns.


> Signed-off-by: Mike A. Chan <mikechan@google.com>
> Signed-off-by: Arve Hj__nnev__g <arve@android.com>
> [cleaned up to handle x86]
> Signed-off-by: Sheng Yang <sheng@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@intel.com>
> Signed-off-by: Xiaohui Xin <xiaohui.xin@intel.com>
> Signed-off-by: Jun Nakajima <jun.nakajima@intel.com>
> Signed-off-by: Bruce Beare <bruce.j.beare@intel.com>
> [ported to 3.4]
> Signed-off-by: Tom Keel <thomas.keel@intel.com>
> [cleaned up for style and 3.7, moved blank methods]
> Signed-off-by: Alan Cox <alan@linux.intel.com>

hm, it's unclear whether the [] comments apply to the line above or to
the line below.  I converted it to my usual form.  I hope I got it right!

[arve@android.com: cleaned up to handle x86]
[bruce.j.beare@intel.com: ported to 3.4]
[thomas.keel@intel.com: cleaned up for style and 3.7, moved blank methods]
Signed-off-by: Mike A. Chan <mikechan@google.com>
Signed-off-by: Arve Hj_nnev_g <arve@android.com>
Signed-off-by: Sheng Yang <sheng@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@intel.com>
Signed-off-by: Xiaohui Xin <xiaohui.xin@intel.com>
Signed-off-by: Jun Nakajima <jun.nakajima@intel.com>
Signed-off-by: Bruce Beare <bruce.j.beare@intel.com>
Signed-off-by: Tom Keel <thomas.keel@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>


