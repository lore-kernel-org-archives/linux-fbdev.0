From: Thomas Jahns <Thomas.Jahns@epost.de>
Subject: Re: State of pm3fb driver
Date: Tue, 5 Oct 2004 21:06:04 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041005190604.GA11481@mercury.jahnsnet.de>
References: <1gl6uux.9w928rity4liM%dolbeaur@club-internet.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEuh1-0006aJ-Qj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 12:09:47 -0700
Received: from web.epost.de ([193.28.100.152] helo=mail.epost.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEugq-0007Yg-SH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 12:09:47 -0700
Received: from mercury.jahnsnet.de (149.225.14.97) by mail.epost.de (7.2.033.1)
        id 4160B6CD000454E7 for linux-fbdev-devel@lists.sourceforge.net; Tue, 5 Oct 2004 21:01:20 +0200
Received: from mercury (tjahns@localhost [127.0.0.1])
	by mercury.jahnsnet.de (8.13.1/8.13.1/Debian-12) with ESMTP id i95J64VL012224
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 5 Oct 2004 21:06:04 +0200
Content-Disposition: inline
In-Reply-To: <1gl6uux.9w928rity4liM%dolbeaur@club-internet.fr> (from dolbeaur@club-internet.fr on Tue, Oct 05, 2004 at 15:01:23 +0200)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format="Flowed"; delsp="Yes"; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

On 10/05/04 15:01:23, Romain Dolbeau wrote:
> Noone ever updated pm3fb to works with 2.6.x, so as you noticed,
> it doesn't work. There was a lot of changes for FB driver in 2.6.x,
> so the driver is in need of a complete rewrite.

Is there a sufficiently complete description of these changes to  
"mechanically" port them to the existing driver? I'd certainly try that  
because it seems to me the changes to atyfb are just as hard to port to  
the Macintosh. I think Benjamin Herrenschmidt is working on the latter  
already but I'm unaware as to how much progress he has made.

> You can try using the likely working (but surely slow) offb, the
> generic OpenFirmware driver. Or (down|up)grade to 2.4.x.

Unfortunately offb doesn't work for me (it might be trying to use the  
builtin control graphics (which is currently at 0MB VRAM), how would I  
find out?).

Downgrading to 2.4.x isn't really an option because I want to use XFS.  
I just don't want to be stuck with control graphics for my MacOS  
installation and I also don't want to play around with the monitor  
connection because Linux supports nothing but controlfb of the  
alternatives I've tried.

Thomas Jahns
-- 
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
