From: James Simmons <jsimmons@infradead.org>
Subject: Re: PPC64 prom logo
Date: Tue, 25 Mar 2003 18:17:13 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303251816380.4568-100000@phoenix.infradead.org>
References: <15999.27242.738276.356568@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xszf-0000Um-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 10:17:51 -0800
In-Reply-To: <15999.27242.738276.356568@nanango.paulus.ozlabs.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC64 Development <linuxppc64-dev@lists.linuxppc.org>


> Actually, you should use RELOC on a variable (an L-value) or PTRRELOC
> on a value (an R-value), so it should look like this:
> 
> 	clut = PTRRELOC(RELOC(logo_linux_clut224.clut));
> 	for (i = 0; i < RELOC(logo_linux_clut224.clutsize); i++, clut += 3)
> 
> etc.  I'll test on an actual ppc64 box and send a tested patch.

Do you have a functional and tested patch?





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
