From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 27 May 2015 13:00:46 +0000
Subject: Re: [PATCH] fbcon: Fix incorrect fbcon_del_cursor_timer calls.
Message-Id: <20150527130046.GB28150@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201505272142.JGF00513.VJHOOLMOFSQFtF@I-love.SAKURA.ne.jp>
In-Reply-To: <201505272142.JGF00513.VJHOOLMOFSQFtF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, May 27, 2015 at 09:42:27PM +0900, Tetsuo Handa wrote:
> >From f4976c5f9638633eb31a1c6dbe78861abf5c79c1 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 27 May 2015 21:36:38 +0900
> Subject: [PATCH] fbcon: Fix incorrect fbcon_del_cursor_timer calls.

Why is this all here?

Anyway, I _just_ committed this same change, from someone else, to fix
this, sorry.  It will be in the next linux-next release.

greg k-h
