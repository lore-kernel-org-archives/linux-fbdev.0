From: Andrew Morton <akpm@osdl.org>
Subject: Re: fb.h header fix.
Date: Tue, 3 Feb 2004 18:03:52 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040203180352.364da230.akpm@osdl.org>
References: <Pine.LNX.4.44.0402040109570.11656-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoCMz-0000kq-JU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Feb 2004 18:02:25 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoCMz-00074X-1n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Feb 2004 18:02:25 -0800
In-Reply-To: <Pine.LNX.4.44.0402040109570.11656-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

James Simmons <jsimmons@infradead.org> wrote:
>
> The XFree86 fbdev server build breaks with the current fb.h. This patch 
>  fixes that.

The previous version of this patch caused the ppc64 build to fail.  Did
that get addressed?


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
