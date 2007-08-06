From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [RFC] Dynamic boot logo
Date: Mon, 6 Aug 2007 15:09:35 +0200
Message-ID: <20070806130935.GD354@enneenne.com>
References: <20070804134123.GA19707@enneenne.com>
	<46B6D374.9080001@cetrtapot.si> <20070806094552.GB354@enneenne.com>
	<46B7154E.6090705@cetrtapot.si>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1II2JK-000701-Ak for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 06:07:50 -0700
Received: from 81-174-11-161.static.ngi.it
	([81.174.11.161] helo=mail.enneenne.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1II2JJ-0003PJ-Nq
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 06:07:50 -0700
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50) id 1II2Et-00019m-VI
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 15:03:20 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>) id 1II2L1-00071x-Hy
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 15:09:35 +0200
Content-Disposition: inline
In-Reply-To: <46B7154E.6090705@cetrtapot.si>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, Aug 06, 2007 at 02:34:22PM +0200, hinko.kocevar@cetrtapot.si wrote:
> 
> I'm almost certain that your architecture (whatever it may be) uses I/O 
> and/or memory mapped memory for certain purposes. Best way to see how it 
> is done would be to look at the drivers that are used on your architecture.
> The bottom line is that ioremap() and friends could be used in 
> combination with ioread/iowrite and/or readb/writeb primitives to map 
> and later access the block of memory.

It's not so easy as may appear... using ioremap() & friends is not
enought since flash memories may have different interfaces to the
CPU. So the best way, IMHO, is accessing to flash memory by using the
MTD interface... however I need also a gunzip() procedure and a way to
decode BMP images in a compatibility manner for the current Linux's
logo support.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
