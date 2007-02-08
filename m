From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/10] ps3: AV Settings Driver
Date: Thu, 8 Feb 2007 21:30:14 +0100
Message-ID: <20070208203014.GB2579@lst.de>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702081458190.19437@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFFvM-0003fR-RZ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 12:31:21 -0800
Received: from verein.lst.de ([213.95.11.210] helo=mail.lst.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFFvC-00024K-7H
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 12:31:20 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0702081458190.19437@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Thu, Feb 08, 2007 at 02:58:31PM +0100, Geert Uytterhoeven wrote:
> Add the PS3 AV Settings Driver.
> 
> The AV Settings driver is used to control Audio and Video settings.
> It communicates with the policy manager through the virtual uart.

please don't use kernel_thread for new code, but rather kthread_create/
ktread_run.  And check the possible errors it can return :)

Using the kthread infrastructure also means you'll have to redo your
synchronisation scheme as it doesn't work very well with this use
of semaphores.  But that's a good thing as these useages are not
easily parseable for most kernel hackers despite beeing tought in
OS101 :)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
