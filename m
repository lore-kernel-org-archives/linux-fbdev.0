From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
	Metronomefb v3
Date: Thu, 28 Feb 2008 13:54:12 -0500
Message-ID: <45a44e480802281054o7373f6aayb03ded3a5b5d4f57@mail.gmail.com>
References: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
	<20080223000700.dc19a7e5.akpm@linux-foundation.org>
	<45a44e480802230317t408273e0vf62e21279699cd86@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUntW-00059f-IQ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Feb 2008 10:54:14 -0800
Received: from wf-out-1314.google.com ([209.85.200.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUntV-00062u-6n
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Feb 2008 10:54:14 -0800
Received: by wf-out-1314.google.com with SMTP id 28so3310243wff.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 28 Feb 2008 10:54:12 -0800 (PST)
In-Reply-To: <45a44e480802230317t408273e0vf62e21279699cd86@mail.gmail.com>
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

On Sat, Feb 23, 2008 at 6:17 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Sat, Feb 23, 2008 at 3:07 AM, Andrew Morton
>  <akpm@linux-foundation.org> wrote:
>
> > On Mon, 18 Feb 2008 08:41:26 -0500 Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>  >
>  >
>  >
>  > > +static int metronome_display_cmd(struct metronomefb_par *par)
>  >  > +{
>  >  > +     int i;
>  >  > +     u16 cs;
>  >  > +     u16 opcode;
>  >  > +     static u8 borderval;
>  >  > +     u8 *ptr;
>  >  > +
>  >  > +     /* setup display command
>  >  > +     we can't immediately set the opcode since the controller
>  >  > +     will try parse the command before we've set it all up
>  >  > +     so we just set cs here and set the opcode at the end */
>  >  > +
>  >  > +     ptr = par->metromem;
>  >  > +
>  >  > +     if (par->metromem_cmd->opcode == 0xCC40)
>  >  > +             opcode = cs = 0xCC41;
>  >  > +     else
>  >  > +             opcode = cs = 0xCC40;
>  >  > +
>  >  > +     /* set the args ( 2 bytes ) for display */
>  >  > +     i = 0;
>  >  > +     par->metromem_cmd->args[i] =    1 << 3 /* border update */
>  >  > +                                     | ((borderval++ % 4) & 0x0F) << 4
>  >  > +                                     | (par->frame_count - 1) << 8;
>  >  > +     cs += par->metromem_cmd->args[i++];
>  >  > +
>  >  > +     /* the rest are 0 */
>  >  > +     memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
>  >  > +
>  >  > +     par->metromem_cmd->csum = cs;
>  >  > +     par->metromem_cmd->opcode = opcode; /* display cmd */
>  >  > +
>  >  > +     i = wait_event_interruptible_timeout(par->waitq, (GPLR1 & 0x01), HZ);
>  >  > +     return i;
>  >  > +}
>  >
>  >  wait_event_interruptible_timeout() will return immediately if the calling
>  >  task has a signal pending.  Will this ause the driver to malfunction?
>  >
>
>  Not sure yet. Will check.

The typical path for display_cmd is through the defio callback via the
mmap user. In this scenario, it is called from keventd rather than the
mmap user's context. Alternatively, display_cmd is called from the
write()/cfb path in the context of the user process. In either
scenario, a pending signal would cause us to return. The display
command would have been set telling the metronome controller to update
the display but the process would not be wait-ed. The implication of
this is that we could issue a new display cmd or do display work prior
to completion of the current display cmd. If we write to the
framebuffer during this time, the effect is that the checksum on the
transferred framebuffer data will not match and thus the controller
ignores the original display cmd, and will thus only process the last
display cmd which is the desired result anyway. Therefore, I think
this is okay.

The remaining *_cmd functions that use
wait_event_interruptible_timeout are all called from init_regs via
probe() so any signal results in the allocated resources being freed
by the failout in probe() and the error being returned which seems
okay. But after thinking about it, I'm changing these to use
wait_event_timeout since it doesn't make sense to be interruptible at
those junctures.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
