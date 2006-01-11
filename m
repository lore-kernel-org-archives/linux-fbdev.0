From: maximilian attems <maks@sternwelten.at>
Subject: Re: Bug#347186: linux-image-2.6.14-2-alpha-generic: garbled Matrox framebuffer
Date: Wed, 11 Jan 2006 11:28:27 +0100
Message-ID: <20060111102827.GF7691@nancy>
References: <20060109090849.GB3481@tennyson.dodds.net> <20060109093517.GA23253@localhost.localdomain> <20060109105146.GE3481@tennyson.dodds.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwdDh-0000cs-A1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 02:28:45 -0800
Received: from baikonur.stro.at ([213.239.196.228])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EwdDg-0006WG-Pg
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 02:28:45 -0800
Content-Disposition: inline
In-Reply-To: <20060109105146.GE3481@tennyson.dodds.net>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Steve Langasek <vorlon@debian.org>, 347186@bugs.debian.org
Cc: Sven Luther <sven.luther@wanadoo.fr>, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

dear adaplas,

could you please take a look at this matroxfb debian bug report:
http://bugs.debian.org/347186

On Mon, 09 Jan 2006, Steve Langasek wrote:

<snipp>
> > > Sigh, can't get a break with alpha kernel support around here.  After
> > > upgrading to 2.6.14 (from 2.4.27), the Matrox framebuffer no longer works
> > > correctly on my alpha with a Matrox Millenium II.  The matroxfb_base module
> > > loads without error, but gives me corrupt video output only.
> 
> > Try turning off acceleration.
> 
> Doesn't make a difference.
> 
> What did make a difference was, after googling, loading fbcon manually
> before loading matroxfb_base.  Given that I'm loading matroxfb_base by hand
> (/etc/modules), it's not getting loaded via udev or anything like that, it
> seems to me that it's my responsibility to load fbcon by hand as well, but
> it's still something of an unexpected change from 2.4.  It might be nice to
> have these modules all autoloaded by something, but it's not strictly
> necessary, and some users may not want the framebuffer activated
> automatically?
> 
> The other issue (and the first thing I was trying to get work, which led me
> to believe the fb was completely broken) is that, even though console works
> on the framebuffer now, X does not.  This breakage corresponds to the kernel
> upgrade, not to any changes in X, so still looks like a kernel bug to me.
> 
> If I turn off "UseFBDev" in my xorg.conf, X displays correctly.  I haven't
> poked yet to see what this does performance-wise.
> 
> -- 
> Steve Langasek                   Give me a lever long enough and a Free OS
> Debian Developer                   to set it on, and I can move the world.
> vorlon@debian.org                                   http://www.debian.org/

2.6.15 has matroxfb patches, did it make a difference on your box?


-- 
maks


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
