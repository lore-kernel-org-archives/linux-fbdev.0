From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 18:23:39 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040428002339.GF22495@guug.org>
References: <1083107454.16544.42.camel@gaston> <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcrg-0002x0-5j
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:23:52 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcrf-0003Ri-Sm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:23:52 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Apr 28, 2004 at 12:21:13AM +0100, James Simmons wrote:
> Say two people are logged in. One on a serial console and another on the 
> framebuffer console. The person starts X fbdev from the serial console. 
> Ooops the fbcon user lost his console.

User logged in from serial console should not be a member
of the 'video' group.  PAM solved that a while ago with
/etc/security/group.conf assuming a well configured box.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
