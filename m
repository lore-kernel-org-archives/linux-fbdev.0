From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: tdfx & multiple voodoo cards : supposed to work ?
Date: Wed, 29 Oct 2003 19:25:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031029182532.GA1662@dreamland.darkstar.lan>
References: <20031029093653.GA4626@iliana>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEv13-00025G-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 10:25:57 -0800
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AEv10-0000qZ-NC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 10:25:54 -0800
Content-Disposition: inline
In-Reply-To: <20031029093653.GA4626@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Wed, Oct 29, 2003 at 10:36:53AM +0100, Sven Luther ha scritto: 
> Hello,
> 
> I have had a report of someone trying to use two voodoo cards on a
> pegasos/ppc motherboard, and it freezing the kernel (2.4.22 kernel)
> 
> Is the tdfx fbdev supposed to be able to handle dual card setups, or not ?

No, the driver has a statically allocated fb_info. It will blow up.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
