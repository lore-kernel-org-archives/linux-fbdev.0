From: James Simmons <jsimmons@infradead.org>
Subject: Re: Kernel oops with current fbdev code
Date: Wed, 2 Apr 2003 23:32:18 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304022331470.3919-100000@phoenix.infradead.org>
References: <3E705C13.7000103@winischhofer.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 190qms-0000RT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 14:32:55 -0800
In-Reply-To: <3E705C13.7000103@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net


> James, Tony, list,
> 
> the SiS X driver tries to communicate with sisfb during server startup. 
> This is done by fopen()-ing "/dev/fb0" through "/dev/fb7". If the open 
> succeeds, a SiS-specific ioctl is done, which is checked to originate 
> from sisfb and eventually processed. (This is by the way the same way 
> the fbdev X driver probes for available framebuffer devices.)
> 
> If no framebuffer is available, the fopen()-calls usually fail. If 
> another framebuffer (other than sisfb) is answering, the ioctl either 
> fails or does not identify correctly. So far so good.
> 
> Under 2.5.63 and 2.5.64 (haven't tried older 2.5 kernels), no matter 
> whether using James' latest patch or not, the fopen()-call causes an 
> Oops as soon as "/dev/fb3" is probed.
> 
> Without having looked at the relevant code, I suspect it something to do 
> with the strange fact, that /dev/fbX is not "translated" to fbX as in 
> 2.4, but fb0, fb32, fb64 - and at fb128 (which is logically the 
> "translation" of /dev/fb3) it goes boom.

I have a fix in the fbdev BK tree. It will be pushed to linus soon.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
