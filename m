From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 25 Jan 2013 15:55:37 +0000
Subject: Re: [PATCH] fbcon: fix locking harder
Message-Id: <CAKMK7uEe7J=yKWO4ARSy_jMbAkGFX7LSs3Z5aEuMuNE=hx2Gzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359078224-3327-1-git-send-email-airlied@gmail.com>
In-Reply-To: <1359078224-3327-1-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.sf.net

On Fri, Jan 25, 2013 at 2:43 AM, Dave Airlie <airlied@gmail.com> wrote:
> Okay so Alan's patch handled the case where there was no registered fbcon,
> however the other path entered in set_con2fb_map pit.
>
> In there we called fbcon_takeover, but we also took the console lock in a couple
> of places. So push the console lock out to the callers of set_con2fb_map,
>
> this means fbmem and switcheroo needed to take the lock around the fb notifier
> entry points that lead to this.
>
> This should fix the efifb regression seen by Maarten.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/vga/vga_switcheroo.c |  3 +++
>  drivers/video/console/fbcon.c    | 11 ++++++++---
>  drivers/video/fbmem.c            |  2 ++
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
[cut]

>         ret = vgasr_priv.handler->switchto(new_client->id);
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index 2aef9ca..2e2d959 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -842,6 +842,8 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
>   *
>   *     Maps a virtual console @unit to a frame buffer device
>   *     @newidx.
> + *
> + *     This should be called with the console lock held.
>   */
>  static int set_con2fb_map(int unit, int newidx, int user)
>  {

What about throwing a WARN_CONSOLE_UNLOCKED(); in here to make sure
this new rule is obeyed?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
