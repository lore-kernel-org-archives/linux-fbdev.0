From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 07:03:25 +0000
Subject: Re: [Patch V2] video: fix some comments in drivers/video/console/vgacon.c
Message-Id: <20110125070324.GG11673@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295418242-19859-1-git-send-email-amwang@redhat.com>
In-Reply-To: <1295418242-19859-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amerigo Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Yannick Heneault <yheneaul@matrox.com>, Matthew Garrett <mjg@redhat.com>, linux-fbdev@vger.kernel.org

On Wed, Jan 19, 2011 at 02:24:02PM +0800, Amerigo Wang wrote:
> Now vgacon_scrollback_startup() uses slab, not bootmem,
> the comment above it is obsolete, so does __init_refok.
> 
> Signed-off-by: WANG Cong <amwang@redhat.com>
> 
Applied, thanks.
