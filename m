From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: URGENT: status of atyfb
Date: Wed, 04 Aug 2004 07:25:40 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1091568340.1900.14.camel@gaston>
References: <1091417497.7393.63.camel@gaston>
	 <1091424085.7387.68.camel@gaston>  <200408032257.51111.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bs6nG-0002W3-5n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 14:25:58 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1Bs6nF-0007q1-Nq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 14:25:58 -0700
In-Reply-To: <200408032257.51111.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>


> Hi, I do not have any information or hardware about PPC. Should it own 
> something like OpenFirmware? In this case it is possible to read clock 
> information from this.

On some models, yes, on some no. Older machines have a firmware that
won't tell you anything, the MacOS driver back then was hard coding the
values.

Anyway, the clocks are ok, apparently (maybe not the engine one though,
see later), the problem was that the DLL magic was reverted for the
LT-G, plus some minor issues with the driver blowing up on non-BIOS
machines that I can fix.

The engine tends to lockup quickly though, I'll do experiments.

> I found, that we change a little behaviour. Please give a try for this 
> patch...

Your patch seem to address the DLL issue, I did that too, fixes the display,
I'll toy around and let you know.

Also, when just dropping the existing driver into the current linus tree, the
cursor code is blowing up, I don't know why yet, I suppose some changes to the
common code in the fbdev tree. I'll have a look.

I really want this new driver to be sent upstream ASAP. What I may do is once
I get it working well enough, I'll send it to andrew for the -mm tree and
leave it there for a while to get it properly tested.

Ben.



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
