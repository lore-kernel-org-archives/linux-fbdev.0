From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: High resolution console gets garbled when X running at higher resolution then the console.
Date: Sun, 19 Oct 2003 20:32:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031019183212.GE2566@vana.vc.cvut.cz>
References: <20031017193934.GA1921@axion.demon.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ABJBy-00023J-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Oct 2003 12:26:18 -0700
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1ABIOi-0004FW-Ge
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Oct 2003 11:35:24 -0700
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
To: Monchi Abbad <kernel@axion.demon.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net

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

Complain to XFree folks. They continuously reprogram accelerator while X are running, so
only possible configuration with DRI enabled is same resolution on the console and in X
(including color depth).
 
> Steps to reproduce:
> Compile kernel with Matroxfb and use video option 'matroxfb:vesa:0x193' when
> booting.
> Then start an X session, with mga driver in stead of matroxfb driver, make sure the

mga has nothing to do with matroxfb, so I have no idea what you switched where...

> X-session is running at a higher resolution then the console, and switch from
> the X-session to a console.
> Now run ls or simply clear screen.
> 
> To go back to a normal console simple run X with the same resolution as the
> console. ( using the matroxfb driver ).

Besides that: if you are using stock 2.6.0 kernels, I support only one configuration:
no mode change after startup, and fbdev XFree driver, running in same resolution as
console. 

If you have applied my fbcon patches from ftp://platan.vc.cvut.cz/pub/linux/matrox-latest,
I also support any console resolution and any X resolution if you do not use DRI, or
same resolution in X and on console, with DRI enabled. You can use DRI and different 
resolutions only if you disable acceleration on all consoles.

							Best regards,
								Petr Vandrovec



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
