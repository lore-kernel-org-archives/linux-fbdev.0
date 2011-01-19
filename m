From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 19 Jan 2011 06:02:57 +0000
Subject: Re: [Patch] video: remove pointless comments in drivers/video/console/vgacon.c
Message-Id: <20110119060257.GA12205@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295416803-17651-1-git-send-email-amwang@redhat.com>
In-Reply-To: <1295416803-17651-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amerigo Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Yannick Heneault <yheneaul@matrox.com>, Matthew Garrett <mjg@redhat.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

On Wed, Jan 19, 2011 at 02:00:02PM +0800, Amerigo Wang wrote:
> Now vgacon_scrollback_startup() uses slab, not bootmem,
> so that comment is obsolete, the rest are useless.
> 
> Signed-off-by: WANG Cong <amwang@redhat.com>
> 
If you're going to do this then at least follow through and do the rest
of it. The comment is no longer applicable, but then neither is the
__init_refok annotation. Killing off the comment explaining why something
is (or was there) without killing off the thing that is referenced by the
comment is not terribly productive.
