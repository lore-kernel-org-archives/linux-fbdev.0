From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 18:59:55 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408EE5EB.6080705@undead.cc>
References: <Pine.LNX.4.44.0404272330480.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIbYd-0004DO-30
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:00:07 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BIbYc-00052p-KV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:00:07 -0700
In-Reply-To: <Pine.LNX.4.44.0404272330480.23153-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:

>This breaks the way linux works. It is up to the program to restore the 
>console. The same case for vgacon. The X server is the one that restores 
>the graphics hardware back to the VGA text mode. This patch would not ne 
>accepted for a stable release. 
>  
>
No, this would not be for the stable release.  But what I'm saying is 
that it's nice that a program cleans up after itself but we shouldn't 
rely on it.  Take resources like memory, file handles, sockets, etc.  
Most program release those resources when the shut down normally but 
what if they seg fault or exit unexpectedly?  The kernel cleans up after 
the process regardless.

So if a fb program restores the mode properly then we should do nothing 
but if it doesn't either because of a bad programming or an unexpected 
termination then we should reset the mode to what the user has selected 
for their console.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
