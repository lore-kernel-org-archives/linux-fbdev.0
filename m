From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
	Metronomefb v3
Date: Sat, 23 Feb 2008 06:17:42 -0500
Message-ID: <45a44e480802230317t408273e0vf62e21279699cd86@mail.gmail.com>
References: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
	<20080223000700.dc19a7e5.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JSsO0-0000Rl-Oy for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 03:17:44 -0800
Received: from wf-out-1314.google.com ([209.85.200.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JSsNz-0000a2-10
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 03:17:44 -0800
Received: by wf-out-1314.google.com with SMTP id 28so413071wff.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 23 Feb 2008 03:17:42 -0800 (PST)
In-Reply-To: <20080223000700.dc19a7e5.akpm@linux-foundation.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org

On Sat, Feb 23, 2008 at 3:07 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 18 Feb 2008 08:41:26 -0500 Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>
>
>  > +int load_waveform(u8 *mem, u8 *metromem, int m, int t, u8 *frame_count)
>
>  This didn't need to be a global symbol.  It would be a poorly chosen
>  idenfitier if it was global.

Agreed. Sorry, I really should have caught that as I've made this
mistake before. Will fix.

>  > +
>  > +     /* check waveform temperature table address checksum */
>  > +     tta = *((int *) (mem + wmta + m*4)) & 0x00FFFFFF;
>
>  Does this code have any unaligned-access issues on non-x86?
>

Agreed. I'll put in some checks to make sure that the indices align
and also range checking to make sure we do not access beyond the
buffer.

> >
>  > +/* this technique copied from pxafb */
>  > +static void metronome_disable_lcd_controller(struct metronomefb_par *par)
>  > +{
>  > +     DECLARE_WAITQUEUE(wait, current);
>  > +
>  > +     set_current_state(TASK_UNINTERRUPTIBLE);
>  > +     add_wait_queue(&par->waitq, &wait);
>  > +
>  > +     LCSR = 0xffffffff;      /* Clear LCD Status Register */
>  > +     LCCR0 &= ~LCCR0_LDM;    /* Enable LCD Disable Done Interrupt */
>  > +     LCCR0 |= LCCR0_DIS;     /* Disable LCD Controller */
>  > +
>  > +     schedule_timeout(200 * HZ / 1000);
>  > +     remove_wait_queue(&par->waitq, &wait);
>  > +}
>
>  I assume that if the schedule_timeout() actually times out, we have an
>  error condition?  Should it be reported?

Not sure yet, I'll check.

> > +static int metronome_display_cmd(struct metronomefb_par *par)
>  > +{
>  > +     int i;
>  > +     u16 cs;
>  > +     u16 opcode;
>  > +     static u8 borderval;
>  > +     u8 *ptr;
>  > +
>  > +     /* setup display command
>  > +     we can't immediately set the opcode since the controller
>  > +     will try parse the command before we've set it all up
>  > +     so we just set cs here and set the opcode at the end */
>  > +
>  > +     ptr = par->metromem;
>  > +
>  > +     if (par->metromem_cmd->opcode == 0xCC40)
>  > +             opcode = cs = 0xCC41;
>  > +     else
>  > +             opcode = cs = 0xCC40;
>  > +
>  > +     /* set the args ( 2 bytes ) for display */
>  > +     i = 0;
>  > +     par->metromem_cmd->args[i] =    1 << 3 /* border update */
>  > +                                     | ((borderval++ % 4) & 0x0F) << 4
>  > +                                     | (par->frame_count - 1) << 8;
>  > +     cs += par->metromem_cmd->args[i++];
>  > +
>  > +     /* the rest are 0 */
>  > +     memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
>  > +
>  > +     par->metromem_cmd->csum = cs;
>  > +     par->metromem_cmd->opcode = opcode; /* display cmd */
>  > +
>  > +     i = wait_event_interruptible_timeout(par->waitq, (GPLR1 & 0x01), HZ);
>  > +     return i;
>  > +}
>
>  wait_event_interruptible_timeout() will return immediately if the calling
>  task has a signal pending.  Will this ause the driver to malfunction?
>

Not sure yet. Will check.

>
>  > +/*
>  > + * this is the slow path from userspace. they can seek and write to
>  > + * the fb.
>  > + */
>  > +static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
>  > +                             size_t count, loff_t *ppos)
>  > +{
>  > +     unsigned long p;
>  > +     int err = -EINVAL;
>  > +     struct metronomefb_par *par;
>  > +     unsigned int xres;
>  > +     unsigned int fbmemlength;
>  > +
>  > +     p = *ppos;
>  > +     par = info->par;
>  > +     xres = info->var.xres;
>  > +     fbmemlength = (xres * info->var.yres);
>  > +
>  > +     if (p > fbmemlength)
>  > +             return -ENOSPC;
>  > +
>  > +     err = 0;
>  > +     if ((count + p) > fbmemlength) {
>  > +             count = fbmemlength - p;
>  > +             err = -ENOSPC;
>  > +     }
>  > +
>  > +     if (count) {
>  > +             char *base_addr;
>  > +
>  > +             base_addr = (char __force *)info->screen_base;
>  > +             count -= copy_from_user(base_addr + p, buf, count);
>  > +             *ppos += count;
>  > +             err = -EFAULT;
>  > +     }
>
>  This looks odd.  We ignore the return value from copy_from_user(), which
>  will wreck *ppos.  We also always return -EFAULT.

Oops. Will fix.

>
>  I don't think I'll apply this one yet.
>

Yes, I agree. :-) I will fix the problems. I am grateful for the feedback.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
