From: jsimmons@pentafluge.infradead.org
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
 or address)
Date: Wed, 16 Jun 2004 17:38:43 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406161737500.14901@pentafluge.infradead.org>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
 <1087394174.8697.229.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BadR6-0004QL-34
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 09:38:52 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BadR5-0003Lj-N3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 09:38:51 -0700
In-Reply-To: <1087394174.8697.229.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Zilvinas Valinskas <zilvinas@gemtek.lt>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>


> The whole crap of tweaking the video modes when terminal size is
> changed with stty is not working properly imho. I don't like it, I
> don't like the way it's implemented and the drivers are not ready
> for it anyway since they lack a correct mode matching mecanism.
> 
> But that's one of James pet features so ...

There is a bug in stty. We should implement this in fbset as well. 


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
