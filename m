From: Otto Solares <solca@guug.org>
Subject: Re: Changing modes with fbset
Date: Mon, 5 Jan 2004 19:44:14 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040106014414.GD442@guug.org>
References: <3FDBB97F.4070207@undead.cc> <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org> <20040106002822.GB442@guug.org> <1073349349.780.181.camel@gaston> <20040106010852.GC442@guug.org> <1073351384.781.202.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdgHl-0005Hd-73
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 17:45:33 -0800
Received: from [168.234.203.30] (helo=guug.galileo.edu)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdgHk-0006wX-RI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 17:45:32 -0800
Content-Disposition: inline
In-Reply-To: <1073351384.781.202.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Jan 06, 2004 at 12:09:44PM +1100, Benjamin Herrenschmidt wrote:
> 
> > 
> > Finding "coupled" cards could be as easy as checking if the fbdev
> > api returns the same busid for both fbdev's.
> 
> That would work as long as you don't have a single PCI chip providing
> 2 separate independant sets of heads but I agree this is very unlikely :)

I have not seen that cards but maybe is just a difference in the function
number from the busid.

Ben, you that know the internals of fbdev's, it would be difficult to
implement the busid stuff?  Maybe that info is already known by the
drivers somewhere... It could even work for sparcs with sbus or others
archs with differents buses, as the busid nomenclature is very standarized
i think.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
