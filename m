From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Date: Tue, 20 May 2003 18:18:21 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030520171821.GA31761@suse.de>
References: <20030520155138.GA29450@suse.de> <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from deviant.impure.org.uk ([195.82.120.238] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19IAhM-0006E2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 May 2003 10:14:48 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Brett <generica@email.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, May 20, 2003 at 05:55:41PM +0100, James Simmons wrote:

 > > Wasn't the EDID stuff getting backed out anyways ?
 > Only in the VESA driver. Some people did have luck with the BIOS EDID info 
 > so I like to keep the BIOS call in there. 

That code runs way earlier than before we get to do any PCI quirks,
so fixing that one up could be interesting.

		Dave



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
