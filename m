From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH] fix radeonfb panning and make it play nice with copyarea()
Date: Thu, 17 Jun 2004 01:35:40 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617053540.GA23365@havoc.gtf.org>
References: <20040616182415.GA8286@middle.of.nowhere> <20040617022100.GA11774@havoc.gtf.org> <20040617051931.GA1378@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BapYy-0006TO-Ne
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:35:48 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BapYy-0006dI-Eq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:35:48 -0700
Content-Disposition: inline
In-Reply-To: <20040617051931.GA1378@middle.of.nowhere>
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
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, jsimmons@infradead.org

Dear Andrew,

While the patch I sent Juriaan didn't work for him, it is a needed bugfix.
Please apply to -mm.  I'm continuing to try to track down his issue...

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
