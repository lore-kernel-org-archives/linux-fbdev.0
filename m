From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 12 Mar 2003 05:33:08 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047418384.1100.5.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111537420.23668-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18srPu-0003Dh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 13:36:10 -0800
In-Reply-To: <Pine.LNX.4.44.0303111537420.23668-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-11 at 23:49, James Simmons wrote:
> > Anyway, I need help in testing the code (especially the Detailed
> > Information part).  Just apply the attached patch, disable Enhanced Disk
> > Driver support (under Processor Type and Features), and enable EDID
> > support (under Graphics option).  Finally, add the following line to the
> > fbdev driver that you use (anywhere, but a good place is the init code):
> 
> Diable Enhanced Disk support :-( I have a few suggestions. One we add a 
> pointer to struct screen_info that points to the edid information. We can 
> use phys_to_virt to translate that address into virtual memory. I can 
> create a patch today and store it in the BK tree. 

I think I found a chunk of around 500 bytes between INITRD and EDD, so
we can squeeze in EDID in there :-)  Although I'm confident on this,
I'll feel better if someone who boots with initrd can test it.

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
