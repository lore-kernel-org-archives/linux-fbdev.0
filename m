From: David Eger <eger@havoc.gtf.org>
Subject: Re: Need help !
Date: Mon, 14 Jun 2004 17:51:56 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040614215156.GA29145@havoc.gtf.org>
References: <40CDFABF.2020503@integrated-devices.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZzNG-0003nV-7f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 14:52:14 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZzNF-0007ol-TR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 14:52:13 -0700
Content-Disposition: inline
In-Reply-To: <40CDFABF.2020503@integrated-devices.com>
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
To: Srinivasa Deevi <sdeevi%integrated-devices.com@integrated-devices.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Jun 14, 2004 at 12:21:35PM -0700, Srinivasa Deevi wrote:

> do I need to add any fonts in fonts directory to see the any console 
> output through fbcon ? 

You shouldn't need to.

Have you set the fb_info[.*|.var.*|.fix.*] fields to reflect your hardware?
Try running 'fbset -i > stats.txt' blind from the console and affirm
that the settings are currect.

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
