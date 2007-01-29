From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Mon, 29 Jan 2007 16:14:43 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701291611300.19906@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<200701260513.24010.arnd@arndb.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBYDf-0005BF-JV for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 07:14:55 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBYDd-0002D1-Rc
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 07:14:55 -0800
In-Reply-To: <200701260513.24010.arnd@arndb.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>

On Fri, 26 Jan 2007, Arnd Bergmann wrote:
> On Thursday 25 January 2007 18:48, Geert Uytterhoeven wrote:
> > +#ifdef PS3AV_DEBUG
> > +#define DPRINTK(fmt, args...) \
> > +	do { printk("ps3av " fmt, ## args); } while (0)
> > +#else
> > +#define DPRINTK(fmt, args...) do { } while (0)
> > +#endif
> 
> You should probably use the provided pr_debug or (better) dev_dbg
> macros to do that now.

Except that it's difficult to get a struct device * in drivers/ps3/ps3av_cmd.c.
And I prefer not to make ps3av_dev (which is currently static) global.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
