From: Scot Doyle <lkml14@scotdoyle.com>
Date: Sat, 03 Oct 2015 05:12:15 +0000
Subject: Re: [BUG] RCU stall in cursor_timer_handler
Message-Id: <alpine.DEB.2.11.1510030350110.20774@local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2505354.BllTl4uaOg@new-mexico>
In-Reply-To: <2505354.BllTl4uaOg@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alistair Popple <alistair@popple.id.au>
Cc: linux-fbdev@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org, airlied@redhat.com, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sat, 3 Oct 2015, Alistair Popple wrote:
> Hi,
> 
> We have been intermittently seeing the below RCU stall at boot on a 
> PPC64LE 4.2.1 kernel which has been preventing the system from booting.
> Further investigation indicates that ops->cur_blink_jiffies is 
> potentially being used uninitialised in cursor_timer_handler():
> 
> static void cursor_timer_handler(unsigned long dev_addr)
> {
> 	struct fb_info *info = (struct fb_info *) dev_addr;
> 	struct fbcon_ops *ops = info->fbcon_par;
> 
> 	queue_work(system_power_efficient_wq, &info->queue);
> 	mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
> }
...


Hi Alistair, thanks so much for the detailed report. Does this patch 
correct the stalls?


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 1aaf893..92f3949 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1093,6 +1093,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 		con_copy_unimap(vc, svc);
 
 	ops = info->fbcon_par;
+	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 	p->con_rotate = initial_rotation;
 	set_blitting_type(vc, info);
 
