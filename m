From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Wed, 14 Jan 2004 22:16:43 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040114211643.GA6793@iliana>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net> <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net> <20040113160221.GA12752@iliana> <20040114211246.GA31567@scowler.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgsNw-0002m3-Jh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 13:17:08 -0800
Received: from smtp3.wanadoo.fr ([193.252.22.28] helo=mwinf0302.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AgsNw-0006Lq-8Q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 13:17:08 -0800
Content-Disposition: inline
In-Reply-To: <20040114211246.GA31567@scowler.net>
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
To: Clint Adams <schizo@debian.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, 226973@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Jan 14, 2004 at 04:12:46PM -0500, Clint Adams wrote:
> > You would dump all the possible registers, and see which one is
> > different. Enabling debugging in the glint driver would also do. You can
> > safely run no-accel on these for the tests, as this is definitively not
> > an accel issue, but a video out/ramdac one.
> 
> Here's the NoAccel version.

This will not help, X things everything is ok, it is just the graphic
card output which is problematic. No way to find it in the log, you have
to look at the way the graphic output registers are programmed. 

Look at the pm2_dac.c stuff.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
