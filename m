From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: logos work/apply when?
Date: Sat, 14 Jul 2007 06:49:58 +0800
Message-ID: <1184366998.4616.0.camel@daplas>
References: <20070712130822.a8269fe0.rdunlap@xenotime.net>
	<1184284251.4566.3.camel@daplas>
	<20070713110629.d6eccbd4.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9Txf-0004GL-9n for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 15:50:07 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9Txd-0000qc-Oy
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 15:50:07 -0700
Received: by py-out-1112.google.com with SMTP id a25so1114417pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 13 Jul 2007 15:50:05 -0700 (PDT)
In-Reply-To: <20070713110629.d6eccbd4.rdunlap@xenotime.net>
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2007-07-13 at 11:06 -0700, Randy Dunlap wrote:
> On Fri, 13 Jul 2007 07:50:51 +0800 Antonino A. Daplas wrote:
> 
> > On Thu, 2007-07-12 at 13:08 -0700, Randy Dunlap wrote: 

> So when all 3 of these are enabled:
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> is the one with most depth that is supported by the fb driver used?

Yes.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
