From: Egbert Eich <eich@XFree86.Org>
Subject: Re: [forum] Re: Announcement: Modification to the base XFree86(TM) license.
Date: Fri, 30 Jan 2004 20:25:40 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <16410.44981.237411.858354@xf11.fra.suse.de>
References: <20040129115838.A70069@xfree86.org>
	<1075423804.12536.28.camel@gaston>
	<16410.33783.236964.200047@xf11.fra.suse.de>
	<20040130173238.GA8599@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AmeJN-0007dk-8b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 11:28:17 -0800
Received: from ns.suse.de ([195.135.220.2] helo=Cantor.suse.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AmeJM-0002em-LL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 11:28:16 -0800
In-Reply-To: sven.luther@wanadoo.fr wrote on Friday, 30 January 2004 at 18:32:38 +0100 
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
To: forum@XFree86.Org
Cc: devel@XFree86.Org, linux-fbdev-devel@lists.sourceforge.net

Sven Luther writes:
 > 
 > Maybe a decision on both parts on this would be ok ? XFree86 could make
 > sure the licence of the driver code would not conflict with the GPL,
 > keeping the old one for example, and the fbdev driver authors would
 > dual-licence the code, both GPL and the old xfree86 licence would do
 > just fine. Benjamin, what do you think about this ?
 > 
 > BTW, CCing this to the linux-fbdev mailing list.
 > 

Yes, a personal agreement between driver developers would also work.
However they tend to change and other people will make contributions
who all would have to agree also. 
I don't know if a general dual license agreement in the kernel 
file header would be possible. Also it could get removed once 
the author changes. Just like the license in the XFree86 driver 
could be amended. 
Doing this now for existing fbdev driver would involve to ask
anyone who has contributed little more than a typo fix.

Egbert.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
