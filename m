From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Mon, 15 Sep 2003 17:55:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915155540.GA1980@dreamland.darkstar.lan>
References: <20030910212700.GA12271@dreamland.darkstar.lan> <000301c37b1c$40b7e480$ba17b1cb@bom>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yvj0-0001oZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 08:57:14 -0700
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yviz-0006D5-TP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 08:57:14 -0700
Content-Disposition: inline
In-Reply-To: <000301c37b1c$40b7e480$ba17b1cb@bom>
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
To: Tony <adaplas@hotpop.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Sep 15, 2003 at 07:59:37AM +0800, Tony ha scritto: 
> Regarding your problem about re-centering the screen, why not check the
> modeline used by XFree86 and by radeonfb? 

This is what I did. The problem  is not if modelines are different (yes,
they are) but  _why_ they differ. Both radeonfb and Xfree  are using the
same EDID block and have the same VESA table...

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
