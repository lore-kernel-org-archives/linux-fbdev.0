From: Ben Dooks <ben@fluff.org.uk>
Subject: Re: [PATCH] s3c2410fb - initialise device_driver .owner
Date: Mon, 10 Oct 2005 10:29:43 +0100
Message-ID: <20051010092943.GD30544@home.fluff.org>
References: <20051010010522.GA28414@home.fluff.org> <434A2515.3030708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOtyc-0006Hq-SE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 02:29:46 -0700
Received: from host-84-9-200-7.bulldogdsl.com ([84.9.200.7] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOtyk-0005LE-3u
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 02:29:55 -0700
Content-Disposition: inline
In-Reply-To: <434A2515.3030708@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ben Dooks <ben-linux@fluff.org>

On Mon, Oct 10, 2005 at 04:23:49PM +0800, Antonino A. Daplas wrote:
> Ben Dooks wrote:
> > Initialise the .owner field, so that if the
> > driver is built as a module, the system has
> > a link to the owner
> 
> Do you want this in 2.6.14? I'm not pushing patches right
> now unless they're critical.

It isn't critical, just getting things ready for the
next release.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
