From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] New radeonfb fork
Date: 11 Apr 2003 10:02:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1050048156.573.14.camel@zion.wanadoo.fr>
References: <56639.80.180.244.42.1049891938.squirrel@squirrel.autistici.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-6-197.abo.wanadoo.fr ([80.11.137.197] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193tTG-0000E1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Apr 2003 01:01:14 -0700
In-Reply-To: <56639.80.180.244.42.1049891938.squirrel@squirrel.autistici.org>
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
To: torn@autistici.org
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2003-04-09 at 14:38, torn@autistici.org wrote:

> During the kernel compilation  I encountered some problems due tu missing
> #defines. In detail, the probles was in the replacement of
> PCI_DEVICE_ID_PDC_1841 in .._PDC_ADMA100 and of .._CMD_680 in .._SII_680.
> Adding the old lines solved the problem. Maybe you are using a kernel
> patch that modifies that code, and you did the diff against that sources.
> Or (more probably) there is another logic reason I don't see.

Yah, my patch brings pci_ids.h to 2.4.21 version, I'll fix that in
the next patch release

> Another thing I must tell you is that with your driver, but also with the
> old radeonfb and with the xfree86 driver, some strange screen flicker
> occours sometimes. When this happens I see several undefined horizontal
> lines all over the LCD screen. Changing video mode a couple of times makes
> the screen return to normality. I guessed that this behavoir is linked to
> pixclock changes (changing the pixclock value via fbset 2 or 3 times makes
> the screen flicker, another couple of pixclock changes make everyting
> return to normality). Many people with notebooks with mobility M6s graphic
> cards reported this problem. With windows this never happens. This is VERY
> annoying.
> I hope I can help the driver developement, if you want me to try something
> in particular, just tell me.

Looks like the PLL isn't locking properly. The latest driver I'll
release (today hopefully) includes a workaround that _might_ help

> Paride
> torn@autistici.org
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
