From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Thu, 11 Mar 2004 10:13:34 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040311101334.414624d1.akpm@osdl.org>
References: <20040311095039.07a5c857.akpm@osdl.org>
	<Pine.LNX.4.44.0403111804410.5794-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1Uye-0001IM-8W
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 10:32:16 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1Ugt-000897-4U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 10:13:55 -0800
In-Reply-To: <Pine.LNX.4.44.0403111804410.5794-100000@phoenix.infradead.org>
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
Cc: benh@kernel.crashing.org, kronos@kronoz.cjb.net, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

James Simmons <jsimmons@infradead.org> wrote:
>
> 
>  Various fixes and enhancements to the monitor hardware detection code.
>  The only driver that uses it is the radeon driver. Give it a try before 
>  you apply it.

None of my test boxes have radeon.   Your comment makes me worry about the
readiness of this code.   Please say reassuring things to me ;)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
