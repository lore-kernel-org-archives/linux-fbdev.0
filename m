From: James Simmons <jsimmons@infradead.org>
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Date: Tue, 20 May 2003 17:55:41 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
References: <20030520155138.GA29450@suse.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19IAPY-0006BL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 May 2003 09:56:25 -0700
In-Reply-To: <20030520155138.GA29450@suse.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Brett <generica@email.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


> On Wed, May 21, 2003 at 12:14:50AM +1000, Brett wrote:
> 
>  > since 2.5.67-bk5. I have been unable to boot my laptop
>  > tonight, I finally traced it back to
>  > http://linux.bkbits.net:8080/linux-2.5/cset@1.1006
> 
> good work.
> 
>  > the video card is a chips and tech 65545
>  > i'd just like to know where to go from here, so that I can return to 
>  > booting with CONFIG_VIDEO_SELECT set 
> 
> Possibly the card's VGA BIOS has 'issues' with that call.

This is most likely the case. I just tested out the configuration he has 
and it worked for me. I'm running vga=5 right now. For teh majority it 
works but as usual there are some broken BIOS that cause issues. 

> Wasn't the EDID stuff getting backed out anyways ?

Only in the VESA driver. Some people did have luck with the BIOS EDID info 
so I like to keep the BIOS call in there. 



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
