From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this one works ;-)
Date: Wed, 28 Apr 2004 18:38:52 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040429003852.GB24584@guug.org>
References: <1083194942.21436.96.camel@gaston> <Pine.LNX.4.44.0404290106150.3125-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIzaD-0001W4-Db
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 17:39:21 -0700
Received: from guug.org ([168.234.203.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIzaD-0002uh-2I
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 17:39:21 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404290106150.3125-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Apr 29, 2004 at 01:26:57AM +0100, James Simmons wrote:
> I plan to put in sysfs a way to cat a string to
> change the resolution using modedb.

nice!.

> Then you add to the modedb. Right now we lack that functionalty.

Is not modedb marked __init so it's lost to userspace?  If not how
can i use modedb from userspace?

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
