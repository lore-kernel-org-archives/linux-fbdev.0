From: "S.A.Abbad" <abuse@axion.demon.nl>
Subject: Re: High resolution console gets garbled when X running at higher resolution then the console.
Date: Sat, 18 Oct 2003 20:34:52 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031018183452.GA1462@axion.demon.nl>
References: <20031017193934.GA1921@axion.demon.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AB6xZ-0005pt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 23:22:37 -0700
Received: from axion.demon.nl ([195.173.231.39] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AAvwt-0000B7-7c
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 18 Oct 2003 11:37:56 -0700
Content-Disposition: inline
In-Reply-To: <20031017193934.GA1921@axion.demon.nl>
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
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net, test@axion.demon.nl

Hi all,

Earlier today I used a wrong mail adress to send mail to this mailing
list. I am subscribed as fbdev@axion.demon.nl and I send the mail as 
kernel@axion.demon.nl, after which I recieved a huge amount of '"Redmond"-so-
called-update-worm-and-patches' etc, etc mails to my kernel@axion.demon.nl, has
anyone else experienced this after sending with a non subscribed mail adress ?

On Fri, Oct 17, 2003 at 09:39:34PM +0200, Monchi Abbad wrote:
> Distribution: Slackware 9.1
> Hardware Environment: Matrox Millenium II AMD Athlon 1.1 ghz 512MB ram
> 
> Software Environment: kernel fbdev console + XFree86 4.3
> 
> kernel proc version:
> Linux version 2.6.0-test7 (root@axion) (gcc version 3.2.3) #1 Thu Oct 9 11:16:09 CEST 2003
> 
> Problem Description: High resolution console gets garbled when X running at
> higher resolution then the console
> 
> Steps to reproduce:
> Compile kernel with Matroxfb and use video option 'matroxfb:vesa:0x193' when
> booting.
> Then start an X session, with mga driver in stead of matroxfb driver, make sure the
> X-session is running at a higher resolution then the console, and switch from
> the X-session to a console.
> Now run ls or simply clear screen.
> 
> To go back to a normal console simple run X with the same resolution as the
> console. ( using the matroxfb driver ).
After updating to linux-2.6.0-test8 this problem got solved, now the console
only scrolls extremely slow under mentioned circumstances.

Monchi.
--


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
