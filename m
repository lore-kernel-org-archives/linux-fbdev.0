From: David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: fglrx + radeonfb leads to crashes?
Date: Wed, 17 Mar 2004 16:47:29 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <16472.61857.321235.329052@napali.hpl.hp.com>
References: <200403172018.i2HKI5E0002012@napali.hpl.hp.com>
	<1079569590.909.12.camel@gaston>
Reply-To: davidm@hpl.hp.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3lh8-0007D4-56
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 16:47:34 -0800
Received: from palrel13.hp.com ([156.153.255.238])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B3lh6-0004qh-MS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 16:47:32 -0800
In-Reply-To: <1079569590.909.12.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: davidm@hpl.hp.com, ajoshi@shell.unixbox.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

>>>>> On Thu, 18 Mar 2004 11:26:31 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> said:

  Benjamin> On Thu, 2004-03-18 at 07:18, David Mosberger wrote:

  >> I have a machine here with an ATI FireGL Z1 card.  It works fine
  >> with the ATI fglrx binary-only driver on 2.6.5-rc1.  However, if
  >> radeonfb is enabled and I try to stop the X server or switch away
  >> from it to another virtual console, then the screen display gets
  >> all messed up and the machine gets stuck.

  Benjamin> This is a known problem.

OK, that's good to know.

  Benjamin> I only have PPC machines so I can't experiment with it
  Benjamin> myself though.  The "fix" might be as simple as restoring
  Benjamin> MC_FB_LOCATION, MC_AGP_LOCATION and the various offset
  Benjamin> when re-initing the mode (the latest fbdev will trigger a
  Benjamin> mode restore & engine reset when switching out from a
  Benjamin> KD_GRAPHICS console).

OK.  If somebody had a patch to do these things, I could try it out
here.  The problem isn't really critical for me, so I'll probably just
live without radeonfb for now.

Thanks,

	--david


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
