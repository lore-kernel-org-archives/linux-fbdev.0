From: James Simmons <jsimmons@infradead.org>
Subject: Re: what are the various changes between fb-2.4
 and fb-2.5 ?
Date: Thu, 22 Aug 2002 12:19:44 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208221219030.9077-100000@maxwell.earthlink.net>
References: <20020814013745.GA11852@stargate.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hyUi-00027v-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 13:23:52 -0700
In-Reply-To: <20020814013745.GA11852@stargate.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Frame Buffer Devel Mailing List <linux-fbdev-devel@lists.sourceforge.net>


The removal of the console code from the low level drivers into fbcon.c.
See skeletonfb.c in the latest 2.5.X kernel to see the changes.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
