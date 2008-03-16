From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Subject: Re: [REGRESSION] i810fb: console switch causes
	pixel waste since 2.6.25-rc?
Date: Sun, 16 Mar 2008 11:25:39 +0100
Message-ID: <200803161125.39748.stefan.bauer@cs.tu-chemnitz.de>
References: <200803160133.19948.stefan.bauer@cs.tu-chemnitz.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jaq3w-0005gM-Ls for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 03:25:56 -0700
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jaq3v-0004YG-6Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 03:25:56 -0700
Received: from v0026.v.pppool.de ([89.57.0.38] helo=noname)
	by john.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66) (envelope-from <stefan.bauer@informatik.tu-chemnitz.de>)
	id 1Jaq3q-0007rR-PI for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 11:25:51 +0100
In-Reply-To: <200803160133.19948.stefan.bauer@cs.tu-chemnitz.de>
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
To: linux-fbdev-devel@lists.sourceforge.net

Am Sonntag, 16. M=E4rz 2008 01:33 schrieb Stefan Bauer:
> I tried a bisect on Linus' tree, but couldn't finish yet because I detect=
ed
> an intermediate state where no fb works at all. dmesg says
> 	agpgart: unable to get memory for graphics translation table
> which causes i810fb to say
> 	i810fb_alloc_fbmem: cannot acquire agpgart
> [...]
> I will continue tomorrow figuring out since when agpgart is broken and
> since when it works again.

commit 266b9f8727976769e2ed2dad77ac9295f37e321e
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Jan 30 13:34:06 2008 +0100

    x86: fix ioremap RAM check
    =

    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

...broke my agpgart.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
