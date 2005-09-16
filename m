From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: save_vga question
Date: Sat, 17 Sep 2005 05:15:51 +0800
Message-ID: <432B3607.7000307@gmail.com>
References: <432AEB03.5020009@ums.usu.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGNZ9-00083u-3c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 14:16:15 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EGNZ7-0006nk-JX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 14:16:15 -0700
Received: by zproxy.gmail.com with SMTP id 14so45130nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 14:16:07 -0700 (PDT)
In-Reply-To: <432AEB03.5020009@ums.usu.ru>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>

Alexander E. Patrakov wrote:
> Hello,
> 
> I am currently developing a framebuffer driver for S3 Trio 3D/2X cards.
> Well, I have a working non-accelerated driver and I am going to submit
> it later, but serious code cleanup is needed now.
> 
> I see that other fb drivers save the card state on the first open and
> restore it when the open count reaches zero. I also implemented this,
> but certainly not in the best way: by writing custom functions that save
> all CRTC, Sequencer, Graphics and Attribute VGA-like registers. I think
> that using vga_save is better here (because it also saves e.g. fonts),
> but there is a problem. Some registers of the card lock/unlock other
> registers. So the code in my custom save function looks like this (e.g.
> for Sequencer registers):
> 
> static void save_state(struct s3d2xfb_par * par)
> {
>    /* ... */
>    u8 sr08;
>    /* ... */
>    sr08 = readSR(par, 0x08);
>    writeSR(par, 0x06, 0x08); /* Unlock SR10-15, otherwise they are
> unreadable */
>    for (i=0; i<sizeof(par->saved_SR); i++)
>       par->saved_SR[i] = readSR(par, i);
>    par->saved_SR[0x08] = sr08;
>    writeSR(par, sr08, 0x08);
>    /* ... */
> }
> 
> and the corresponding code in the restore function:
> 
> static void restore_state(struct fb_info *info)
> {
>    int i;
>    struct s3d2xfb_par *par = (struct s3d2xfb_par *) info->par;
>    s3d2xfb_unlock_regs(info); /* includes a writeSR(par, sr08, 0x08); */
>    /* ... */
>    for (i=0; i<sizeof(par->saved_SR); i++)
>       if (i!=0x08)
>          writeSR(par, par->saved_SR[i], i);
>    /* ... */
>    writeSR(par, par->saved_SR[0x08], 0x08);
>    /* ... */
> }
> 
> What's the recommended way of using the save_vga() function when such
> locking problems exist? Is it acceptable to manually save the state
> necessary to restore locking (SR08 in the example above), unlock
> everything, and then save the "unlocked" state with vga_save?
> 

save_vga will only save/restore standard VGA registers, ie, in the case of the
sequencers, SR00 - SR04.  Any registers above those are extended VGA
registers, ie, their purpose depend from hardware to hardware.

So you can do it 2 ways:  One, you can save all standard VGA registers using
save_vga and save the extended VGA registers using your own function, unlocking
the locked registers, if necessary.

Another way is to set state->num_seq = 16, unlock all locked registers, then
call save_vga.

I prefer doing the first, but it's up to you.  In both case, I think it's
important to save the registers in their "unlocked" state.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
