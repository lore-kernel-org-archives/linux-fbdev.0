From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: [PATCH resend] aty rage 3d mobility m1
Date: Sun, 25 May 2003 13:19:18 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200305251319.18941.alex.kern@gmx.de>
References: <200305192313.02275.alex.kern@gmx.de> <20030523235137.A47510@armor.free.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19JtXi-000220-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 25 May 2003 04:19:58 -0700
In-Reply-To: <20030523235137.A47510@armor.free.fr>
Content-Disposition: inline
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
To: Nicolas Souchu <nsouch@free.fr>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Samstag, 24. Mai 2003 01:51 schrieb Nicolas Souchu:
> On Mon, May 19, 2003 at 11:13:02PM +0200, Alexander Kern wrote:
> > Hello,
> >
> > here is it, one large, but minimal intrusive in my eyes.
> > Tested on ARMADA 15" mobility AGP 1400x1050 and Desktop PC K7S5A + ATI
> > Rage IIc and ATI Rage Pro
>
> Hi,
>
> I've tried 3 of atyfb drivers: 2.4.9, 2.5.68 then this one.
>
> None gives satisfaction to my Mobility board. I browsed the web,
> saw some guys having the problem of the black screen (in early 2000)...
>
> That chipset (0x4d4c integratied in ATI AGP desktop) is known to be hard to
> init?
>
> Any hint appreciated :)
>
> Thanks,
>
> Nicholas

Hallo Nicholas,

what exactly is your hardware, best do 
lspci -vv -d 1002:
lspci -vv -d 1002: -n
and send output to me. What is your problem, screen steel black, but machine 
works(you can reboot it with ctrl+alt+del) or it crash. If it works, but you 
don't seee anymore, you can switch debug on.
In /usr/src/linux/drivers/video/atyfb_base.c change

#undef DEBUG

in

#define DEBUG

your boot.msg or after reboot boot.omsg will contain more info

Thanks for testing

Alex



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
