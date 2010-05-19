From: Albert Herranz <albert_herranz@yahoo.es>
Date: Wed, 19 May 2010 16:43:52 +0000
Subject: Re: [PATCH] fb_defio: fix for non-dirty ptes
Message-Id: <4BF41548.7010806@yahoo.es>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273697505-23421-1-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1273697505-23421-1-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

[CC'ing linux-fbdev]

On 05/19/2010 03:36 PM, Jenkins, Clive wrote:
> Hi Albert
> 
> I recently added deferred I/O to my framebuffer driver, and encountered
> the problem of pages getting stuck in a dirty state. A few days later
> your patch came out, and the problem appeared to be solved. However, I
> still get the problem when doing intensive writing to the FB, using the
> attached program fb_anim that I hacked up.
> 
> After copying a test image to the FB, I have been using the command
> with these arguments:
> 
>  fb_anim -x 13500000 400 480 -1 4 0
> 
> on a 800x480x16-bit FB, which does this:-
> 
>   set initial POSITION to centre screen
> loop:
>   draw a 400x480 rectangle at POSITION by XORing every pixel with -1
>   wait 13.5ms
>   wait 13.5ms
>   draw a 400x480 rectangle at POSITION by XOR (restore)
>   move POSITION by (4,0)
>   if not SIGINT goto loop
> 
> Note that my frame refresh perios is 13.5ms, so the rectangle moves 4
> pixels to the right every 2 frames.
> 
> If I then kill it with ^C, some or all of the rectangle remains XORed
> on the LCD screen, although the data in /dev/fb0 has been restored.
> If I then write a single pixel using
> 
>  echo a >/dev/fb0
> 
> the first page (2.56 lines of pixels) gets restored on the LCD. If I
> do
> 
>  cp /dev/fb0 t
>  cp t /dev/fb0 
> 
> the entire image is restored.
> 

From your description, it may be that the very last deferred io work iteration doesn't take place when your application exits.
This could happen if fb_deferred_io_cleanup() is called when the framebuffer device is closed. Currently, fb_deferred_io_cleanup() doesn't guarantee that a pending deferred io work takes place (the function cancels any pending deferred io work, and the work may get executed or not).

Does your framebuffer driver has a fb_release hook? And do you call fb_deferred_io_cleanup() from there?
If that's the case, does this patch solve the problem?

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -223,8 +223,7 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 	int i;
 
 	BUG_ON(!fbdefio);
-	cancel_delayed_work(&info->deferred_work);
-	flush_scheduled_work();
+	flush_delayed_work(&info->deferred_work);
 
 	/*  the list may have still some non-dirty pages at this point */
 	mutex_lock(&fbdefio->lock);

> I wondered if you could duplicate my findings on whatever platform(s)
> you have. I am using a Freescale MPC8536 (e500v2 core) with a custom
> ASIC (PCI device) containing an LCD controller which has graphics RAM
> attached. [Writing from the CPU through the ASIC into graphics RAM is
> slow, hence the need for FB in system RAM, and defio to graphics RAM
> being done using the 8536's DMA engine, which does efficient burst
> writes.]  I am using a 2.6.27 kernel with your patch applied, HZ%0,
> defio_delay=1 jiffy (4ms). After applying your patch, my normal
> application software worked normally, but my test program still had
> the problem, as described above.
> 

I'm working with a Nintendo Wii which has a non-standard framebuffer format (4:2:2 YCbCr). I'm using fb deferred io to provide a RGB framebuffer abstraction for applications to run unmodified (at the expense of some performance penalty).

I haven't experienced your problem, but I do not call fb_deferred_io_cleanup() until the driver remove hook. And I also use some fb hooks (fillrect, copyarea, imageblit, write) which fbcon uses to update the framebuffer.

> I would be grateful for any help solving this problem.
> 
> Thanks,
> Clive

Cheers,
Albert
