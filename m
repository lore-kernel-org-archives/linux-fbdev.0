From: Dave Jones <davej@redhat.com>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 20:50:09 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031017195008.GA11186@redhat.com>
References: <Pine.LNX.4.44.0310171751200.966-100000@phoenix.infradead.org> <20031017193447.41865.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAadx-0000Va-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 12:52:15 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAad4-0000NY-70
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 12:51:18 -0700
Content-Disposition: inline
In-Reply-To: <20031017193447.41865.qmail@web14911.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Otto Solares <solca@guug.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Carlo E. Prelz" <fluido@fluido.as>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Fri, Oct 17, 2003 at 12:34:47PM -0700, Jon Smirl wrote:
 > The people writing the AGP driver have added their ID's in the wrong format.
 > ATI wants the IDs in the two letter form, not family/chip.  The fbdev patch has
 > the ID's in correct form. The AGP driver should be the one that gets changed.

The ATI AGPGART driver _always_ used the format it currently does.
Since day 1, when it was written _by ATI engineers_
Your "ATI wants the IDs in two letter form" differs depending on which
ATI engineer you talk to it seems.

Personally, as agpgart maintainer, I couldn't care less what the defines
end up being, as long as it still compiles afterwards.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
