From: Nicolas Souchu <nsouch@free.fr>
Subject: Re: matrox ported to new framework?
Date: Sun, 25 May 2003 10:46:17 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030525104617.B2238@armor.free.fr>
References: <20030524195429.A2238@armor.free.fr> <20030524174846.49900.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from postfix3-2.free.fr ([213.228.0.169])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19JqvP-0002ew-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 25 May 2003 01:32:15 -0700
Received: from armor.fastether (nas-cbv-7-62-147-152-61.dial.proxad.net [62.147.152.61])
	by postfix3-2.free.fr (Postfix) with SMTP id 19C5AC10B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 25 May 2003 10:32:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20030524174846.49900.qmail@web14913.mail.yahoo.com>; from jonsmirl@yahoo.com on Sat, May 24, 2003 at 10:48:46AM -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sat, May 24, 2003 at 10:48:46AM -0700, Jon Smirl wrote:
> --- Nicolas Souchu <nsouch@free.fr> wrote:
> > Also, I have a AIW (Rage128) 32MB that is neither
> > supported by
> > 2.4.9 nor by 2.5.69. Any hint?
> > 
> Not all of the Rage128 PCI ids are in the id table.
> Just try adding all of the ones from the kernel
> include file. I have yet to find one that didn't work.
> I believe the ID for the AGP AIW is missing from the
> driver's table.

This is not what I meant. The id is already in the table
but when booting with the framebuffer activated, I get
garbage on the screen.

The detail is:

none1@pci1:0:0: class=0x030000 card=0x00281002 chip=0x52461002 rev=0x00 hdr=0x00
    vendor   = 'ATI Technologies'
    device   = 'Rage 128 GL AGP 2x Rage Fury 16/32MB'
    class    = display
    subclass = VGA

> I have the PCI AIW 1002:5044. Something is strange
> with the driver on 2.5.69. It will work if compiled
> in, but it won't initialize with a modprobe. There is

I use the driver only wired in the kernel.

You certainly need more inputs to digg. How should I produce debug output?

Nicholas

-- 
Nicholas Souchu - nsouch@free.fr


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
