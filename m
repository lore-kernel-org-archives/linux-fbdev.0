From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Tue, 14 Jul 2020 10:27:46 +0000
Subject: Re: [PATCH] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
 <CGME20200714072231eucas1p17c53f0a661346ebfd316ebd5796ca346@eucas1p1.samsung.com>
 <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
In-Reply-To: <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On 2020/07/14 16:22, Bartlomiej Zolnierkiewicz wrote:
> How does this patch relate to:
> 
> 	https://marc.info/?l=linux-fbdev&m9415024816722&w=2
> 
> ?
> 
> It seems to address the same issue, I've added George and Dan to Cc:.

George Kennedy's patch does not help for my case.

You can try a.out built from

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/fb.h>

int main(int argc, char *argv[])
{
        const int fd = open("/dev/fb0", O_ACCMODE);
        struct fb_var_screeninfo var = { };
        ioctl(fd, FBIOGET_VSCREENINFO, &var);
        var.xres = var.yres = 16;
        ioctl(fd, FBIOPUT_VSCREENINFO, &var);
        return 0;
}
----------

with a fault injection patch

----------
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1214,6 +1214,10 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 
 	if (new_screen_size > KMALLOC_MAX_SIZE)
 		return -EINVAL;
+	if (!strcmp(current->comm, "a.out")) {
+		printk(KERN_INFO "Forcing memory allocation failure.\n");
+		return -ENOMEM;
+	}
 	newscreen = kzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
----------

. What my patch workarounds is cases when vc_do_resize() did not update vc->vc_{cols,rows} .
Unless vc->vc_{cols,rows} are updated by vc_do_resize() in a way that avoids integer underflow at

	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
	unsigned int bh = info->var.yres - (vc->vc_rows*ch);

, this crash won't go away.

[   39.995757][ T2788] Forcing memory allocation failure.
[   39.996527][ T2788] BUG: unable to handle page fault for address: ffffa9d180d7b000
[   39.996529][ T2788] #PF: supervisor write access in kernel mode
[   39.996530][ T2788] #PF: error_code(0x0002) - not-present page
[   39.996531][ T2788] PGD 13a48c067 P4D 13a48c067 PUD 13a48d067 PMD 1324e4067 PTE 0
[   39.996547][ T2788] Oops: 0002 [#1] SMP
[   39.996550][ T2788] CPU: 2 PID: 2788 Comm: a.out Not tainted 5.8.0-rc5+ #757
[   39.996551][ T2788] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   39.996555][ T2788] RIP: 0010:bitfill_aligned+0x87/0x120 [cfbfillrect]
