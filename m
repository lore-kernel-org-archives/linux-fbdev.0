From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Mar 2011 03:32:34 +0000
Subject: Re: [PATCH] fbcon: Remove unused 'display *p' variable from fb_flashcursor()
Message-Id: <20110329033234.GD7338@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110324205052.GA4238@swordfish> <20110328091846.485dfef0@jbarnes-desktop>
In-Reply-To: <20110328091846.485dfef0@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 28, 2011 at 09:18:46AM -0700, Jesse Barnes wrote:
> On Thu, 24 Mar 2011 22:50:52 +0200
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 
> > fbcon: Remove unused 'display *p' variable from fb_flashcursor()
> > 
> > Signed-of-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> 
> Looks fine to me, is Paul the lucky owner of fbdev now?
> 
Seems so. I'll roll the patch in with the next batch of fixes.
