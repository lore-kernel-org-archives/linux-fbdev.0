From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: save_vga question
Date: Fri, 16 Sep 2005 21:55:47 +0600
Message-ID: <432AEB03.5020009@ums.usu.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGIdt-0002Vp-3q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 09:00:49 -0700
Received: from relay4.usu.ru ([194.226.235.39])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EGIdp-0006TW-JD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 09:00:49 -0700
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 6B90616B72
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 22:00:45 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id F19B016B72
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 22:00:44 +0600 (YEKST)
Received: from localhost.usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id DB35CA7A32
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 22:00:36 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 830C5A7A2F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 22:00:36 +0600 (YEKST)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hello,

I am currently developing a framebuffer driver for S3 Trio 3D/2X cards. 
Well, I have a working non-accelerated driver and I am going to submit 
it later, but serious code cleanup is needed now.

I see that other fb drivers save the card state on the first open and 
restore it when the open count reaches zero. I also implemented this, 
but certainly not in the best way: by writing custom functions that save 
all CRTC, Sequencer, Graphics and Attribute VGA-like registers. I think 
that using vga_save is better here (because it also saves e.g. fonts), 
but there is a problem. Some registers of the card lock/unlock other 
registers. So the code in my custom save function looks like this (e.g. 
for Sequencer registers):

static void save_state(struct s3d2xfb_par * par)
{
    /* ... */
    u8 sr08;
    /* ... */
    sr08 = readSR(par, 0x08);
    writeSR(par, 0x06, 0x08); /* Unlock SR10-15, otherwise they are 
unreadable */
    for (i=0; i<sizeof(par->saved_SR); i++)
       par->saved_SR[i] = readSR(par, i);
    par->saved_SR[0x08] = sr08;
    writeSR(par, sr08, 0x08);
    /* ... */
}

and the corresponding code in the restore function:

static void restore_state(struct fb_info *info)
{
    int i;
    struct s3d2xfb_par *par = (struct s3d2xfb_par *) info->par;
    s3d2xfb_unlock_regs(info); /* includes a writeSR(par, sr08, 0x08); */
    /* ... */
    for (i=0; i<sizeof(par->saved_SR); i++)
       if (i!=0x08)
          writeSR(par, par->saved_SR[i], i);
    /* ... */
    writeSR(par, par->saved_SR[0x08], 0x08);
    /* ... */
}

What's the recommended way of using the save_vga() function when such 
locking problems exist? Is it acceptable to manually save the state 
necessary to restore locking (SR08 in the example above), unlock 
everything, and then save the "unlocked" state with vga_save?

-- 
Alexander E. Patrakov


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
